# TripPrintables Keyword Research

**Pull date:** 2026-08-18
**Source:** Ahrefs API v3, country = us
**Tools used:** keywords-explorer-overview, keywords-explorer-matching-terms, keywords-explorer-volume-history, serp-overview, site-explorer-organic-keywords
**Data file:** `docs/keyword-map.csv` (109 rows) — this document interprets it; the CSV is the source of truth for numbers.

> Ahrefs account access is expected to lapse around 2026-09-12. These numbers cannot be refreshed after that date without a new subscription. Treat the CSV as a frozen snapshot and cite its pull date whenever it is used.

---

## Site architecture: two hubs

TripPrintables serves one traveler at two different moments. These are distinct search intents and must not be merged into one page cluster.

### Hub 1 — Plan it
The trip is undecided. The user wants a **container** to fill in. Modifiers are about **format**: Google Docs, Sheets, Excel, Word.

### Hub 2 — Pack it
The trip is decided and imminent. The user wants a **finished checklist** to tick off. Modifiers are about **destination and trip type**: cruise, Hawaii, ski, backpacking, college.

**Evidence this split is real, not editorial preference:**

1. **Parent topics do not merge.** Ahrefs clusters "travel itinerary template", "itinerary template", and "trip itinerary template" all under the single parent topic `itinerary`. But `cruise packing list`, `beach packing list`, `hawaii packing list`, and `disney packing list` each carry their **own** parent topic. Google is not treating packing as a subtopic of planning.
2. **Modifier types are opposite in kind.** Format-seeking versus destination-seeking. A cruise packing list must contain cruise-specific knowledge; an itinerary template must contain no trip-specific content at all.
3. **CPC splits cleanly.** Plan-it terms run $0.50-$0.80. Pack-it terms run $0.02-$0.10. Advertisers pay for the planning moment and will not pay for the packing moment.

---

## Status of each hub

### Hub 1 (Plan it) is essentially complete

A dedicated pull against `travel budget`, `trip planner`, `vacation planner`, `travel planning`, and `trip organizer` returned almost nothing new. The "trip planner" keyword space is dominated by **software**, not templates: Tesla trip planner (8,500), TriMet / MARTA / SEPTA transit planners, RV trip planner. Not addressable with a printable.

The only template-intent terms that surfaced — `trip planner template` (800/KD 7), `vacation planner template` (600/KD 7), `travel planning template` (450/KD 4) — all carry parent topic `itinerary`, meaning they are **secondary phrases for the existing anchor page**, not new pages.

**This is a useful negative finding. Do not spend build time expanding Hub 1.**

