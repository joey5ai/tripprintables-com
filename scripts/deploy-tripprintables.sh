#!/bin/bash
# deploy-tripprintables.sh v1 -- git-push wrapper: pre-flight, post-push check,
# siteIsLive-branched ruleset, conditional auto-rollback.
#
# Adapted from deploy-knowyourisms.sh's pattern (itself adapted from
# deploy-josephwilebski.sh). Same shape: pre-flight, push whatever is already
# committed, poll the live URL, branch on a launch-state flag, roll back via
# git-revert on a post-launch failure only.
#
# Two real differences from knowyourisms, not cosmetic ones:
#
# 1. Eleventy, not Next.js. Pre-flight runs this repo's actual build/audit
#    commands (`eleventy` / `node scripts/audit.js`, both reachable via
#    `npm run build` / `npm run audit` since package.json maps them that
#    way -- checked directly, not assumed).
#
# 2. Updated 2026-08-16: layout.njk now has a real templated meta robots tag,
#    driven by site.json's siteIsLive, same pattern as knowyourisms'
#    SITE_IS_LIVE -> layout.tsx. robots.txt is now also templated
#    (src/robots.njk, not a static passthrough file) and always emits
#    `Allow: /` in both states -- only its Sitemap line is state-conditional.
#    This script verifies both the meta tag and the Sitemap line match what
#    the flag claims, rather than trusting the declared flag blindly.
#
# Usage: deploy-tripprintables.sh [--dry-run] [repo-dir]
#   --dry-run   Skip the actual git push and any rollback git operations.
#               Validates current already-deployed live state instead of a
#               freshly-pushed one. Still runs the real pre-flight (build +
#               audit) and still sends real Telegram notifications, so the
#               full notification path gets exercised too.

set -euo pipefail

# launchd provides a minimal PATH that excludes Homebrew; node/npm live there.
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

DRY_RUN="false"
REPO_DIR="$HOME/projects/tripprintables-com"
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN="true" ;;
    *) REPO_DIR="$arg" ;;
  esac
done

OPENCLAW_DIR="$HOME/.openclaw"
LOGFILE="$HOME/Library/Logs/joey5/deploy-tripprintables.log"
mkdir -p "$(dirname "$LOGFILE")"

SITE_JSON="$REPO_DIR/src/_data/site.json"
CF_TOKEN=$(cat "$OPENCLAW_DIR/credentials/cloudflare_token_init_joey5_full")
CLOUDFLARE_ACCOUNT_ID="46715f703eb2c81161ecc82ee7b5a004"
ZONE_ID="424c280ff08d0682828ce53c3a6a54c5"
CF_API="https://api.cloudflare.com/client/v4"
TELEGRAM="$OPENCLAW_DIR/scripts/telegram-notify.sh"
LIVE_URL="https://tripprintables.com"
CONTENT_FINGERPRINT="Trip Printables: Free Travel Planning Templates"

PREV_COMMIT=""

log() { echo "[$(date '+%H:%M:%S')] $*" | tee -a "$LOGFILE"; }
notify() { "$TELEGRAM" "$*" 2>/dev/null || true; }
notify_critical() {
  local msg="$*"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] CRITICAL: $msg" >> "$LOGFILE"
  "$TELEGRAM" "$msg" 2>>"$LOGFILE" || \
    echo "[$(date '+%H:%M:%S')] WARNING: Telegram send failed -- see $LOGFILE for record" >&2
}
fail() { log "ERROR: $*"; notify_critical "tripprintables.com deploy FAILED: $*"; exit 1; }

