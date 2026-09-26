#!/bin/bash
# Build: pdflatex; bibtex; pdflatex; pdflatex -> artifacts/
cd "$(dirname "$0")/.." || exit 1
python3 build/mkquotes.py >/dev/null
J=Water_Spinach_Working_Paper
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=artifacts $J.tex > artifacts/build1.log 2>&1 || { grep -A5 '^!' artifacts/$J.log | head -30; exit 1; }
( cd artifacts && BIBINPUTS=..: bibtex $J > bibtex.log 2>&1 ); grep -i "warning\|error" artifacts/bibtex.log | head
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=artifacts $J.tex > /dev/null 2>&1
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=artifacts $J.tex > /dev/null 2>&1 || { grep -A5 '^!' artifacts/$J.log | head -30; exit 1; }
echo "pages: $(pdfinfo artifacts/$J.pdf | awk '/Pages/{print $2}')"
grep -c "Overfull" artifacts/$J.log; grep "undefined\|Citation.*undefined\|Reference.*undefined" artifacts/$J.log | head
