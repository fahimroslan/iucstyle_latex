# IUC Thesis LaTeX Template

LaTeX template for Innovative University College (IUC) theses, dissertations,
and research projects. It implements the **IUC Thesis & Dissertation Style
Manual, Edition 3.0** (issued 23 October 2026): margins, fonts, spacing,
headings, pagination, contents and lists, captions, APA 7 references,
appendices, cover, title page, and spine.

**New to LaTeX?** Start with the [Student Guide](STUDENT_GUIDE.md).

The manual remains the authority. If this template and the manual disagree,
follow the manual and please open an issue.

## Requirements

- A TeX distribution: [TeX Live](https://tug.org/texlive/) (Linux, Windows) or
  [MacTeX](https://tug.org/mactex/) (macOS). A full install includes
  everything needed.
- Engine: **XeLaTeX** (LuaLaTeX also works). pdfLaTeX is not supported.
- Bibliography: **biber** with `biblatex-apa` (both in TeX Live / MacTeX).

On Debian/Ubuntu, a minimal install is:

```bash
sudo apt install texlive-xetex texlive-latex-extra texlive-bibtex-extra biber texlive-fonts-recommended fonts-texgyre latexmk
```

## Build

```bash
latexmk main.tex
```

`latexmkrc` selects XeLaTeX and runs biber as needed. The output is `main.pdf`.
Run it twice after adding or removing tables, figures, equations, or
appendices so that the lists update.

For the binder's spine strip:

```bash
latexmk spine.tex
```

To remove build files:

```bash
latexmk -c
```

Every push to GitHub also builds `main.pdf` and `spine.pdf`
(see `.github/workflows/build.yml`; download them from the run's artifacts).

## Fonts

The manual specifies Times New Roman (text) and Arial Narrow (cover, spine).
The class uses them automatically if they are installed on your computer
(standard on Windows and macOS). Otherwise it falls back to free metric-compatible
fonts that ship with TeX Live, and prints a warning in the log:

| Manual           | Fallback          |
|------------------|-------------------|
| Times New Roman  | TeX Gyre Termes   |
| Arial Narrow     | TeX Gyre Heros Cn |

Maths uses TeX Gyre Termes Math, which matches Times. All fonts are embedded in
the PDF, as the manual requires.

## Files

```
iucthesis.cls        formatting rules (do not edit)
main.tex             document order; choose class options here
metadata.tex         your title, name, degree, dates  <- edit first
frontmatter/         acknowledgement, abstrak, abstract, optional pages
chapters/            chapter1.tex ... chapter5.tex
appendices/          appendixA.tex ...
references.bib       your references (BibTeX/biblatex format)
figures/             images
spine.tex            spine strip for the binder
```

## Getting started

1. Edit `metadata.tex` with your registered details. Use `\\` in the title to
   break it into balanced lines.
2. Choose the document type in `main.tex`:
   `\documentclass[thesis]{iucthesis}`; use `dissertation` or `project` if
   applicable. This changes the title-page and declaration wording.
3. Replace the sample text in `frontmatter/`, `chapters/`, and `appendices/`.
4. Add references to `references.bib` and cite them (see below).
5. Build and check every page of `main.pdf` (Manual 18 checklist).

## Writing with the template

### Structure

Use `\chapter`, `\section`, and `\subsection` only. `\subsubsection` and
`\paragraph` stop the build with an error, because the manual allows three
levels (Manual 10.2). Write titles in title case; chapter titles are made
uppercase automatically.

Combine or split chapters by adding or removing `\include` lines in `main.tex`.

### Front matter

| Command / environment          | Page                                |
|--------------------------------|-------------------------------------|
| `\makecover`                   | Outer cover (white, no page number) |
| `\maketitlepage`               | Title page (Roman i, hidden)        |
| `\makedeclaration`             | Author declaration (Roman ii)       |
| `acknowledgement`              | Acknowledgement                     |
| `dedication`                   | Optional dedication                 |
| `abstrak`, `abstract`          | Malay then English abstract         |
| `\keywords{...}`               | Optional keywords inside an abstract|
| `\tableofcontents`             | Table of contents                   |
| `\listoftables`, `\listoffigures`, `\listofequations`, `\listofappendices` | Lists |
| `frontpage{Title}`             | Any other page, e.g. List of Abbreviations |

A list with no entries is omitted automatically, together with its contents
entry.

### Tables

```latex
\begin{table}[htbp]
  \caption{Sample Quantitative Results}   % caption above
  \label{tab:results}
  \begin{tabular}{lccc}
    \toprule
    Model & Precision & Recall & F1-score \\
    \midrule
    Baseline & 0.78 & 0.74 & 0.76 \\
    \bottomrule
  \end{tabular}
  \tablenote{Higher values indicate better performance.}
\end{table}
```

Tables are numbered by chapter (Table 4.1), centred, and single-spaced. For
wide tables use `\begin{landscape} ... \end{landscape}` (pdflscape); for long
tables use `longtable`.

### Figures

```latex
\begin{figure}[htbp]
  \includegraphics[width=0.7\textwidth]{figures/accuracy}
  \caption{Validation Accuracy by Training Stage}   % caption below
  \label{fig:accuracy}
  \figuresource{Illustrative data.}
\end{figure}
```

### Equations

Add `\eqtitle{Short title}` inside each numbered equation so it appears in the
List of Equations (Manual 14):

```latex
\begin{equation}
  E = mc^2
  \eqtitle{Mass-Energy Equivalence}
  \label{eq:energy}
\end{equation}
```

### Citations (APA 7)

| Form          | Command                         | Output                    |
|---------------|---------------------------------|---------------------------|
| Narrative     | `\textcite{lamport1994}`        | Lamport (1994)            |
| Parenthetical | `\parencite{lamport1994}`       | (Lamport, 1994)           |
| Multiple      | `\parencite{knuth1984,lamport1994}` | (Knuth, 1984; Lamport, 1994) |
| Page          | `\parencite[p.~18]{lamport1994}`| (Lamport, 1994, p. 18)    |

`\printreferences` prints the REFERENCES list: double-spaced, 1.27 cm hanging
indent, alphabetical. Check the output against your sources; reference
managers make mistakes.

Quotations of 40 words or more go in `\begin{quote} ... \end{quote}`.

### Appendices

After `\appendix`, each `\chapter{Title}` becomes APPENDIX A, B, ... and is
added to the contents and the List of Appendices.

## Rules implemented

| Rule (Manual section)                    | Setting                                   |
|------------------------------------------|-------------------------------------------|
| Paper (2)                                | A4                                        |
| Margins (8.1)                            | top 30, bottom 25, left 38, right 25 mm   |
| Chapter, appendix, references opening (8.1) | top 40 mm                              |
| Cover and title page (5)                 | 60 / 40 / 40 / 25 mm                       |
| Body text (8.2, 8.3, 10.1)               | 12 pt, double-spaced, 2 em indent, 6 pt after, justified |
| Front matter, tables, captions (6, 8.2)  | single-spaced                             |
| Headings (10.2)                          | 12 pt bold; chapter centred uppercase; 24 pt before / 12 pt after sections |
| Page numbers (9)                         | centred, footer baseline 12.5 mm from bottom; Roman i (hidden) on title page, Arabic 1 at Chapter 1 |
| Contents (6.5)                           | chapters and sections; chapter entries without page numbers |
| Numbering (12-14)                        | by chapter: Table 4.1, Figure 4.1, (3.1)  |
| References (15)                          | APA 7 (biblatex-apa), double-spaced, 1.27 cm hanging indent |
| Cover (5.1)                              | 18 pt Arial Narrow, bold uppercase        |
| Spine (5.1)                              | 16 pt Arial Narrow, bold uppercase, 60 mm clear at each end |

Not handled by the template: word counts (Manual 3), cover colour and gold
stamping (done by the binder: purple for master's, black for doctoral), and
the content checks in the Manual 18 checklist.

## Checking margins

Add `showframe` to the class options to draw the text area on every page:

```latex
\documentclass[thesis,showframe]{iucthesis}
```

Remove it before submission.

## Known limitations

- The Malay abstract is hyphenated with English rules. Check its line breaks.
- Double spacing uses LaTeX's standard `\doublespacing` (setspace), which is
  slightly tighter than Word's "Double".

## Licence

`iucthesis.cls` is distributed under the
[LaTeX Project Public License](https://www.latex-project.org/lppl/),
version 1.3c or later (see `LICENSE`). If you distribute a modified version
of the class, give it a different name.

The sample files (`main.tex`, `metadata.tex`, `spine.tex`, `frontmatter/`,
`chapters/`, `appendices/`, `references.bib`, `figures/`) may be used freely as
the starting point for your own thesis, with no conditions. Your thesis
content is yours.
