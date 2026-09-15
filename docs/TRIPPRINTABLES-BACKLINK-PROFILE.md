# TripPrintables Backlink Profile

**Date:** 2026-09-14 (pull) / 2026-09-15 (write-up, recovered after a Claude usage-limit
interruption cut the original session off mid-task)
**Source:** Ahrefs API v3. `site-explorer-metrics`, `site-explorer-backlinks-stats`,
`site-explorer-referring-domains`, `site-explorer-all-backlinks`, `site-explorer-anchors`
(all `mode=subdomains`, target `tripprintables.com`)
**Data files:** `docs/tripprintables-backlink-domains.csv` (100-domain sample),
`docs/tripprintables-backlink-anchors.csv` (100-anchor sample)

> **Recovery note, same as the round-three seasonality doc:** the session that ran these
> pulls was cut off by a Claude usage limit before anything was written to disk. This
> write-up's author had zero memory of the work. The underlying Ahrefs results were still
> on disk in that session's own tool-call transcript and were read back and verified from
> there, not reconstructed from memory or invented to match a description of "PBN spam
> patterns" the recovering session was told to expect. The totals below (`live: 305`,
> `live_refdomains: 304`) come from a fresh, freshly-verified `site-explorer-backlinks-stats`
> call made during recovery, confirming Ahrefs access had not lapsed as an earlier doc
> speculated it might.

---

## Headline: this is a PBN/link-farm spam pattern, not organic or targeted

TripPrintables is a brand-new site (`site-explorer-metrics`: 0 organic keywords, 0
organic traffic as of this pull) that has accumulated **305 live backlinks from 304
live referring domains** (430/428 all-time — a handful have already gone dead, typical
domain churn for throwaway link-farm infrastructure) in roughly the eight weeks since it
went live. A 100-row sample of both the referring domains and the raw backlinks, plus
the top 100 anchor-text clusters, all point to the same conclusion: this is unsolicited,
automated PBN-vendor spam, not a negative-SEO attack targeting this site specifically
and not anything the site owner did.

**The referring domains are link-farm infrastructure, not real sites.**
Of the 100-domain sample (`docs/tripprintables-backlink-domains.csv`):
- 91% use `.shop` (58) or `.store` (33) TLDs — cheap, disposable domain classes commonly
  used for PBN (private blog network) infrastructure, plus a handful of `.agency`,
  `.site`, and `.xyz`.
- 94% contain an SEO/PBN-vendor keyword in the domain name itself (`seo`, `rank`, `link`,
  `backlink`, `boost`, `outrank`, `authority`, `pbn`, `grow`, `traffic`) — e.g.
  `rankboostly.shop`, `outrank-hq-ultimate-ranking.store`,
  `master-rank-forge-pbn-league.store`, `smart-marketing-seoexpress.store`.
- Domain Rating in the sample ranges 0.2-66 (avg 24.9) — inflated by cross-linking
  within the same link-farm network, not earned authority.
- All 100 sampled domains were first seen within an eight-week window: 46 in July 2026,
  50 in August, 4 in September — i.e., since the domain went live. This is a burst, not
  organic accumulation over time.