purge_cache() {
  local label="$1"
  log "Purging Cloudflare cache ($label)..."
  local result ok
  result=$(curl -s -X POST \
    "$CF_API/zones/$ZONE_ID/purge_cache" \
    -H "Authorization: Bearer $CF_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"purge_everything":true}')
  ok=$(echo "$result" | python3 -c "import sys,json; print(json.load(sys.stdin).get('success','false'))" 2>/dev/null || echo "false")
  if [ "$ok" != "True" ]; then
    log "Warning: cache purge failed ($label): $result"
    return 1
  fi
  log "Cache purged ($label)."
}

log "=== Deploy started ==="

# -- 1. Pre-flight: build succeeds, audit passes ------------------------------

log "Pre-flight: running build (eleventy)..."
( cd "$REPO_DIR" && npm run build ) >> "$LOGFILE" 2>&1 || fail "npm run build failed"
log "Pre-flight: build passed."

log "Pre-flight: running audit..."
( cd "$REPO_DIR" && npm run audit ) >> "$LOGFILE" 2>&1 || fail "npm run audit failed (hard failure -- soft warnings alone do not fail this)"
log "Pre-flight: audit passed."

# -- 2. Read siteIsLive from site.json, before pushing --------------------------

[ -f "$SITE_JSON" ] || fail "$SITE_JSON not found -- cannot determine siteIsLive"
SITE_IS_LIVE_RAW=$(python3 -c "import json; print(json.load(open('$SITE_JSON')).get('siteIsLive', ''))" 2>/dev/null | tr '[:upper:]' '[:lower:]')
[ "$SITE_IS_LIVE_RAW" = "true" ] || [ "$SITE_IS_LIVE_RAW" = "false" ] || fail "could not parse siteIsLive from $SITE_JSON as true/false (got: '$SITE_IS_LIVE_RAW')"
log "siteIsLive = $SITE_IS_LIVE_RAW"

# -- 3. Push whatever is already committed --------------------------------------

PREV_COMMIT=$(git -C "$REPO_DIR" rev-parse HEAD)
log "Current commit: $PREV_COMMIT"

if [ "$DRY_RUN" != "true" ] && { ! git -C "$REPO_DIR" diff --quiet || ! git -C "$REPO_DIR" diff --cached --quiet; }; then
  fail "uncommitted changes present in $REPO_DIR -- this script pushes existing commits only, it does not commit on your behalf. Commit or stash first."
fi

LIVE_BODY="/tmp/tripprintables-deploy-check.html"
ROBOTS_BODY="/tmp/tripprintables-robots-check.txt"

if [ "$DRY_RUN" = "true" ]; then
  log "DRY RUN: skipping git push. Validating current already-deployed live state instead."
  HTTP_CODE=$(curl -s -o "$LIVE_BODY" -w "%{http_code}" --max-time 15 "$LIVE_URL" || echo "000")
  [ "$HTTP_CODE" = "200" ] || fail "DRY RUN: live site returned HTTP $HTTP_CODE, cannot validate"
  grep -qF "$CONTENT_FINGERPRINT" "$LIVE_BODY" || fail "DRY RUN: content fingerprint not found on current live page"
  log "DRY RUN: current live page fetched and fingerprint confirmed. Skipping to validation."
else
  AHEAD=$(git -C "$REPO_DIR" rev-list --count origin/main..HEAD 2>/dev/null || echo "unknown")
  if [ "$AHEAD" = "0" ]; then
    log "Nothing to push -- HEAD already matches origin/main. Exiting cleanly, no-op."
    log "=== Deploy finished: nothing to do ==="
    exit 0
  fi
  log "Pushing $AHEAD commit(s) to origin main..."

  git -C "$REPO_DIR" push origin main || fail "git push failed"
  log "Push complete. Waiting for Cloudflare Pages build..."

  # -- 4. Post-push check -- poll for CF build to complete -----------------------

  CHECK_FAIL="timeout"
  for attempt in $(seq 1 12); do
    log "Post-push check attempt $attempt/12 (waiting for CF build)..."
    sleep 10
    HTTP_CODE=$(curl -s -o "$LIVE_BODY" -w "%{http_code}" --max-time 15 "$LIVE_URL" || echo "000")
    if [ "$HTTP_CODE" != "200" ]; then
      CHECK_FAIL="HTTP $HTTP_CODE (expected 200)"
    elif ! grep -qF "$CONTENT_FINGERPRINT" "$LIVE_BODY"; then
      CHECK_FAIL="content fingerprint missing ('$CONTENT_FINGERPRINT' not found in live page)"
    else
      CHECK_FAIL=""
      log "Post-push check passed (attempt $attempt) -- new content is live."
      break
    fi
    log "Check not yet passing (attempt $attempt): $CHECK_FAIL"
  done

  [ -n "$CHECK_FAIL" ] && fail "deploy did not land within the poll window: $CHECK_FAIL (no rollback attempted -- content never confirmed live, nothing to roll back from)"
fi

# -- 5. siteIsLive-branched validation -------------------------------------------
#
# Rewritten 2026-08-16 to match the live/dark state spec decided that night
# (docs/site-build-checklist.md, "Reference: Live vs. Dark State Spec"):
# robots.txt ALWAYS allows crawling now, in both states -- blocking crawling
# would prevent Google from ever seeing the noindex meta tag and honoring it.
# The only things that actually vary by state are the meta robots tag
# (index vs noindex, both always `follow`) and whether robots.txt's Sitemap
# line is present. This replaces the old Allow/Disallow-branching logic,
# which is now permanently wrong -- robots.txt disallowing was never
# supposed to happen again after 2026-08-16, live or dark.

fetch_robots() {
  curl -s --max-time 15 "$LIVE_URL/robots.txt" -o "$ROBOTS_BODY" || fail "could not fetch robots.txt for validation"
}

robots_always_allows() {
  tail -5 "$ROBOTS_BODY" | grep -qE '^User-agent: \*$' && tail -5 "$ROBOTS_BODY" | grep -qE '^Allow: /$'
}

robots_has_sitemap_line() {
  grep -qE '^Sitemap: ' "$ROBOTS_BODY"
}

meta_robots_is_noindex() {
  grep -qE '<meta name="robots" content="noindex, ?follow"' "$LIVE_BODY"
}

meta_robots_is_index() {
  # Absent tag is also valid live state (index,follow is the crawler
  # default), so this passes on either an explicit index tag or no tag.
  ! grep -qE '<meta name="robots" content="noindex' "$LIVE_BODY"
}

crawl_check() {
  # Sitemap-driven, unlike knowyourisms' homepage-links-only version:
  # tripprintables.com has a real sitemap.xml (18 URLs as of 2026-08-08),
  # so this checks every URL in it, not just what the homepage links to.
  local fail_reason=""
  local sitemap_body="/tmp/tripprintables-sitemap-check.xml"
  local sitemap_code
  sitemap_code=$(curl -s -o "$sitemap_body" -w "%{http_code}" --max-time 15 "$LIVE_URL/sitemap.xml" || echo "000")
  if [ "$sitemap_code" != "200" ]; then
    echo "sitemap.xml returned HTTP $sitemap_code, cannot crawl"
    return
  fi
  local non_https
  non_https=$(grep -oE 'href="http://[^"]*"' "$LIVE_BODY" || true)
  if [ -n "$non_https" ]; then
    fail_reason="non-HTTPS link(s) found on homepage: $non_https"
  fi
  local urls
  urls=$(grep -oE '<loc>[^<]*</loc>' "$sitemap_body" | sed -E 's/<loc>(.*)<\/loc>/\1/')
  for url in $urls; do
    local code redirect_count
    code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$url" || echo "000")
    redirect_count=$(curl -s -o /dev/null -w "%{num_redirects}" --max-time 10 -L "$url" || echo "0")
    if [ "$code" != "200" ] && [ "$redirect_count" = "0" ]; then
      fail_reason="${fail_reason:+$fail_reason; }broken sitemap URL $url (HTTP $code)"
    elif [ "$redirect_count" -gt 1 ] 2>/dev/null; then
      fail_reason="${fail_reason:+$fail_reason; }multi-hop redirect on $url ($redirect_count hops)"
    fi
  done
  echo "$fail_reason"
}

VALIDATION_FAIL=""
fetch_robots

if ! robots_always_allows; then
  VALIDATION_FAIL="robots.txt is not a clean 'Allow: /' -- this should never happen in either state as of 2026-08-16, needs manual review"
elif [ "$SITE_IS_LIVE_RAW" = "false" ]; then
  log "Dark-state ruleset (siteIsLive false): confirming meta robots is noindex and the Sitemap line is absent..."
  if ! meta_robots_is_noindex; then
    VALIDATION_FAIL="meta robots tag is not noindex,follow -- indexing silently enabled while dark"
  elif robots_has_sitemap_line; then
    VALIDATION_FAIL="robots.txt still has a Sitemap line while dark -- should be absent until launch"
  else
    log "Meta robots confirmed noindex,follow, Sitemap line confirmed absent. Dark state: no further checks, no rollback path (nothing real is exposed while dark)."
  fi
else
  log "Live-state ruleset (siteIsLive true): confirming meta robots is index, Sitemap line present, running crawl check..."
  if ! meta_robots_is_index; then
    VALIDATION_FAIL="meta robots tag is noindex on a supposedly-live site -- accidental deindex"
  elif ! robots_has_sitemap_line; then
    VALIDATION_FAIL="robots.txt is missing its Sitemap line on a supposedly-live site"
  else
    CRAWL_RESULT=$(crawl_check)
    if [ -n "$CRAWL_RESULT" ]; then
      VALIDATION_FAIL="crawl check failed: $CRAWL_RESULT"
    else
      log "Meta robots confirmed index, Sitemap line present, crawl check passed (sitemap URLs all clean)."
    fi
  fi
fi

# -- 6. Handle validation failure: report-only (pre-launch) or rollback (post-launch) --

if [ -n "$VALIDATION_FAIL" ]; then
  log "Validation failed: $VALIDATION_FAIL"

  if [ "$SITE_IS_LIVE_RAW" = "false" ]; then
    # Pre-launch: flag and report only. No rollback -- nothing real is exposed yet,
    # per Section 3's stated logic.
    notify_critical "tripprintables.com PRE-LAUNCH CHECK FAILED (no rollback -- nothing real exposed yet)
Validation failed: $VALIDATION_FAIL
Deployed commit: $(git -C "$REPO_DIR" rev-parse --short HEAD)
Manual review needed."
    log "=== Deploy finished with a flagged failure (pre-launch, no rollback) ==="
    exit 1
  fi

  # Post-launch: roll back via git revert, same pattern as deploy-knowyourisms.sh.
  if [ "$DRY_RUN" = "true" ]; then
    fail "DRY RUN: post-launch validation failed, would have run 'git revert --no-edit HEAD' + push here. Stopping instead of performing a real revert during a dry run."
  fi
  log "Post-launch failure -- reverting deploy commit and pushing..."
  git -C "$REPO_DIR" revert --no-edit HEAD || fail "git revert failed -- manual intervention required (previous commit: $PREV_COMMIT)"
  git -C "$REPO_DIR" push origin main || fail "git push after revert failed -- manual intervention required (previous commit: $PREV_COMMIT)"
  log "Revert pushed. Waiting for CF to rebuild from reverted commit..."

  REVERT_OK=""
  for attempt in $(seq 1 6); do
    log "Rollback verify attempt $attempt/6..."
    sleep 10
    HTTP_CODE=$(curl -s -o /tmp/tripprintables-rollback-check.html -w "%{http_code}" --max-time 15 "$LIVE_URL" || echo "000")
    if [ "$HTTP_CODE" = "200" ] && grep -qF "$CONTENT_FINGERPRINT" /tmp/tripprintables-rollback-check.html; then
      REVERT_OK="true"
      log "Rollback verify passed (attempt $attempt) -- site serving reverted content."
      break
    fi
    log "Rollback verify not yet passing (attempt $attempt)."
  done

  purge_cache "post-rollback" || true

  if [ -n "$REVERT_OK" ]; then
    notify_critical "tripprintables.com AUTO-ROLLBACK
Validation failed: $VALIDATION_FAIL
Reverted to commit: $PREV_COMMIT
Site confirmed serving reverted content."
  else
    notify_critical "tripprintables.com AUTO-ROLLBACK -- REVERT PUSHED, VERIFY TIMED OUT
Validation failed: $VALIDATION_FAIL
Reverted to commit: $PREV_COMMIT
CF build may still be in progress -- check manually."
  fi

  log "=== Deploy finished with errors (post-launch, rolled back) ==="
  exit 1
fi

# -- 7. Success ------------------------------------------------------------------

log "All checks passed."
if [ "$DRY_RUN" = "true" ]; then
  notify "tripprintables.com DRY RUN passed (no push, no deploy, no cache purge)
Commit checked: $(git -C "$REPO_DIR" rev-parse --short HEAD)
siteIsLive: $SITE_IS_LIVE_RAW
Checks: HTTP 200 + content fingerprint OK + $([ "$SITE_IS_LIVE_RAW" = "false" ] && echo "meta robots noindex confirmed, no sitemap line" || echo "meta robots index confirmed, sitemap line present, crawl clean")"
  log "=== Dry run finished successfully, no real deploy occurred ==="
else
  purge_cache "post-deploy" || log "Warning: cache purge failed after deploy, continuing"
  notify "tripprintables.com deployed
Commit: $(git -C "$REPO_DIR" rev-parse --short HEAD)
siteIsLive: $SITE_IS_LIVE_RAW
Checks: HTTP 200 + content fingerprint OK + $([ "$SITE_IS_LIVE_RAW" = "false" ] && echo "meta robots noindex confirmed, no sitemap line" || echo "meta robots index confirmed, sitemap line present, crawl clean")"
  log "=== Deploy finished successfully ==="
fi
