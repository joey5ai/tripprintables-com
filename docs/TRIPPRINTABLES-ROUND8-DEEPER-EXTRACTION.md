# TripPrintables Round 8: Deeper Extraction (Ahrefs access ending)

**Date:** 2026-09-15
**Source:** Ahrefs API v3. `site-explorer-domain-rating-history`, `site-explorer-refdomains-history`,
`site-explorer-organic-keywords` (target `gatherandgotravel.com`), `keywords-explorer-matching-terms`
**Data files:** `docs/tripprintables-round8-refdomains-history.csv`,
`docs/tripprintables-round8-backlink-oldest-cohort.csv`,
`docs/tripprintables-round8-keyword-validation-full.csv`,
`docs/tripprintables-round8-new-keyword-candidates.csv`

This is a final pass while Ahrefs access is still live, covering four items not pulled in
rounds 1-7: domain-rating/referring-domains trend history, a non-overlapping backlink
sample, a full competitor organic-footprint diff against gatherandgotravel.com, and a
gift-guide keyword dead-end check plus a broader soft-keyword validation pull.

---

## 1. Domain rating history: empty (expected)

`site-explorer-domain-rating-history` returned no data points. Consistent with
`site-explorer-metrics` showing 0 organic keywords / 0 organic traffic for this site as of
prior pulls: Ahrefs has not yet assigned a tracked DR trend because the site has no
established organic footprint. Not a data-quality problem, just too early. Revisit at the
next scheduled SEO review once organic keywords start appearing.

## 2. Referring-domains trend: confirms the spam is still actively arriving

`site-explorer-refdomains-history` (`docs/tripprintables-round8-refdomains-history.csv`):

| date | live referring domains |
|---|---|
| 2026-07-20 | 143 |
| 2026-08-17 | 356 (peak) |
| 2026-08-31 | 278 (dip) |
| 2026-09-14 | 306 |

The dip between 2026-08-17 and 2026-08-31 (356 to 278, a drop of 78) matches the domain
churn already noted in `TRIPPRINTABLES-BACKLINK-PROFILE.md`, throwaway PBN infrastructure
going dead. The rebound to 306 by 2026-09-14 shows new spam domains continuing to land
after that dip, i.e. this is an ongoing, still-active low-grade spam campaign, not a single
burst that already finished. No action changes as a result: still 100% nofollow, still
Ahrefs-flagged spam, still no disavow recommended (see risk assessment in the original
backlink profile doc).

## 3. Second backlink sample: oldest-first cohort confirms the pattern, not new information

The Lite plan API caps `site-explorer-referring-domains` at 100 rows per call regardless of
`limit`, as already documented. A second call using `order_by=first_seen:asc` pulls a
different, earliest-arriving 100-domain slice (`docs/tripprintables-round8-backlink-oldest-cohort.csv`)
rather than repeating the same 100 rows the original profile doc already covered, this
approximately doubles unique domain coverage of the 304-domain population (from ~33% to
~66%, assuming minimal overlap given the sort by first_seen vs. the original's presumed
default sort).

This cohort is the earliest wave: all 100 domains first seen within a roughly 26-hour
window, 2026-07-22 05:46 UTC through 2026-07-24 07:32 UTC, the campaign's opening burst.
Pattern is identical to the original sample: `.shop`/`.agency`/`.store`/`.site`/`.website`
TLDs, SEO/PBN-vendor keywords in the domain name, `is_spam: true` on all but 4 of the 100
rows, `dofollow_links: 0` on every single row. No new finding beyond confirming the
original profile's characterization holds across a larger share of the total population,
not just the original 100-row sample.

## 4. gatherandgotravel.com organic footprint: mostly out of TripPrintables' lane

Pulled the top 100 organic keywords for gatherandgotravel.com (capped at 100 rows despite
requesting 300, same Lite-plan limit). Roughly 18 of the 100 are packing-list or
itinerary-template relevant and directly overlap TripPrintables' niche; the remaining ~82
are destination guides, "things to do in X," and generic trip-planning content
(currency converters, visa requirements, flight-comparison advice) that TripPrintables
does not compete for and has no reason to build toward.

