# Student Guide: Writing Your IUC Thesis with This Template

> An illustrated, step-by-step version of this guide is in the
> [User Manual (PDF)](docs/IUC-LaTeX-Template-User-Manual.pdf).

You do **not** need to learn LaTeX to use this template. You type your own
words into a few files. The template does all the formatting required by the
IUC Thesis & Dissertation Style Manual: margins, fonts, spacing, page
numbers, contents page, lists, captions, and APA 7 references.

---

## 1. Choose how you will work

Pick **one** option. If you are unsure, use Option A or B.

| Option | What you do | Install anything? | Difficulty |
|---|---|---|---|
| **A. Overleaf** (website) | Upload the template, type, click *Recompile* | No | Easiest |
| **B. Claude Code** | Tell Claude what to change in plain words; it edits and builds the PDF | No (needs a Claude plan) | Easy |
| **C. GitHub in the browser** | Edit files on github.com; the PDF is built for you | No | Medium |
| **D. Your own computer** | Install TeX Live or MacTeX and an editor | Yes (about 4 GB) | Hardest |

### Option A: Overleaf

> Not yet tested by the template maintainers. Check that the sample PDF
> builds before you start writing.

1. On the template's GitHub page, click **Code → Download ZIP**.
2. Go to [overleaf.com](https://www.overleaf.com), sign in, and choose
   **New Project → Upload Project**, then select the ZIP file.
3. Open **Menu** (top left) and set **Compiler** to **XeLaTeX**.
4. Click **Recompile**. You should see the sample thesis.

### Option B: Claude Code

1. On the template's GitHub page, click **Use this template** (or **Fork**)
   to make your own copy of the repository.
2. Start a Claude Code session on claude.ai/code with your copy selected.
3. Ask in plain words, for example:
   - "Put my details in metadata.tex: title …, name …, matric number …"
   - "Replace section 1.1 with this text: …"
   - "Add this table to Chapter 4 with the caption …"
   - "Build the PDF and show me page 5."

### Option C: GitHub in the browser

1. Click **Use this template** (or **Fork**) to make your own copy.
2. Open a file, click the **pencil icon**, edit, then **Commit changes**.
3. Open the **Actions** tab, click the latest run, and download
   **iuc-thesis-pdf** under *Artifacts*. It contains your PDF.

### Option D: Your own computer

Install [TeX Live](https://tug.org/texlive/) (Windows or Linux) or
[MacTeX](https://tug.org/mactex/) (macOS), and
[VS Code](https://code.visualstudio.com/) with the **LaTeX Workshop**
extension. Open the template folder, open `main.tex`, and click the green
**Build LaTeX project** button (▶). Or, in a terminal, run:

```bash
latexmk main.tex
```

---

## 2. The only files you need to edit

| File | What to put there |
|---|---|
| `metadata.tex` | Title, your name, matric number, address, degree, dates |
| `main.tex` | Only the first line: `thesis`, `dissertation`, or `project` |
| `frontmatter/acknowledgement.tex` | Your acknowledgement |
| `frontmatter/abstrak.tex` | Malay abstract (comes first) |
| `frontmatter/abstract.tex` | English abstract |
| `chapters/chapter1.tex` … `chapter5.tex` | Your chapters |
| `appendices/appendixA.tex` | Appendix material |
| `references.bib` | Your reference list |
| `figures/` | Your images (PNG, JPG, or PDF) |

Do **not** edit `iucthesis.cls`. It holds the formatting rules.

---

## 3. The golden rules

1. **Change only the text inside `{ }`** in `metadata.tex`.
2. **Lines that start with `\` are commands.** Keep them, and copy them when
   you need another one.
3. **A blank line starts a new paragraph.** Pressing Enter once does not.
4. **These characters are special:** `% $ & # _ { }`. To print them as
   text, put a backslash in front: `\%`, `\$`, `\&`, `\#`, `\_`. For example,
   write `50\%`, not `50%`.
5. **Change one thing at a time, then recompile.** If something breaks, you
   know what caused it.
6. **Do not fix formatting by hand.** No extra blank lines, manual spacing,
   or manual numbering. The template does it.

---

## 4. Copy-and-paste examples

### Headings

```latex
\chapter{Literature Review}
\section{Leadership Theories}
\subsection{Transformational Leadership}
```

Only these three levels are allowed (Manual 10.2).

### Citations (APA 7)

| You want | Type this | You get |
|---|---|---|
| Author in the sentence | `\textcite{smith2023}` | Smith (2023) |
| Author in brackets | `\parencite{smith2023}` | (Smith, 2023) |
| Two sources | `\parencite{smith2023,lee2021}` | (Lee, 2021; Smith, 2023) |
| With a page | `\parencite[p.~18]{smith2023}` | (Smith, 2023, p. 18) |

`smith2023` is the **key** of the reference in `references.bib`.

### Adding a reference

Google Scholar, Zotero, Mendeley, and EndNote can all export **BibTeX**.
Copy the entry into `references.bib`. It looks like this:

```bibtex
@article{smith2023,
  author  = {Smith, Jane and Lee, Ahmad},
  title   = {Leadership in Higher Education},
  journal = {Journal of Education},
  volume  = {12},
  number  = {3},
  pages   = {45--60},
  year    = {2023},
  doi     = {10.1234/abcd}
}
```

The reference list is sorted and formatted automatically. Only sources you
cite appear in it.

### Table (caption goes above)

```latex
\begin{table}[htbp]
  \caption{Respondent Demographics}
  \label{tab:demographics}
  \begin{tabular}{lcc}
    \toprule
    Group  & Number & Percentage \\
    \midrule
    Male   & 120    & 48\% \\
    Female & 130    & 52\% \\
    \bottomrule
  \end{tabular}
  \tablenote{Percentages are rounded.}
\end{table}
```

In the text, write `Table~\ref{tab:demographics}`. The number is filled in
for you.

### Figure (caption goes below)

Put the image in the `figures/` folder, then:

```latex
\begin{figure}[htbp]
  \includegraphics[width=0.8\textwidth]{figures/my-chart}
  \caption{Research Framework}
  \label{fig:framework}
  \figuresource{Adapted from Smith (2023).}
\end{figure}
```

In the text, write `Figure~\ref{fig:framework}`.

### Equation

```latex
\begin{equation}
  y = a + bx
  \eqtitle{Linear Regression Model}
  \label{eq:regression}
\end{equation}
```

`\eqtitle{...}` adds the equation to the List of Equations.

### Long quotation (40 words or more)

```latex
\begin{quote}
The quoted text goes here ... \parencite[p.~18]{smith2023}
\end{quote}
```

### Adding or removing a chapter

In `main.tex`, add or delete a line such as:

```latex
\include{chapters/chapter6}
```

Then create (or delete) the matching file in `chapters/`.

---

## 5. When something goes wrong

| Message or problem | Usual cause | Fix |
|---|---|---|
| `Missing $ inserted` | A `_` or `^` in normal text | Write `\_` or `\^{}` |
| Part of a line disappears | A `%` in the text (starts a comment) | Write `\%` |
| `Runaway argument` / `Missing }` | An unclosed `{` | Find the `{` without its `}` |
| `Undefined control sequence` | Typo in a command | Check the spelling after `\` |
| `Citation 'xyz' undefined` | Key not in `references.bib`, or not built yet | Check the key; recompile |
| `??` instead of a number | References not updated yet | Recompile once more |
| `\subsubsection is not permitted` | Fourth heading level | Use `\subsection` or restructure |
| A new table or figure is missing from the list | Lists update on the next build | Recompile once more |
| Text in the wrong font | Times New Roman not installed | Normal; the look-alike font is used |

**Still stuck?** Copy the error message and the lines around it into Claude
and ask: "This is my IUC LaTeX thesis. What does this error mean and how do I
fix it?"

---

## 6. Using Claude to help you write

Claude can write the LaTeX for you, so you can focus on content. Useful
requests:

- "Turn this Excel table into a LaTeX table for my IUC template, with the
  caption *Regression Results* and a note."
- "Make BibTeX entries for these references: …"
- "Check this paragraph for APA 7 citation format."
- "Convert this Word paragraph into LaTeX and escape special characters."

**Check everything Claude writes.** You are responsible for accuracy,
citations, and academic integrity.

---

## 7. Before you submit

Go through the **Final Manuscript Review Checklist** in the Style Manual
(Section 18), and also check:

- [ ] Title and name match your registration records exactly.
- [ ] The right document type (`thesis`, `dissertation`, or `project`) is set
      in `main.tex`.
- [ ] Both abstracts say the same thing.
- [ ] No sample text from the template is left.
- [ ] Every citation appears in the references, and every reference is cited.
- [ ] The contents page and lists match the headings and captions.
- [ ] Every page is checked in the final PDF.
- [ ] The PDF is named clearly, e.g. `StudentID_Surname_Thesis.pdf`.

The outer cover and spine colours (purple for master's, black for doctoral)
and the gold lettering are done by the binder. The `spine.pdf` file shows the
binder the spine layout.
