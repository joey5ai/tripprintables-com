# TripPrintables: Framing Retrofit

**Date compiled:** 2026-08-19
**Status:** Interpretation layer. Relabels the round-one difficulty-as-filter language to the coverage_tier x organic_timing model used across all three properties.
**Data file:** `docs/tripprintables-framing-retrofit.csv` (10 rows)
**What this doc does NOT do:** it does not modify `docs/keyword-map.csv` or `docs/KEYWORD-RESEARCH.md`, and it does not re-pull any data. It relabels how the existing round-one findings should be read.

---

## Why this retrofit is lighter than KnowYourIsms

KnowYourIsms is an encyclopedia: its mandate is comprehensive coverage, so difficulty can never be a reason to drop a topic, only a reason to sequence it later. TripPrintables is a different kind of site. It sells a commercial product (the Complete Trip Planning Kit) and its content exists to support that product and capture buyer-intent traffic. A packing-list niche that is both low-volume and hard to rank genuinely can be a legitimate skip here, not merely a slow-payoff core page.

So this retrofit does not relabel everything to `core`. It does two narrower things:

1. Replaces the word "cut" with "optional" wherever a topic was dropped for low value plus difficulty, because "cut" implies the topic is wrong to have, when the more accurate statement is that it is not worth building first.
2. Distinguishes true scope exclusions (a term that is not a packing list or itinerary at all, like trip-planner software) from soft deprioritizations (a topic that is a packing list but did not clear the bar), tagging the former `optional-SKIP` and the latter `optional`.

---

## The relabeling

**Core, soft-now (the site's actual strength, build first):** cruise packing list (the round-one soft-SERP proof: CruiseCritic's top result has only 9 referring domains, and Etsy listings ranking alongside it confirms buyer intent), disney packing list, the travel itinerary template anchor term (51,000 volume, KD 5, the plan-it hub's cornerstone), and road trip planner (reverified at KD 6 after the original pull showed KD 20, now confirmed soft).

**Core, medium (seasonal, build ahead of the season):** beach packing list (build by March for summer peak), ski packing list (build by October for winter peak), and the college and dorm packing-list cluster (build by June 2027 ahead of the extreme August spike; this cluster folds in camp, study-abroad, sleepover, and FSY packing lists under the same "trips" umbrella).

**Optional (relabeled from "cut"):** family vacation planner (150 volume, KD 26). The original research correctly identified this as not worth building first. What changes here is the label: this is a low-priority topic within scope, not a topic that was decided to be wrong for the site. If a future page naturally covers this ground as part of a broader planner page, that is fine; it does not need its own dedicated build.

**Optional-SKIP (true scope exclusions, unchanged from round one):** trip-planner software-adjacent terms, because that keyword space is a software category, not a template product, and is genuinely a different market, not merely a hard one. Hospital-bag and moving packing lists were explicitly excluded from the "trips" cluster definition itself, a scope decision, not a difficulty call.

---

## What this changes in practice

Nothing about the build order changes. Cruise-first, beach-by-March, ski-by-October, college-by-mid-2027 all stand exactly as originally planned. The only change is vocabulary: nothing on this site was ever framed as needing to exist "for completeness" the way KnowYourIsms pages are, because TripPrintables does not carry that mandate. What changes is that low-value topics are now described as optional rather than cut, which keeps the door open if a later product decision (a new kit, a new hub) makes one of them worth revisiting, instead of a "cut" label implying the door is closed.

---

## What was NOT done in this retrofit

- No new keyword or SERP data was pulled. This is a relabeling exercise only.
- `docs/keyword-map.csv` and `docs/KEYWORD-RESEARCH.md` are unmodified. This document is a supplementary interpretation layer, matching the pattern used for KnowYourIsms.
- Seasonality sweeps and the packing-list competitor gap analysis, both flagged as open round-two items in the original research doc, are still open. This retrofit only relabels round-one findings; it does not do the round-two research pass.
