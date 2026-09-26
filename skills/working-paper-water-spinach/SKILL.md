---
name: working-paper-water-spinach
description: Produce, reproduce or extend the working paper "Water Spinach and the Everyday Morning Glory" (Ipomoea aquatica flavonoid glycosides and modest cancer prevention). Use when asked to regenerate its LaTeX/PDF, extend its chronological literature core, update its stop-gaps, mechanism table or falsifiability table, or build similar diet-and-disease working papers from a public statement. Publishing requires full LaTeX verified on GitHub first. Never commit placeholders. PDFs go up by user upload or as a Release asset.
---

# Working Paper: Water Spinach and Modest Cancer Prevention

## Core thesis (do not alter without explicit user instruction)

> Regular dietary intake of water spinach (*Ipomoea aquatica*) plausibly contributes a modest cancer-preventive effect via its flavonoid glycosides.

This is not a cure claim. The paper must always state three things plainly:
- there is no human study of water spinach and cancer;
- the key compound's C-3 sugar is reported as alpha-linked, and its identification is tentative;
- ornamental morning-glory seeds (LSA, resin glycosides) are toxic and are not food.

## Canonical locations

- Paper directory: `water-spinach-cancer-prevention/`
- Canonical source: `Water_Spinach_Working_Paper.tex` plus `Water_Spinach_Working_Paper.bib` (unsrt; DOIs rendered as `doi:\url{...}` with xurl)
- Figures: `figures/*.tex` (TikZ; navy/teal/orange palette; shared legend in `figures/icons.tex`)
- Author's verbatim posts: `build/allquotes.json` -> `build/mkquotes.py` -> `figures/brianquotes.tex`. Never hand-edit quote text.
- Originating public statement: https://x.com/born_brian85001/status/2080792129669038191 (24 Jul 2026)

## Required process

1. **Originating statement and prior commentary.** Quote the author's posts verbatim in quote boxes, with handle, PT date and link. Leading reply @-handles may be omitted, but say so.
2. **Chronological literature core** (`references/literature-core.md`). Each entry needs a full citation, a live DOI (or PubMed URL if no DOI exists), a one-sentence summary and a causal-role sentence. Check every DOI at the doi.org handle API and resolver, confirm the title in Crossref/DataCite, and check PubMed for retraction or concern notices. Exclude retracted items and log them. Label preprints "not peer reviewed".
3. **Causal chain with labelled stop-gaps** (`references/stop-gaps.md`): E1-E4 empirical nodes; SG1 dose/bioavailability, SG2 cross-species homology, SG3 prevention vs cure.
4. **Proposed mechanism**, in the author's voice. Every step is tagged [Established] / [Reported in models] / [Proposed] with a citation, and mapped to the experiment that tests it. Draw only cellular actions the cited sources report.
5. **Proposed studies**: Step 0 bench/enzyme/microbiome assays; Step 1 meal PK; a cross-sectional survey (assumptions stated); an AOM/DSS animal study (5 arms, ARRIVE 2.0, 3Rs, sample size with stated assumptions).
6. **Falsifiability**: pre-stated results that would change the author's mind. Label all numbers as proposed thresholds.
7. **Counter-evidence, safety note, plain-language summary.** All are required.
8. **Build**: `bash build/build.sh` (pdflatex, bibtex, pdflatex x2, output to `artifacts/`). Require zero undefined references and zero overfull boxes, and grep for PLACEHOLDER/TODO/XXX. Render page 1 and every figure page to PNG and inspect them.

## Publishing rules (inherited)

- Verify the full LaTeX on GitHub first. Never commit placeholders.
- The PDF goes up by user upload or as a Release asset. No `-2` filename drift.
- bioRxiv does not post "hypotheses without new data". See `PUBLISHING-LESSONS.md` in the staging notes before choosing a venue.