Remaining Hub 1 work:
- Add `trip planner template`, `vacation planner template`, `travel planning template` as secondaries on the anchor page.
- Two new format pages: `travel itinerary template excel` (500/KD 7), `travel itinerary template word` (500/KD 4).
- One new occasion page: `birthday itinerary template` (450/**KD 0**).
- **Cut `family vacation planner`** — 150 volume at KD 26. Reverses the July assessment; see Corrections.
- Consider a budget **guide** (not template): `how to prepare a travel budget` (4,800/KD 23) and `how to create a travel budget` (700/KD 23, **CPC $25.00** — highest commercial signal on the site).

### Hub 2 (Pack it) barely exists

One page (`packing list template`) against a cluster larger and softer than Hub 1.

---

## SERP validation

Two SERPs checked in full. Both are genuinely empty, not merely low-KD.

**`cruise packing list` (9,200/mo, KD 4)**
- #1 is CruiseCritic with **URL Rating 4 and 9 referring domains**. High domain authority, near-zero page authority.
- Reddit ranks #3 with UR 0 and 4 backlinks. A Facebook group post ranks. A Substack at #9 pulls 30 visits/mo.
- Small blogs hold real positions: DR 23 at #5, DR 40 at #8.
- The #1 title leads with the word **"Printable."**
- **An Etsy digital-download listing ranks in the top block.**

**`college packing list` (4,600/mo avg, KD 1)**
- #1 is a **raw PDF in a WordPress uploads folder**, uploaded 2015, UR 0, 2 referring domains — pulling **14,759 visits/month**.
- #6 is a DR 5 blog with **zero backlinks**.
- #5 is the College Board login page.
- An Etsy digital-download listing ranks again.

**Read-through:** Etsy listings in both SERPs are direct evidence of purchase intent for this product from these queries. The bare-PDF #1 result confirms the intent is literally "give me a printable file."

---

## Competitor: gdoc.io

Pulled 2026-08-18 (top 100 organic keywords, positions 1-20).

**gdoc.io is not a travel site.** It is a general Google Docs template library whose actual business is career documents: `google docs resume template` (27,000, **position 1**), `resume template google docs` (17,000, #1), `cover letter template google docs` (10,000, #2), `invoice template google docs` (9,200, #2). Resume terms carry $1.32-1.74 CPC versus travel itinerary's $0.77. Travel is a side category — which is why they hold only position 7 on the anchor term.

**Key structural lesson: one page, many keywords.** The single URL `gdoc.io/itinerary-templates/` ranks for:

| Keyword | Volume | Their position |
|---|---|---|
| travel itinerary template | 60,000 | 7 |
| itinerary template | 17,000 | 6 |
| trip itinerary template | 2,800 | 6 |
| vacation itinerary template | 1,600 | 3 |
| itinerary template google docs | 1,200 | 1 |

Their whole itinerary business runs off one page. This validates the consolidation decision and raises a real question about whether our 12-page split is over-fragmented. Notably their format-variant page (`travel-itinerary-spreadsheet...`) ranks *worse* (position 10) than the gallery page does for the same family.

**They are in Hub 2 weakly.** `gdoc.io/packing-list-templates/` sits at position 7 for `packing list template` (3,400). One page, no destination-specific coverage. The entire cruise/beach/Disney cluster is unclaimed.

**Adjacent categories they rank for that sit near our brand:** `wedding timeline template` (2,800, KD 1, they're #19), `wedding guest list template` (1,300, KD 5, #7). Both pair naturally with our wedding itinerary page.

**Data discrepancy to note:** this pull shows `travel itinerary template` at 60,000; Keywords Explorer showed 51,000. Different endpoints, likely different volume calculation modes. Use the Keywords Explorer figure for planning and treat the range as the uncertainty band.

---

## Seasonality drives build order

Annual average volume is misleading for most of Hub 2. Three archetypes, verified against 13-25 months of history:

| Archetype | Example | Low month | Peak month | Swing |
|---|---|---|---|---|
| **Evergreen** | cruise packing list | 8,161 (Sep) | 10,501 (Jun) | 1.3x |
| **Summer** | beach packing list | 1,315 (Nov) | 9,597 (Jun) | 7.3x |
| **Winter** | ski trip packing list | 107 (Jun) | 2,472 (Feb) | 23x |
| **Extreme spike** | college packing list | 721 (Oct) | 20,682 (Aug) | 29x |

`college packing list` earns special mention: the entire year's demand lands in a six-week window. Its "4,600/mo" figure describes no actual month.

**Caveat on the August 2026 college data point:** it reads 6,461 against 19,013 for August 2025. The pull was taken 2026-08-18, so this is most likely a partial month rather than a real 66% collapse. Do not treat it as a demand signal without a complete month.

**Seasonality checks cost ~2 units/row** versus ~34 for keyword metrics — nearly free. Terms marked `verify` in the CSV's seasonality column have not been history-checked and should be before their build window.

---

## Build calendar

Pages must rank *before* their season, so build windows lead peaks by roughly 3 months.

### Build now (evergreen, or peak far enough out)
1. **`cruise packing list`** — highest-value target on the site. 9,200/mo, KD 4, flat year-round, empty SERP, proven purchase intent. Build first.
2. `disney packing list` (2,400/**KD 0**) and `disneyland packing list` (600/KD 0)
3. `disney cruise packing list` (1,400/KD 0), `carnival cruise packing list` (600/KD 1)
4. `packing list` hub page (28,000/KD 28 — hardest term, but it anchors the hub)
5. `international travel packing list` cluster (~5,000 combined)
6. `weekend trip packing list` cluster (~2,500 combined, all KD 1)
7. `hawaii` / `costa rica` / `japan` / `iceland` packing lists (all KD 0-3)
8. `honeymoon packing list` + `wedding packing list` — pair with the wedding itinerary page
9. `business travel checklist` — pair with the business trip itinerary page
10. `printable packing list` + `travel packing checklist pdf free` — exact product-format matches
11. Hub 1 leftovers: excel/word format pages, birthday itinerary, anchor-page secondaries

### Build by October (winter peak Dec-Feb)
- `ski trip packing list` (peaks 2,472 in Feb)
- `florida packing list` — verify seasonality first

### Build by March (summer peak Jun-Aug)
- `beach packing list` cluster (~9,300 combined at peak)
- `packing list for vacation` (5,900), `camping packing list` (4,300)
- `road trip packing list`, `backpacking packing list`, `europe packing list`
- `alaska cruise packing list`

### Build by June 2027 (August spike)
- `college packing list` cluster (~8,500 combined, peaks ~20,000 in August)
- `summer camp packing list`, `study abroad packing list`, `fsy packing list`

---

## Scope decision: trip-adjacent, non-vacation

`college packing list` and its neighbours are packing lists for departures that are not vacations. Decision taken 2026-08-18: **these are in scope** for the Pack-it hub. The user leaves, stays a while, returns, and packs a bag — the same job the product does.

**In scope:** college, dorm, summer camp, study abroad, sleepover, FSY.
**Excluded:** `hospital bag packing list` (childbirth) and `moving packing list` (relocation) — no return leg, so the product framing breaks. Both also carry the worst difficulty in the group (KD 23 and KD 4) against a cluster averaging KD 0-4, so the brand argument and the data argument agree.

Also excluded and marked in the CSV: `packing list envelopes` and `shipping packing list template` (shipping supplies), `air assault packing list` (military), `travel planner app` and `aaa triptik travel planner` (software / branded), `baby packing list` (intent unclear).

---

## Corrections to the July 2026 research

The original TripPrintables research was never written to a file; it existed only in a chat transcript. Three findings have changed:

1. **Anchor volume grew.** `travel itinerary template` is 51,000/mo (was 45,000). KD 5.
2. **`road trip planner template` was wrongly flagged for cutting.** July recorded 90/KD 20 and called it the first candidate to cut. It is now 90/**KD 6**. Volume is still thin but the difficulty objection is gone. Keep it.
3. **`family vacation planner` is the actual cut.** July flagged it as a "stretch page" at KD 36. It is now 150 volume/KD 26 — difficulty came down, but 150/mo does not justify a page.

---

## Unit cost reference (for future budgeting)

| Call type | Cost |
|---|---|
| `keywords-explorer-overview` | ~34 units/row |
| `keywords-explorer-matching-terms` | ~33 units/row |
| `site-explorer-organic-keywords` | ~24 units/row |
| `serp-overview` | ~21 units/row (~450-500 per keyword) |
| `keywords-explorer-volume-history` | **~2 units/row** (~50 per keyword) |
| `subscription-info-limits-and-usage` | free |
| `site-audit-projects` | free |

Total spent producing this document: **9,233 units** of a 100,000 quota.

---

## Open items

- Seasonality unverified for terms marked `verify` in the CSV (Hawaii, Costa Rica, Japan, Iceland, Florida, Italy, safari, study abroad, sleepover, FSY). ~50 units each.
- No gap analysis against a travel-native competitor. gdoc.io turned out to be a general template site, not a travel specialist, so the "what does a travel site rank for that we do not" question is still open.
- Site Audit was considered and rejected: a 12-page hand-built static site has too little for it to find, and robots.txt disallow-all would block the crawler while the site remains pre-launch.
