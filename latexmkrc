# Build with XeLaTeX and biber:  latexmk main.tex
$pdf_mode = 5;            # xelatex
$bibtex_use = 2;          # run biber when needed; clean .bbl with -c
@default_files = ('main.tex');
