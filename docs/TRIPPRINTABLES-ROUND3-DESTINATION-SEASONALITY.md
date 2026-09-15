# TripPrintables Round Three: Destination Packing-List Seasonality

**Date:** 2026-09-14 (pull) / 2026-09-15 (write-up, recovered after a Claude usage-limit
interruption cut the original session off mid-task)
**Source:** Ahrefs API v3, country = us. `keywords-explorer-volume-history` (12-month
trailing, 2025-09 through 2026-09)
**Data file:** `docs/tripprintables-round3-destination-seasonality.csv` (11 terms)
**Builds on:** `docs/keyword-map.csv` and `docs/KEYWORD-RESEARCH.md` (round one),
`docs/tripprintables-round2-seasonality.csv` (round two, generic cluster terms)

> **Recovery note:** this write-up was produced by a fresh session that had zero memory
> of the work described below. Nothing had been written to disk before the cutoff. The
> raw Ahrefs tool-call results, however, were still on disk in this session's own
> transcript (a subagent fork spawned to do this pull hit Claude's own usage limit
> mid-task, not an Ahrefs failure or data loss). This document was built by reading
> those raw results back off disk and verifying them, not from memory of "what was
> found." See the data-integrity note in the CSV header for a correction this same
> recovery process caught.

---

## Data-integrity correction (read this first)

The first pass at these 11 pulls used parallel tool calls, and the results did not come
back in invocation order — the code that consumed them matched keyword to result
positionally and got it wrong for at least two terms. This was caught before anything
was committed: all 11 terms were re-pulled sequentially, one call at a time, and each
result was individually confirmed against the mismatched first pass.

Two corrections came out of that check:

- **`fsy packing list`**, not `safari packing list`, is the extreme spike. The original
  mismatched batch had attributed an extreme "near-zero then massive spike" pattern to
  safari. Safari's real pattern is mild and nearly flat.
- **`iceland packing list`** peaks in summer (August), not late winter as the mismatched
  batch implied. **`florida packing list`** peaks in spring (March, spring break), not
  the pattern originally attributed to it.

No other project docs referenced the mismatched numbers before this correction, so
nothing downstream needs to be revised.

---

## The eleven terms

**Six terms show no real seasonality and are buildable any time:** sleepover packing
list, hawaii packing list, packing list for hawaii, safari packing list, and italy
packing list all sit in a 1.6x-4.2x trough-to-peak band that is closer to noise than a
real seasonal signal. Hawaii and its variant carry genuinely strong year-round baseline
volume (974-1,665/mo) — among the highest of any term checked across all three rounds —
which makes the "no urgency" finding good news, not a gap: it can be built whenever
capacity allows without worrying about missing a window.

**Four terms have real seasonal windows with data-driven build deadlines:**

- **Study abroad packing list** is bimodal — a fall-departure bump and a larger
  spring-semester peak in January (1,279). Live by October, ahead of the November ramp
  into the January peak.
- **Costa rica packing list** follows the classic winter tropical-getaway curve, peaking
  in January (1,161) off a September trough (445). Live by October.
- **Japan packing list** peaks in May (1,494), matching cherry-blossom-season travel
  planning, with a secondary fall bump. Live by January, ahead of the February ramp.
- **Iceland packing list** peaks in August (1,338) — a clean summer build, not the
  late-winter pattern round one's mismatched data implied. Live by March.
- **Florida packing list** has the sharpest "real" spike in this batch outside fsy: a
  9x swing peaking in March (1,181), the classic spring-break curve. Live by December,
  ahead of the January-February ramp.

**One term is a standout, worth flagging on its own: `fsy packing list`.** This is the
most extreme swing checked on this project so far — 1,623x trough to peak. Volume is
single digits to low dozens for ten months of the year, then spikes to 8,116 in June.
This is not noise; it is the fixed June-July date pattern of the LDS youth "For the
Strength of Youth" (FSY) summer program, a real but narrow audience with hard calendar
dates. Because the searchable window is so short, the practical build deadline is
tighter than the volume curve alone suggests: the page needs to be live and **already
indexed** by February or March, since Google needs lead time and a brand-new page
launched during the April ramp has little chance of ranking before the June peak passes.
High reward for a narrow, single-purpose page; genuinely zero value outside its ~14-week
window (April through August).

---

## What this changes

No build-order changes to the core cruise/beach/ski/college calendar from round two.
This batch adds five destination-specific pages with real seasonal timing (study abroad,
costa rica, japan, iceland, florida) and confirms five more as evergreen, any-time builds
(sleepover, hawaii, hawaii variant, safari, italy) — all can be sequenced by capacity
rather than deadline. FSY is a genuine outlier worth a scoping decision: it is a real,
data-confirmed 1,623x-swing term, but the audience is narrow (a specific youth program)
and the window is short; whether it's worth a dedicated page is a product-scope call, not
a data question — the data says the term is real and the timing is tight if it's built.

## What was NOT done

- Competitor-gap verification (the round-two `serp-overview` + `site-explorer-organic-keywords`
  treatment) was not repeated for these 11 terms. They were checked for volume/seasonality
  only.
- No SERP overview was pulled for any of these 11 terms — that is a separate, larger
  piece of open work (all 109 keyword-map rows still need SERP overviews; see the
  companion backlink-profile doc from this same recovery session for current overall
  status).

## Unit cost note

Eleven `keywords-explorer-volume-history` pulls (22 calls total: an initial default-range
pull plus the corrected 12-month-range re-pull for each term, after the ordering bug was
caught) ran **2,728 units** combined. This round's other Ahrefs calls (backlink profile
work, covered in `docs/TRIPPRINTABLES-BACKLINK-PROFILE.md`) are costed separately in that
document.
