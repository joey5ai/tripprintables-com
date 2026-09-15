# TripPrintables: Full SERP-Overview Pass (98 of 109 Keyword-Map Terms)

**Date:** 2026-09-15
**Source:** Ahrefs API v3, country = us. `serp-overview` (type=organic filter, top_positions=10)
**Data file:** `docs/tripprintables-serp-overview-full.csv` (95 terms, this pass)
**Builds on:** `docs/keyword-map.csv` (109 terms, pull date 2026-08-18), `docs/KEYWORD-RESEARCH.md`
(round one — `cruise packing list` and `college packing list` checked there),
`docs/TRIPPRINTABLES-ROUND2-SEASONALITY-COMPETITOR.md` (round two — `packing list template`
checked there), `docs/TRIPPRINTABLES-ROUND3-DESTINATION-SEASONALITY.md` (round three, which
flagged this exact gap as open work)

---

## Coverage

98 of the 109 rows in `keyword-map.csv` now have a SERP overview on file: 3 from earlier
rounds (`cruise packing list`, `college packing list`, `packing list template`) plus 95
pulled in this pass. The remaining 11 rows are the `EXCLUDE`/`CUT` rows (branded terms,
software intent, shipping/moving/military off-topic matches, the one over-KD cut) — decisions
already made in round one; spending units re-verifying a term that will never be built isn't
real value, so those were skipped deliberately rather than left as an oversight.

**Method note:** the raw `serp-overview` response mixes organic results with AI Overviews,
People Also Ask, sitelinks, and image-pack entries, which bloats each response 3-5x with
data that doesn't matter for a competitor read. Filtering to `type=organic` cuts each call
to just the ranking pages — this pass used that filter throughout, which is why unit cost per
call (~150-210 units) came in well under round two's unfiltered estimate (~437 units).

**Unit cost:** 95 `serp-overview` calls, organic-only, ran **24,724 units** total (workspace
usage went from 42,611 to 67,335 of the 200,000 monthly allowance — well inside budget).

---

## Headline finding: the packing-list hub is dramatically softer than the itinerary hub

This is the single biggest thing this pass adds to the round-one/round-two thesis. Round one's
inference — that the packing-list space is under-served — was based on two soft-SERP spot
checks. This pass checked 61 packing-list terms and found the pattern holds at scale, and is
sharper than the spot checks suggested:

| Hub | Terms checked | Genuinely HARD (platform-dominated) | Soft-leaning (SOFT / SOFT-MIXED / MIXED-SOFT) |
|---|---|---|---|
| plan-it (itinerary/budget/checklist) | 34 | 9 (26%) | 16 (47%) |
| pack-it (packing lists) | 61 | **0 (0%)** | **49 (80%)** |

**Not one of the 61 packing-list terms checked is dominated by a generic template platform.**
Canva, Notion, and Adobe Express have built out deep, DR90+ template libraries for
itineraries, budgets, and planners — Canva alone leads 9 of 34 plan-it terms outright — but
none of them have done the equivalent for packing lists. The packing-list SERPs are instead
filled with a mix of: a handful of legitimate travel-authority blogs (SmarterTravel, Rick
Steves, REI, Eagle Creek) that lead the generic head terms; and, on the vast majority of
destination/occasion/life-event long-tail terms, a scattered field of tiny personal blogs
(DR0-30), Reddit threads, Facebook groups, and PDFs with no real on-page optimization at all.

Some of the softest individual findings:
- **`excel travel itinerary template`** and **`excel itinerary template`**: a DR3 personal
  blog (thattravelitch.com) ranks #1 on both.
- **`beach packing list`**, **`hawaii packing list`**, **`disney world packing list`**: no
  authority site of any kind appears in the top 10 — the entire page is small blogs and forums.
- **`safari packing list`**: a DR0 personal blog (jeffhyer.com) ranks #4.
- **`college dorm packing list`**: a DR15 blog ranks #1 outright.
- **`backpacking europe packing list`**: DR2 and DR4 personal blogs occupy positions 2 and 5.
- **`disney packing list`**: Disney's own official site (disneyland.disney.go.com) only
  manages #10 — a DR20 independent blog leads.

The itinerary hub is a much harder fight where Canva has staked a claim (the 9 HARD/MIXED-HARD
terms — `travel itinerary template`, `itinerary template`, `free itinerary template`, etc. —
are all Canva-led with 20K-110K estimated monthly traffic on the ranking page), but even there
the *format* cluster (Google Sheets/Excel/Word variants) and the *checklist* cluster are soft:
Canva's dominance is specifically on the head "itinerary template" phrasing, not on
format-qualified or checklist-phrased long tail.

## What this changes

No build-order changes to the existing calendar — this confirms the packing-list-first
sequencing already in place rather than overturning it. What it adds is evidence-backed
confidence for the destination/occasion/life-event pages already flagged `NEW PAGE` in
`keyword-map.csv`: nearly every one of them (Alaska/Carnival/Costa Rica/Japan/Iceland/Italy/
Florida/Safari packing lists, the Disney cluster, the college cluster, honeymoon/wedding
packing) is going up against a soft or fragmented SERP, not an entrenched competitor. The
handful of genuinely harder packing-list terms worth flagging for content-quality investment
rather than treated as automatic wins: `iceland packing list` (guidetoiceland.is is a real
dedicated niche authority, DR76), `costa rica packing list` (mytanfeet.com, DR54), `car
camping packing list` and `backpacking packing list` (REI, DR87), and `honeymoon packing list`
(Brides/The Knot wedding publishers).

On the itinerary side: the format-variant pages (Excel/Google Sheets/Google Docs/Word) and the
planning-checklist pages are the softest opportunities in that hub and are already flagged
`NEW PAGE - phase 2` / `now` in keyword-map — this pass adds direct evidence that phase-2
priority is justified, not just KD-score justified.

## What was NOT done

- No new keyword discovery in this pass — this is a competitor read on the existing 109-row
  keyword map only. Deep keyword expansion across both hubs (round-map growth beyond the
  current 109 terms) is separate open work, tracked next.
- No `site-explorer-organic-keywords` domain-level follow-up on the recurring soft competitors
  (e.g., livelikeitstheweekend.com and justbeeblog.com show up leading multiple terms each —
  worth a domain-level look at what else they rank for, but that's a targeted follow-up, not
  part of this per-keyword pass).
