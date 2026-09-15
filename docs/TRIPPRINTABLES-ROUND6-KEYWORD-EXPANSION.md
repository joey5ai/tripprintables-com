# TripPrintables Round Six: Keyword Expansion Across Both Hubs

**Date:** 2026-09-15
**Source:** Ahrefs API v3, country = us. `keywords-explorer-matching-terms` (match_mode=terms),
four seed pulls: `packing list`, `itinerary template`, `travel checklist`, `travel planner`
**Data file:** `docs/tripprintables-round6-keyword-expansion.csv` (20 new candidate terms)
**Builds on:** `docs/keyword-map.csv` (109 terms, the existing map this pass expands)

---

## What this pass found

Four broad-match pulls (100 results each, ~400 keywords surfaced total) against the two hub
root terms plus two adjacent framings (checklist, planner). After filtering out terms that
just duplicate an existing keyword-map row under different word order, and terms that fall
into an already-EXCLUDE category (moving/baby/hospital/shipping/military packing — these kept
surfacing as adjacent matches, which is a good sign the original exclusion decisions were
right, not an oversight), **18 genuinely new on-topic candidates** came out of it, plus 2 rows
flagged as data-quality noise rather than real opportunities.

**Pack-it hub gets 16 new candidates**, split three ways:
- **7 new destination terms** (mexico, thailand, cancun, camino de santiago, kilimanjaro,
  alaska, caribbean cruise) — all zero-to-low KD, following the exact same soft pattern round
  five documented for the destination cluster already in the map. No reason to expect these
  behave differently.
- **4 new trip-type terms** (hiking, overnight, rv, carry-on) — hiking and RV pair naturally
  with the already-mapped backpacking/car-camping cluster; carry-on packing list is a genuinely
  new sub-cluster (luggage-constraint framing, not trip-type framing) worth noting as a
  possible future cluster of its own if it expands.
- **2 new occasion terms** (burning man, bachelorette packing list) plus **1 niche
  professional-audience term** (travel nurse packing checklist) — small volume individually but
  each represents a distinct search intent not covered anywhere in the current 109-term map.
- **One high-volume framing variant worth flagging on its own: `international travel
  checklist` (2,700/mo, KD 11).** This is nearly double the volume of the already-mapped
  `international travel packing list` (1,400/mo) under checklist rather than list framing.
  Worth a strong on-page synonym target at minimum, possibly its own page if the checklist
  framing SERP turns out to rank differently (not checked yet — see What Was Not Done below).

**Plan-it hub gets 3 new candidates:** `disney itinerary template` (the itinerary-side
equivalent of the already-mapped disney packing list), `road trip itinerary template` (pairs
with the already-mapped road trip packing list), and `business travel itinerary template`
(flagged WATCH, not ADD — see below).

**One flagged for a brand-fit judgment call, not an automatic add:** `business travel
itinerary template` (350/mo, KD 5) has more than double the volume of the already-mapped
`business trip itinerary template` (150/mo) at the same near-zero difficulty, and carries a
$300 CPC — strong commercial intent. It's a genuine keyword opportunity, but it pulls the site
further from "vacation/trip" framing toward generic business-travel content, which is a scope
question for whoever owns positioning, not a data question.

**Two rows flagged as data-quality noise, not opportunities:** `packing list for snowshoeing`
(1,000/mo) and `your travel packing list for france vacation` (900/mo) both returned with
`null` difficulty, `null` CPC, and no `parent_topic` — the signature of a low-confidence or
mis-clustered match rather than a verified real search pattern. Ahrefs' own volume estimate for
oddly-phrased or narrow long-tail queries can be unreliable in exactly this way; these
shouldn't be built on without independent verification (a `keywords-explorer-search-suggestions`
or SERP check would confirm one way or the other, not done here).

**`travel planner` as a seed mostly returned off-topic intent.** The majority of matches were
app/AI-tool/travel-agent queries (Wanderlog, AI travel planners, "how to become a travel
planner," corporate travel management) rather than downloadable-template intent — which
actually reinforces keyword-map's existing decision to `EXCLUDE` "travel planner app" as
software-intent. Nothing new and on-topic came out of that seed beyond variants already
covered by the itinerary-template pulls.

## What this changes

No immediate build-order changes — these are candidates for the backlog, not verified builds.
The destination and trip-type additions are low-risk, low-effort additions to their existing
clusters (same shape as terms already validated in round five). `international travel
checklist`'s volume is the one number here worth acting on with more than a shrug: it's a
real gap in the current map's coverage of that intent.

## What was NOT done

- **No SERP overviews pulled for any of these 20 candidate terms.** This pass is keyword
  discovery only — competitive-softness verification (the round-five treatment) is separate
  follow-up work if any of these get promoted from "candidate" to "planned."
- **No deeper related-terms/search-suggestions expansion** beyond the four broad-match seed
  pulls. A `keywords-explorer-related-terms` pass (which surfaces "also rank for" and "also
  talk about" terms rather than string-matching) could turn up non-obvious adjacent intent this
  pass wouldn't catch, but wasn't run here.
- **The two data-quality-flagged rows were not independently re-verified.** They're flagged,
  not resolved — a follow-up check would confirm whether they're real before anyone considers
  building against them.

## Unit cost note

Four `keywords-explorer-matching-terms` calls (100 rows each) ran **2,300 units each — 9,200
units total.** Combined with round five's 24,724 units, this session's confirmed Ahrefs spend
is now roughly 34,000 units against the 200,000 monthly allowance (workspace usage stood at
76,535 at last check) — well inside budget.
