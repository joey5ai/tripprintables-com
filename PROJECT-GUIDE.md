# Trip Printables: Project Guide

**Domain:** https://tripprintables.com
**Repo:** https://github.com/joey5ai/tripprintables-com
**Stack:** Eleventy (11ty) static site generator, Nunjucks templates, plain CSS
**Deployment:** Cloudflare Pages (Git integration, auto-deploy on push to main)

> ✅ **`robots.txt` reverted to `Allow: /`, 2026-08-08.** Batch 2 was already complete (all 15
> pages built, see below), and the temporary noindex from 2026-07-18 had been left in place
> past that point without being reverted. Fixed back to the plan's original "indexing on from
> day one" decision. See the Backlog section for the still-open payment (Lemon Squeezy/Gumroad)
> and GTM analytics gaps — those remain genuinely unset, not oversights.

## What This Is

A free travel-template library. One template per page (itinerary, packing list, budget, and
more), each with a real explanation of what's in it and how to use it, plus a "Make a copy"
Google Docs/Sheets link and a downloadable PDF. No account required to view a template. A paid
Complete Trip Planning Kit bundles editable versions of everything plus bonus templates.
Phase 1 of a larger experiment: Joey5 as day-to-day operator, Joseph as board. Batch-approval
governance now, with a path toward looser autonomy as confidence builds. Full build plan and
research (keyword data, tech-stack reasoning, batch structure) is in the approved plan this
project was built from.

## Key Files