**Reading:** gatherandgotravel.com is a broad travel-content site that happens to also
rank for some packing-list terms as a side effect of overall site authority, not a
niche-native packing/itinerary competitor the way the round 4 and round 7 analyses defined
the term. This matches the round 7 finding (`TRIPPRINTABLES-ROUND7-NICHE-COMPETITOR-CHECK.md`)
that no true niche specialist competitor exists yet, TripPrintables' actual competition on
its core terms is large general-travel sites' incidental overlap, not a rival printable/
packing-list-focused property. No new competitor to add. This closes out the
gatherandgotravel.com angle as fully checked, not partially checked.

## 5. Gift-guide keyword framing: confirmed dead end

Ran a targeted `keywords-explorer-matching-terms` pull on gift-guide framing (seeds around
"travel gift guide" / "packing gift ideas"). Returned only 2 results, one of which was
off-topic noise. There is no meaningful search volume behind a gift-guide angle for this
niche. **Do not build gift-guide content**, this was worth checking once and is now
closed, not worth re-checking on a future pull.

## 6. Broader keyword validation: 100-row pull, mostly confirms existing map, 12 new candidates

Re-ran the "packing list / travel checklist / vacation packing" seed pull
(volume >= 300, difficulty <= 15, US) to validate soft-tier coverage. Full 100-row result
in `docs/tripprintables-round8-keyword-validation-full.csv`. Cross-referenced against the
existing 109-term `docs/keyword-map.csv`:

- **~76 of the 100 rows are already covered** by an existing keyword-map.csv entry
  (exact match) or map cleanly onto one as a secondary/variant phrasing of an existing
  page's target term (e.g. "vacation packing checklist," "travel packing checklist,"
  "packing checklist for vacation" all map onto the existing packing-list-for-vacation
  page rather than needing separate pages).
- **12 genuinely new candidates**, tagged coverage_tier x organic_timing in
  `docs/tripprintables-round8-new-keyword-candidates.csv`:
  - `travel checklist` (6,000 vol, KD41), the single highest-volume gap in this pull;
    a real hub-strength term with no dedicated page yet. Tagged core/medium given the
    difficulty is the highest of this batch.
  - `international travel checklist` (2,700, KD11), supporting/soft-now.
  - `fsy packing list 2026` (600), a year-refresh signal for the existing FSY page,
    not a new page.
  - Five new destination terms not in the current map: mexico, thailand, camino de
    santiago, cancun, and a reinforcing african-safari variant, all optional/long-game,
    low volume individually.
  - Four adjacent-niche terms: overnight, hiking, rv, and cruise-packing-list-for-women, optional tier, mixed timing.
- **~12 rows are noise or out of scope**, not carried into the candidates file:
  malformed/auto-generated-looking long-tail strings ("ultimate travel checklist
  essentials 2025," "your travel packing list for france vacation," "travel and leisure
  safari packing list", a magazine-brand query, not generic intent), and terms already
  flagged out of scope in earlier rounds (moving, hospital bag, shipping, air assault,
  baby, none of these are trip/vacation packing and were excluded from prior rounds on
  the same basis).

---

## Unit cost, this round

| pull | units |
|---|---|
| `site-explorer-domain-rating-history` | 50 |
| `site-explorer-refdomains-history` | 96 |
| `site-explorer-organic-keywords` (gatherandgotravel.com, 100 rows) | 2,300 |
| `keywords-explorer-matching-terms` (gift-guide, dead end) | 50 |
| `keywords-explorer-matching-terms` (validation, 100 rows) | 2,200 |
| `site-explorer-referring-domains` (oldest cohort, 100 rows) | 600 |
| **Round 8 total** | **5,296** |

Combined with rounds 1-7's cumulative spend, this stays well inside the standing ~40k
single-pull ceiling and the broader per-site budget guidance. No further TripPrintables
Ahrefs pulls are planned, the four value-add items from this round's directive are now
complete, and gatherandgotravel.com and the gift-guide angle are both closed as verified
dead ends rather than left open.

## What's still genuinely open (not an Ahrefs gap, a content-planning one)

- The 12 new-candidate keywords in `docs/tripprintables-round8-new-keyword-candidates.csv`
  have not been built into pages yet, that's content-plan work, not research work.
- `travel checklist` (6,000 vol) is the single highest-value unclaimed term surfaced
  across all 8 rounds of TripPrintables research and should be a priority candidate when
  content planning starts.
