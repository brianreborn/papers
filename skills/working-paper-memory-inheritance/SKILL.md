---
name: working-paper-memory-inheritance
description: Produce or reproduce the working paper A Working Theory of Memory-like Trait Inheritance and similar scholarly working papers from peer-reviewed literature. Use when asked to recreate the memory-inheritance paper, extend its causality chain, regenerate the LaTeX/PDF, publish to the papers repo, or build analogous working papers that assemble chronological literature into an explicit causal argument with labeled stop-gap bridges. Publishing requires full LaTeX verified on GitHub first; never commit placeholders; PDFs are user-upload or Release assets.
---

# Working Paper — Memory-like Trait Inheritance

Reproduce or extend the working paper whose canonical home is the public GitHub repository `brianreborn/papers`.

## Core Thesis (do not alter without explicit user instruction)

> Experiences can epigenetically pass behavioral tendencies to offspring.

The transmitted phenotype is framed as adaptive sensitivity / behavioral tendency, not full autobiographical episodic content.

## Canonical Locations

- GitHub repo (public): https://github.com/brianreborn/papers
- Paper directory: `memory-like-trait-inheritance/`
- Canonical source: `Memory_Inheritance_Working_Paper.tex`
- Originating public statement: https://x.com/born_brian85001/status/2092254278077517988 (25 Aug 2026)

## Required Process

1. **Start from the public statement or user thesis**  
   Record the originating tweet or equivalent claim. Keep the link live in the document.

2. **Assemble chronological peer-reviewed literature**  
   Maintain the existing ordered list (Chomsky 1957–1968 → Clayton & Dickinson 1998 → Herb et al. 2012 + related honeybee DNA-methylation work → Dias & Ressler 2014 → Dias et al. 2015 → Berwick & Chomsky 2016 → Fitz-James & Cavalli 2022 → 2022–23 insect/olfactory updates → Yang-related / eLife 2023 → Deshe et al. 2023).  
   For every entry supply:
   - Full citation
   - Live DOI or stable URL (prefer DOI)
   - One-sentence summary
   - Explicit causal-role sentence linking it to the thesis  
   Emphasize DNA methylation (CpG hypomethylation, Dnmt, reversible methylation states) wherever it is mechanistically central.
   Never leave placeholder titles such as “Related work” or “et al. work”. Every entry must carry full author list (or “First Author et al.” when >5 authors is acceptable), full title, journal/venue, year, and a live DOI or stable URL.
   Prefer a companion .bib (BibTeX) file as the bibliographic source of truth. In the PDF, render DOIs in compact breakable form (e.g. doi:\url{10.xxxx/xxxxx}) using the xurl package so long links never run off the page. Avoid spelling out full https://doi.org/... URLs in the visible text.

3. **Build the causality chain with labeled stop-gaps**  
   Empirical nodes must remain solid.  
   Explicitly identify and label three stop-gap bridges:
   - SG1 Interface — innate computational core (Chomsky) can still be tuned by experience-dependent epigenetic marks
   - SG2 Cross-species homology — mouse / insect / nematode sensory & associative sensitivities → human behavioral tendencies
   - SG3 Content vs Tendency — what transmits is adaptive sensitivity/bias, not the full autobiographical episode  
   Treat stop-gaps as reasoned bridges that close empirical gaps, never as obstacles that invalidate the chain.

4. **Produce LaTeX as the canonical archival form**  
   Use a clean `article` class document with:
   - Title + subtitle matching the existing wording
   - Authors: Brian Fundakowski Feldman¹, Grok/SuperGrok²
   - Abstract, numbered sections, chronological literature, discussion, accessible thesis statement, TikZ causality diagram
   - hyperref live links, consistent navy/teal/orange color scheme  
   Compile with `pdflatex` (two passes). The `.tex` file is the source of truth; the PDF is a derived artifact.

5. **Publish or update the public repository**  
   Owner: `brianreborn`  
   Repo: `papers` (public)  
   Place source under `memory-like-trait-inheritance/`.  
   Keep the root README accurate (thesis, prominent links to source + PDF + prior-art, build instructions).  
   Prefer `github___push_files` or `github___create_or_update_file` after confirming the authenticated user is `brianreborn`.

   **Publishing rules (learned the hard way — do not skip):**
   - **Canonical = LaTeX first.** The full `.tex` must be verified on GitHub (correct size, contains key sections: Minimalist/Merge framing, Biergans entry, Author's Prior Public Commentary, `\end{document}`) *before* declaring the paper published.
   - **Never commit placeholders or stubs to `main`.** If a tool call would write `PLACEHOLDER`, truncated content, or a partial file, abort and retry. Incomplete pushes must not land on the default branch.
   - **PDF is a derived artifact.** The connected GitHub tools are text-oriented and unreliable for binary PDFs. Prefer: (1) user uploads the compiled PDF via the GitHub web UI to the exact path `memory-like-trait-inheritance/Memory_Inheritance_Working_Paper.pdf`, or (2) a GitHub Release asset. Do not claim a PDF link is live until that path exists and matches the expected size of the current build.
   - **No version-suffix drift.** Do not leave parallel names such as `…-2.pdf`. One canonical PDF name only.
   - **Durable intermediates stay in `artifacts/`.** Do not rely solely on `/tmp` for recovered commentary, filtered extracts, or staged Markdown — session cleanup can erase them between turns.
   - **Atomic “done” checklist before announcing links:**
     - [ ] Full `.tex` on GitHub (size and key strings verified)
     - [ ] PDF at the exact canonical path (or explicitly noted as “upload pending”)
     - [ ] Prior-art / companion Markdown present if the paper cites it
     - [ ] Root README links match actual paths
     - [ ] No placeholder files, no `-2` leftovers

6. **Archival resilience for linked publications**  
   Primary links are DOIs and publisher pages.  
   When a live link is threatened or the user requests resilience, note that archive.org and Google Scholar / publisher archives serve as fallback.  
   Do not invent DOIs or fabricate citations. If a reference becomes unreachable, record the best surviving archive URL and the original citation string.

## Reproduction Checklist

When asked to “reproduce the paper” or “rebuild from the skill”:

- [ ] Confirm thesis wording is unchanged unless the user explicitly revises it
- [ ] Verify all literature entries still have working DOIs or archive fallbacks
- [ ] Regenerate the TikZ diagram with the three labeled stop-gaps
- [ ] Write / update the full `.tex` source (never a placeholder)
- [ ] Compile PDF locally into `artifacts/`
- [ ] Push **full** `.tex` to `brianreborn/papers` and verify size/content on GitHub
- [ ] PDF: user upload or Release asset to exact path `Memory_Inheritance_Working_Paper.pdf` (do not force binary through text tools)
- [ ] Update README so Quick Links match real paths; remove any `-2` or stale names
- [ ] Only after the atomic checklist above passes, tell the user the paper is published

## Limitations (explicit)

- Linked publications may disappear from their original hosts. Rely on DOI resolvers first, then archive.org / Google Scholar caches.
- The skill encodes the *process* and the *current causal structure*; it does not store the full text of the cited papers.
- Stop-gaps remain interpretive bridges. Do not present them as experimentally closed.

## Related Resources

- `references/literature-core.md` — current ordered literature list with DOIs and causal roles
- `references/stop-gaps.md` — precise wording of the three stop-gap bridges
- GitHub repo `brianreborn/papers` is the live public home