| File | Role |
|------|------|
| `src/_includes/layout.njk` | Global layout: head/meta/schema, nav (incl. mobile hamburger), footer, GTM |
| `src/index.njk` | Homepage |
| `src/templates/*.njk` | One file per template page; front matter carries title/description/schema |
| `src/sitemap.njk` | Dynamically generates `/sitemap.xml` from `collections.all`, stays accurate as pages are added |
| `src/static/robots.txt` | Allow-all (indexing on from day one, unlike Uncle Nobody's stealth launch) |
| `src/static/llms.txt` | LLM-crawler description |
| `src/css/styles.css` | Design system: colors, typography, components, mobile nav |
| `src/js/nav.js` | Mobile nav toggle (open/close, Escape, resize-close) |
| `audit.config.json` | Content audit rules (adapted from Uncle Nobody's, see below) |
| `scripts/audit.js` | Audit runner (`npm run audit`), plain Node.js, not TypeScript |
| `.githooks/pre-commit` | Runs the audit before every commit; hard failures block, soft warnings print and allow |

## Adding a New Template Page

1. Create `src/templates/<slug>.njk` (slug should match the target keyword)
2. Front matter: `layout: layout.njk`, `title` (under 60 chars), `description` (120-160 chars),
   `ogType: "article"`, and a `schema` block (HowTo type, matching the existing 3 pages)
3. Content shape (same on every page): hero → download block (with `.download-block` class,
   required by the audit's `downloadCtaPresent` check) → what's included → who it's for →
   optional worked example → cross-links to related/format-specific pages
4. Run `npm run audit` before committing, fix anything it flags
5. The sitemap picks the new page up automatically on next build, no manual edit needed

## Content Rules (adapted from Uncle Nobody's governance trio)

This site does not have Uncle Nobody's full `SEO-STANDARD.md`/`EDITORIAL.md`/`CONTENT-PLAN.md`
trio; those are finance/YMYL-specific (citations, disclaimers, pillar/spoke structure) and
mostly don't apply here. What carried over, enforced by `audit.config.json`:

- No em dashes or double-hyphens (use commas, periods, or colons)
- Exactly one `<h1>` per page
- Title and meta description present and within length limits
- Schema block present (soft check)
- Every template page has an actual `.download-block` (hard check, this site's equivalent of
  Uncle Nobody's pillar-link requirement, since the whole business model depends on every page
  having a real CTA, not just descriptive copy)
- No internal links marked `nofollow`

## Design Tokens

```
Background:     #f7fafa  (cool white)
Background alt: #ecf2f1
Background 3:   #e0eae9
Ink (text):     #1e2827
Ink muted:      #5b6a68
Teal (primary): #1d6e68   -- buttons, CTA pill, key accents
Teal light:     #3d8f89   -- hover states
Terracotta:     #d96c4b   -- SPARING secondary accent only (section-label eyebrows)
Display font:   Fraunces (600/700)
Body font:      DM Sans (400/500/600)
```

Palette direction: teal-forward and cool, not the warm-cream/terracotta-forward version this
started as. Terracotta is intentionally rare, do not expand its use without asking; that
restraint is the point.

## Architecture Decisions (Don't Change Without Asking)

- **Eleventy, not a framework.** Static output, no client JS framework. Chosen specifically
  because 15 template pages share one layout; a heavier stack buys nothing here.
- **Cloudflare Pages Git integration, not a wrangler CLI deploy script.** Unlike the
  wilebski.ai/optionsscreener family, there is no `deploy-tripprintables.sh` wrapper. Cloudflare
  builds and deploys directly from GitHub on push. Rollback is via the CF dashboard's "rollback
  to previous deployment," not a custom script.
- **Indexing is meant to be on from day one** (deliberate opposite of Uncle Nobody's
  stealth-then-launch pattern; the whole point of this site is to rank, so no dark-launch
  phase). **Currently temporarily reversed** — see the warning banner at the top of this file.
  The domain went live via DNS/Cloudflare before all 15 pages existed, so `robots.txt` is
  `Disallow: /` until Batch 2 finishes. Revert then.
- **Email capture via Kit (ESP), not a Sheet+Function shim.** Real list infrastructure from day
  one: segmentation and automation-readiness handled by the platform, not built in-house.
- **Template documents (Google Docs/Sheets) live under a dedicated Gmail account**, separate
  from Joseph's personal account, for clean business-asset ownership. See Backlog below for
  setup status.
- **Dual-channel acquisition for the premium bundle, decided 2026-07-19 (deliberate, not scope
  creep).** Primary channel: Lemon Squeezy checkout on tripprintables.com (better fee
  reliability, Stripe-backed) — this stays the main sales path. Secondary channel: also list
  the same Complete Trip Planning Kit bundle on Gumroad, purely for its free Discover
  marketplace exposure while SEO authority builds over the coming months — not a replacement
  or a hedge, a low-cost additional acquisition channel. No exclusivity conflict between the
  two platforms. Tradeoff considered: light dual-listing upkeep (keeping price/contents in
  sync across two dashboards) vs. free additional distribution — judged worth it since the
  cost is minimal. See Backlog below for timing.

## Success Gate (60-90 days from launch)

- **Day 30 check-in:** are pages being indexed at all (Search Console coverage report)? Early
  warning, not a gate.
- **Day 60 gate, technical:** if fewer than ~80% of pages (12/15) are indexed, that's a
  crawlability/technical problem, fix before investing further in content.
- **Day 90 gate, content/competition:** if pages are indexed but zero page-one (top 10)
  rankings on any cluster term, that's a content-quality or competition-strength reassessment
  trigger, either the soft-competition thesis was wrong for this cluster, or the content needs
  real improvement, not more pages.
- **Day 90 gate, monetization:** if ranking (at least one page-one term) but zero organic
  downloads/email captures, that's a CTA/UX problem, not a traffic problem.
- **Day 90 gate, premium:** if leads are converting but zero premium-bundle sales, that's a
  pricing/positioning problem specific to the bundle, lowest priority of the four to fix.
- **Kill/pause trigger:** if by day 90 there is no positive signal on any of the above (no
  indexing progress, no rankings, no leads), that's the point to stop and reassess whether this
  vertical is worth continued investment, rather than let it become a zombie project.

## Backlog / Blocking Dependencies

- **Google Docs/Sheets API access, not yet set up.** Needed to actually create the real
  template documents the "Make a copy" CTAs point to; currently placeholder links marked
  "(coming soon)" on all 15 template pages (Batch 2 is complete, all pages built). Plan:
  dedicated Gmail account (owns the documents), OAuth client published "In production" from
  the start (avoids the 7-day testing-token expiry; will show a one-time "unverified app"
  click-through during consent since Drive/Docs/Sheets scopes are sensitive, not a review
  wait). Owner: Joseph (account creation, one-time consent click). Blocks: real downloads on
  every template page.
- **Lemon Squeezy account, not yet set up.** Needed for the premium bundle checkout. Account
  creation + identity verification + store activation review (2-3 business days KYC/KYB).
  Owner: Joseph. Blocks: Batch 3's actual checkout wiring (the `/premium/` sales page itself
  is built and live — price **$15**, bundle = all 15 templates fully editable + Excel format
  for every one, no bonus filler content, decided 2026-07-18).
- **Gumroad listing, not yet created — secondary acquisition channel (decided 2026-07-19, see
  Architecture Decisions above).** Same Complete Trip Planning Kit bundle, same $15 price and
  contents, listed on Gumroad for its free Discover marketplace exposure. Lemon Squeezy remains
  primary checkout; this is additive, not a replacement. Timing: build this at the same time as
  Batch 3's Lemon Squeezy checkout wiring, once Lemon Squeezy's store activation review clears —
  don't forget the second platform when that work happens.
- **Kit (ESP) account, not yet set up.** Needed for email capture. Same-day setup, no
  verification wait. Owner: Joseph. Blocks: Batch 4's email-capture wiring.
- **GTM (Google Tag Manager) container, not yet set up.** `src/_data/site.json`'s `gtmId` is
  still the literal placeholder value `GTM-XXXXXXX` — the layout wiring exists, but no real
  container is connected, so there is no analytics visibility into this property at all right
  now. Confirmed live (2026-08-08): the placeholder string ships as-is to production. Owner:
  Joseph (create a GTM container, or point to an existing one, and update `gtmId`). Blocks: any
  traffic/conversion visibility.
- **Anchor template document content, approved as the pattern** (2026), including a fix for
  the Google Docs version's day-by-day block: pre-fill 5 day blocks rather than one, with a
  one-line note on how to add more for longer trips (Docs has no native repeating-section
  feature, so this is the lowest-friction available fix). Apply this pattern to the other 14
  template documents once API access exists.

## Deployment

Push to `main` → Cloudflare Pages auto-builds (`npx @11ty/eleventy`, output `_site`) and
deploys. No scripts needed. Rollback via the Cloudflare Pages dashboard if a bad deploy ships.