**The backlinks themselves are flagged spam by Ahrefs, and carry zero direct SEO
weight.** A 100-row sample of the raw backlinks (`site-explorer-all-backlinks`): 100%
flagged `is_spam: true` by Ahrefs' own classifier, and **100% nofollow** (`is_dofollow:
false` on every row). Nofollow links pass no PageRank, so this spam carries essentially
no direct ranking risk through the normal link-graph channel.

**The anchor text confirms it's a vendor's own product advertisement, not a real
campaign against this site.** The single largest anchor-text cluster —
**175 of 304 referring domains (57.5% of the entire profile)** — share one identical
anchor text, verbatim:

> "Entry: tripprintables.com. The SEO Express PBN product is a PBN network where every
> domain is DR 60+ and aged. PBN Starter: 100 links, $300, 7-day delivery. 1-Day Rush
> Delivery is available as a +$200 add-on to any package. Compare PBN and guest post
> pricing at seoexpress.org."

This is not an attack — it's a PBN vendor's own sales copy, with the target domain
(`tripprintables.com`) auto-inserted as a filler/proof-of-reach token, blasted across
their entire owned network as promotional noise. The remaining anchor clusters are the
same pattern: templated "SEO agency testimonial" copy ("Before finding ITXoft.com,
tripprintables.com seemed lost online..."), "boost your DR/DA/TF" pitches, and a Fiverr
seller ad, each shared by 1-2 domains — dozens of different vendors' template farms, all
independently scraping/targeting newly-live domains the same way.

**This matches a pattern already independently observed on a sister project.** The prior
session's own notes (recovered from the same transcript) recorded: "This is unambiguous
PBN spam... matches — and is worse than — the pattern already flagged on Uncle Nobody."
Two unrelated Joey5-operated domains getting hit with structurally identical spam within
the same window points to automated scraping of newly-registered or newly-crawlable
domains (likely via DNS zone files, Certificate Transparency logs, or similar), not
anything specific to TripPrintables' content, niche, or competitors.

---

## Risk assessment

- **Direct ranking harm: low.** 100% of the sampled links are nofollow and already
  discounted by Ahrefs' own spam classifier — no PageRank is flowing through this.
- **Manual-action / trust risk: low but not zero.** Google's own spam systems generally
  discount this kind of link-farm noise automatically and don't penalize sites for links
  they didn't build and can't control. The main residual risk is cosmetic: this noise
  will show up in Search Console's Links report and could visually alarm anyone checking
  it without this context.
- **Disavow file: not recommended right now.** A disavow is normally reserved for
  dofollow spam or an active negative-SEO campaign with ranking impact. Since this
  profile is 100% nofollow and already spam-flagged, filing one adds maintenance
  overhead without a corresponding risk reduction. Revisit this call only if a future
  pull shows dofollow links in this same pattern, or if a ranking/indexing problem shows
  up that coincides with it.
- **Recommended action: monitor, no remediation needed today.** Re-check referring
  domains at the next scheduled SEO review (natural pairing with the day-30/day-60/day-90
  Search Console gates already defined in `PROJECT-GUIDE.md`) to confirm the pattern
  stays nofollow-only and doesn't start showing up in Search Console as a coverage or
  manual-action issue.

---

## What was NOT done / known gaps

- **Only a 100-row sample of the 304 live referring domains was pulled**, not the full
  population. Ahrefs' Lite plan API appears to cap `site-explorer-referring-domains` and
  `site-explorer-all-backlinks` at 100 rows per call regardless of the `limit` parameter
  requested (a call explicitly requesting `limit: 1000` still returned exactly 100 rows,
  confirmed by the `apiUsageCosts.rows: 100` field on that response). The 304/305 totals
  come from `site-explorer-backlinks-stats`, which does return an accurate full-population
  count even though the row-level detail endpoints don't. Given the sample is 100/304
  (33%) and shows a single, homogeneous pattern with no outliers, it's a reasonably
  representative read of the whole profile — but it is not exhaustive.
- **One `site-explorer-all-backlinks` call errored** (result exceeded the client's inline
  token budget) and was saved to a raw file instead of returned inline; that raw file
  (100 rows, `1_per_domain` aggregation) is the source for the "100% is_spam, 0% dofollow"
  finding above and was fully recovered and verified.
- **No competitor angle was checked here** — this doc covers only TripPrintables' own
  inbound spam profile, not a link-gap analysis against competitors. That's a separate,
  still-open priority item (real competitor analysis).
- **No disavow file was created.** See Risk assessment above for why.

## Unit cost note

`site-explorer-metrics` (50 units), `site-explorer-referring-domains` (2 successful calls
at 100 rows each, ~400 units combined; two earlier attempts errored server-side at 0 cost),
`site-explorer-anchors` (900 units), and a fresh `site-explorer-backlinks-stats` call made
during recovery (50 units) are all confirmed from the transcript/live check. The
`site-explorer-all-backlinks` call that returned the 100-row spam sample errored past the
inline token budget before its cost line was captured in this session's readable log;
based on per-row pricing on the other endpoints it's estimated at roughly 300-500 units,
not separately confirmed. Total confirmed + estimated for this doc: roughly 1,700-1,900
units. Combined with round three's destination-seasonality pulls (2,728 units), this
recovery session's total Ahrefs spend across both docs is roughly 4,400-4,600 units —
well inside the ~40k single-pull ceiling and ~60k soft session target from the standing
budget guidance.
