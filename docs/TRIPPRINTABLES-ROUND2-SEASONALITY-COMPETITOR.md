# TripPrintables Round Two: Seasonality and Competitor Gap

**Date:** 2026-08-19
**Source:** Ahrefs API v3, country = us. `keywords-explorer-volume-history` (12-month trailing data), `serp-overview`, `site-explorer-organic-keywords` (mode=domain)
**Data files:** `docs/tripprintables-round2-seasonality.csv` (4 terms), `docs/tripprintables-competitor-gap.csv` (4 findings)
**Builds on:** `docs/keyword-map.csv` and `docs/KEYWORD-RESEARCH.md` (round one), `docs/tripprintables-framing-retrofit.csv` (framing retrofit)

> Ahrefs access lapses around 2026-09-12. This snapshot cannot be refreshed after that date.

---

## Seasonality: hard numbers replace the original inference

Round one set build deadlines from general seasonal reasoning (beach by March, ski by October, college by mid-2027). This round pulled actual 12-month volume history for each term. The deadlines mostly hold, with one correction and one confirmation worth noting.

**Cruise packing list is milder than assumed.** Volume runs 8,100 to 10,500 across the year with a spring and early-summer bump (March, June), not a hard spike. This strengthens the "build now, evergreen" call from round one rather than changing it: cruise is not a seasonal bet, it is close to a year-round anchor term.

**Beach packing list has a genuinely sharp spike, and the ramp starts earlier than "by March" implied.** Volume sits at 1,300 to 1,600 from October through January, then climbs through February, and peaks at 9,600 in June and July. Search interest is already rising by February, not March. Correction: move the deadline to live by February, not March, so the page has time to be indexed before the climb rather than arriving after it has started.

**Ski packing list confirms the October deadline, but the ceiling is low.** Volume is near zero (15 to 47) from May through September, climbs sharply starting November, and peaks in January at roughly 1,100 to 1,300. The October build call was correct. Worth noting for prioritization: this is the smallest-volume term of the four checked, an order of magnitude below the others at peak, so it should stay a minor page in the pack-it hub rather than a priority build.

**College and dorm packing list has the most extreme spike of anything checked.** Volume is flat in the 700 to 4,500 range most of the year, then climbs violently in June and July, peaks at 19,000 to 26,000 in August, and collapses back under 1,000 by October. This is a roughly 35x trough-to-peak swing in a single month. The "build by June 2027" call is confirmed, but the practical implication is sharper than the original note suggested: the page needs to be live and already earning some authority well before the July ramp, since a brand-new page has no chance of ranking in time if it launches during the spike itself.

---

## Competitor gap: the pack-it hub field is genuinely open

Round one inferred that the packing-list space was under-served based on a single soft SERP check (cruise packing list) and a general read of gdoc.io as a non-native travel competitor. This round verified that inference directly with two checks.

**The `packing list template` head SERP is soft.** Canva (DR 93) and Notion (DR 89) both rank, but they are general template platforms, not travel-specific content. The only travel-content competitors present are gdoc.io (DR 47, 11 referring domains) at position 7, and a personal blog, lifewithjanets.com (DR 2, 3 referring domains), at position 10. No authoritative, travel-focused printables competitor owns this term.

**gdoc.io has zero packing-list footprint.** A pull of gdoc.io's top 40 organic keywords by volume returned no packing-list terms at all. Its entire travel-relevant footprint is `travel itinerary template` (60,000 volume, position 7, KD 5) and `itinerary template` (17,000 volume, position 6, KD 8), both itinerary terms, not packing. The rest of its footprint is resumes, cover letters, invoices, business cards, menus, recipes, and calendars: a general Google Docs template mill where travel is a minor corner and packing lists do not exist at all.

The conclusion round one reached by inference is now a verified fact: the pack-it hub faces a genuinely open competitive field, not merely a soft one.

---

## What this changes

Build order is unchanged: cruise first (already buildable), beach next (now with a February deadline instead of March), ski by October, college by mid-2027. The competitor gap finding raises confidence in the pack-it hub generally, not just the terms checked here; there is no evidence anywhere in the space of a competitor worth building around defensively.

## What was NOT done

- Only four seasonal terms were pulled. Disney packing list and road trip planner were not re-checked with volume history this round; their round-one KD figures stand.
- The competitor gap check covered gdoc.io only. No other named competitor was checked; packpoint.app returned no Ahrefs data and is not a real competitor in this space as far as this data shows.

## Unit cost note

Four `keywords-explorer-volume-history` pulls ran roughly 196 units each. The competitor gap check ran one `serp-overview` call (~437 units) and one `site-explorer-organic-keywords` call (~920 units). Total for this round: roughly 2,150 units.
