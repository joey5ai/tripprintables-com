# TripPrintables Round Seven: Niche-Native Competitor Search

**Date:** 2026-09-15
**Source:** Ahrefs API v3, country = us. `site-explorer-organic-keywords` (mode=subdomains,
top 40 by volume, 3 domains)
**Data file:** `docs/tripprintables-round7-niche-competitor-check.csv`
**Builds on:** `docs/TRIPPRINTABLES-ROUND2-SEASONALITY-COMPETITOR.md` (round two — checked
gdoc.io, found it's a career-document mill with travel as a side category),
`docs/TRIPPRINTABLES-ROUND4-COMPETITOR-SERP.md` (round four — checked smartertravel.com and
justagirlandherblog.com, same "not a specialist" finding), `docs/TRIPPRINTABLES-ROUND5-SERP-OVERVIEW-FULL.md`
(round five, whose 98-keyword sweep surfaced the three domains checked here as the most
frequent recurring leaders)

---

## The question

Round one inferred the packing-list space was under-served based on gdoc.io not being a real
specialist. Rounds two and four verified that against three named domains (gdoc.io,
smartertravel.com, justagirlandherblog.com) and found the same pattern each time: real content,
real traffic, but travel/packing is a minor side category in a broader-focus business, not a
defended niche. This round checks the three domains that came up most often as top-ranking
pages across round five's full 98-keyword SERP sweep, to see if any of them breaks that
pattern.

## Findings

**None of the three is a genuine travel-printables specialist. The search is still open.**

- **`gatherandgotravel.com` is the closest analog found across all rounds so far, but still
  not a specialist.** Itinerary and packing terms make up 25% of its top 40 organic keywords
  by volume (10 of 40) — roughly 5x the density found on any previously-checked domain. But
  its actual top keyword is a general destination guide (`door county wisconsin`, 20,000/mo)
  and its top-40 list is dominated by regional travel-guide content (Missoula, Glacier Park,
  Saugatuck, Sedona's Cathedral Rock) and travel-tool terms (AutoSlash, InsureMyTrip,
  Flytographer). It's a genuine, broad travel blog that happens to cover itinerary/packing
  content unusually well — not a site built around printables as its identity.
- **`thegoodocs.com` confirms the exact gdoc.io pattern.** It's structurally the same business
  as gdoc.io: a general office/school-document template mill. Invoice templates (88,000/mo),
  resume templates (62,000/mo), Google Slides themes, budget spreadsheets, Cornell notes,
  family tree templates, fake doctor's notes, and missing-poster templates all outrank
  `itinerary template` (16,000/mo, its own best position only #14 in its top 40). Travel is a
  minor category, same as gdoc.io.
- **`livelikeitstheweekend.com` is a large, successful general travel publisher, not a niche
  site.** Its top keywords are destination guides at real scale (`copenhagen` 210,000/mo,
  `dolomites` 146,000/mo, `oaxaca` 111,000/mo) — this is a full travel-content business.
  Packing list (22,000/mo, position 5) and "how to pack a suitcase" (56,000/mo) are real,
  well-ranking categories, but a small fraction of a much bigger destination-guide operation.
  Same structural pattern as smartertravel.com in round four, just a bigger site.

## What this changes

**Six domains checked across four rounds (gdoc.io, smartertravel.com,
justagirlandherblog.com, gatherandgotravel.com, thegoodocs.com, livelikeitstheweekend.com) —
zero genuine travel-printables specialists found.** This is no longer a thin inference from one
soft SERP check; it's a consistent pattern across every real competitor investigated so far.
The packing-list and itinerary-template space genuinely does not have a defended,
identity-level incumbent the way, say, resume templates has Zety or Novoresume. The nearest
thing to a threat is `gatherandgotravel.com`'s unusually strong itinerary/packing coverage
inside a broader travel-blog business — worth a competitive glance if TripPrintables' own
itinerary-format or packing-hub pages underperform expectations after launch, but not a reason
to change strategy now.

## What was NOT done

- **No further domain checks.** ricksteves.com, REI, and OutdoorGearLab were explicitly
  deprioritized in round four as large general-authority sites likely to repeat the same
  finding; that reasoning still holds and wasn't revisited here.
- **No content-gap or backlink-gap analysis on gatherandgotravel.com specifically**, despite
  it being the closest analog found. If a future round wants to go deeper on this one domain,
  a `site-explorer-organic-keywords` pull filtered to just packing/itinerary-intent keywords
  (rather than top-40-by-volume overall) would show its actual packing/itinerary content
  strategy more precisely than this pass's broad-volume cut does.

## Unit cost note

Three `site-explorer-organic-keywords` calls (mode=subdomains, 40 rows each) ran **880 units
each — 2,640 units total.** Combined with round five (24,724) and round six (9,200), this
session's confirmed Ahrefs spend is roughly 36,600 units against the 200,000 monthly allowance
(workspace usage stood at 79,175 at last check) — well inside budget.
