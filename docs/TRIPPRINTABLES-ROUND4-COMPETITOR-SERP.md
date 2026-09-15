# TripPrintables Round Four: Real Competitor Analysis + SERP Overview Batch 1

**Date:** 2026-09-15
**Source:** Ahrefs API v3, country = us. `serp-overview` (8 keyword-map rows, top 10
positions), `site-explorer-organic-keywords` (2 competitor domains, mode=subdomains,
top 40 by volume)
**Data files:** `docs/tripprintables-round4-serp-overview-batch1.csv`,
`docs/tripprintables-round4-competitor-analysis.csv`
**Priority order context:** this is priority 3 (real competitor analysis) and a first
installment on priority 4 (full SERP overviews on all 109 keyword-map rows) from the
standing priority order, done in the same session as the recovered round-three
seasonality and backlink-profile docs.

---

## SERP overview batch 1: 8 of 109 rows

Selected the pack-it hub root term (`packing list`) plus the highest-volume/priority
`NEW PAGE` rows from `docs/keyword-map.csv` not already checked in round one
(`cruise packing list`, `college packing list`) or round two (`packing list template`).
Full results in the CSV; the pattern by difficulty tier:

**Genuinely open (KD 0-10): camping, beach, disney.** No defended incumbent in any of
these three. Camping and beach packing list have essentially no real content
competitors in their top 10 — Reddit threads, Facebook groups, Quora answers, bare PDFs,
and a DR0 personal site hold real positions. Disney packing list (KD 0) has multiple
sub-DR30 niche blogs already ranking on page 1, including one at position 2, confirming
the KD rating is real and this is the easiest term in the batch.

**Moderate (KD 24-28): packing list (hub root), international travel packing list.**
Real authority at the top (smartertravel.com DR76 on the hub term, ricksteves.com DR77
on international) but genuine gaps in the DR7-42 range mid-pack. Buildable, not a fast
win.

**Low KD but thin real competition (KD 3-5): packing list for vacation, road trip
packing list.** Big-brand pages (Marriott, AAA, REI) hold generic, thin positions on
road trip packing list — they're ranking on domain authority, not content depth, which
is exactly the kind of position a genuinely better page can displace. One directly
relevant finding: **`fieldsandheels.com`** ranks position 9 on road trip packing list
with an explicit "free printable" brand angle — the first direct positioning match found
in any SERP checked across all four rounds.

**Hardest term checked (KD 11): backpacking packing list.** The only term in this batch
with no AI Overview and real authoritative content at the top — REI (DR87) and
OutdoorGearLab (DR75) both hold genuine gear-review depth, not just domain authority.
Not a fast win, though a DR1 site (restlessmeanderer.com) still cracked position 3, so
it isn't fully closed either.

**All 8 terms show a Google AI Overview except backpacking packing list.** Worth noting
for the site's GEO posture (see `docs/keyword-map.csv` and any future AI-Overview-focused
work): these SERPs are increasingly AI-summary-first, which raises the bar for what
"ranking" even means on generic packing-list queries.

---

## Real competitor analysis: two more "not actually a specialist" findings

Round two established that `gdoc.io`, the one named competitor identified by inference,
is actually a career-document template mill where travel is a minor side category. This
round checked the two domains that showed up most consistently as top-ranking
incumbents in the SERP batch above, to see if either is a genuine specialist worth
building around defensively.

**`smartertravel.com` is a general travel media site, not a packing-list
specialist.** Of its top 40 organic keywords by volume, only 2 relate to packing
(`packing list` at #4 by volume, `cruise packing list` at #29). Its actual content focus
is dog-friendly hotels, Airbnb-vs-hotel comparisons, luggage/suitcase reviews, hotel
reviews, and flight-price tracking — a broad travel publication where packing content is
one category among many, not a defended niche.

**`justagirlandherblog.com` is the closest positioning match found so far — and it's
still not a real competitor.** This is a home-organization/DIY blog with a genuine
"free printable" identity (printable calendars, grocery lists, budget templates), which
makes it structurally the closest analog to TripPrintables of anything checked across
all four rounds. But travel is still a minor side category: only 2 of its top 40
keywords relate to packing (`packing list` at position 14, `how to pack a suitcase` at
position 6), against a much larger core business of home organization, budgeting, and
general lifestyle content. Same structural pattern as gdoc.io and smartertravel.com:
broad content mill, travel as an afterthought.

**Three independent checks (gdoc.io in round two, smartertravel.com and
justagirlandherblog.com here) now confirm the same finding: nothing checked so far is a
dedicated, travel-focused, printable-specialist competitor.** The pack-it hub's
competitive field is open not because no one has tried packing-list content — several
large sites clearly have — but because none of them are built around it as a core
identity the way TripPrintables is.

---

## What this changes

No build-order changes. This reinforces round two's "genuinely open field" conclusion
with three more data points (2 more competitor domains, 8 more SERP checks) rather than
overturning it. One new tactical note: `fieldsandheels.com`'s direct "free printable"
positioning on road trip packing list is worth a competitive glance if/when that page
gets built, since it's the first same-category competitor found rather than a
side-category incumbent.

## What was NOT done / what's still open

- **101 of 109 keyword-map rows still have no live SERP overview.** This batch covered
  8. At the observed rate (~350-450 units/term), the remaining rows would cost roughly
  35,000-45,000 units as a single sweep — at or over the ~40k single-pull threshold in
  the standing budget guidance, and a large fraction of the ~60k soft session target on
  its own. Full coverage needs either explicit budget sign-off for a dedicated large
  pull, or spreading across several smaller sessions the way this one was scoped.
- **Only 2 competitor domains were deep-dived.** Other names that appeared in the SERP
  batch but weren't checked: ricksteves.com, REI, OutdoorGearLab — all large
  general-authority sites where a deep-dive would very likely repeat the same
  "not-a-specialist" finding, so they were deprioritized in favor of banking the
  SERP-overview budget instead.
- **No disavow, content-brief, or build-sequencing decisions were made from this data.**
  This is research only, matching the pattern of rounds one through three.

## Unit cost note

Eight `serp-overview` calls (`top_positions: 10`) ran 330-440 units each depending on
how many SERP-feature rows (AI Overview sitelinks, question boxes, etc.) were present —
**3,058 units total**. Two `site-explorer-organic-keywords` calls (40 rows each,
`mode=subdomains`) ran 1,280 units each — **2,560 units total**. Combined with the fresh
`site-explorer-backlinks-stats` check from the backlink-profile doc (50 units), this
round's confirmed spend is **5,668 units**. Session-wide (this recovery session across
round three and round four combined): roughly 10,000-10,300 units of confirmed new
spend, well inside the ~40k single-pull ceiling and ~60k soft session target from the
standing budget guidance. Workspace-wide usage (shared across this account's other
concurrent site-research work) stood at 45,913 of 200,000 at last check.
