%% iucthesis.cls
%% LaTeX class for Innovative University College (IUC) theses,
%% dissertations, and research projects.
%%
%% Implements the IUC Thesis & Dissertation Style Manual, Edition 3.0
%% (issued 23 October 2026). Section numbers in comments (e.g. "Manual 8.1")
%% refer to that manual.
%%
%% Engine: XeLaTeX or LuaLaTeX (fontspec). Bibliography: biber.
%%
%% Candidates should not need to edit this file. Put your details in
%% metadata.tex and your writing in the chapter files.
%%
%% Copyright (C) 2026 the iucstyle_latex contributors
%%   https://github.com/fahimroslan/iucstyle_latex
%%
%% This work may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.3c of this license
%% or (at your option) any later version. The latest version of this
%% license is in https://www.latex-project.org/lppl.txt and version 1.3c
%% or later is part of all distributions of LaTeX version 2008 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%% The Current Maintainer of this work is the owner of the repository above.
%%
%% This work consists of the file iucthesis.cls. The sample files
%% (main.tex, metadata.tex, spine.tex, frontmatter/, chapters/,
%% appendices/, references.bib, figures/) may be used freely as a
%% starting point for your own thesis without restriction.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iucthesis}[2026/11/25 v1.0 IUC thesis class (Style Manual Ed. 3.0)]

% ---------------------------------------------------------------------------
% Options
% ---------------------------------------------------------------------------
%   thesis | dissertation | project   wording on the title page and declaration
%   showframe                         draw the text area (for checking margins)
%   spine                             typeset the spine strip only (spine.tex)
\newcommand\iuc@doctype{thesis}
\newcommand\iuc@Doctype{Thesis}
\DeclareOption{thesis}{%
  \renewcommand\iuc@doctype{thesis}\renewcommand\iuc@Doctype{Thesis}}
\DeclareOption{dissertation}{%
  \renewcommand\iuc@doctype{dissertation}\renewcommand\iuc@Doctype{Dissertation}}
\DeclareOption{project}{%
  \renewcommand\iuc@doctype{research project}\renewcommand\iuc@Doctype{Research project}}
\newif\ifiuc@showframe
\DeclareOption{showframe}{\iuc@showframetrue}
\newif\ifiuc@spine
\DeclareOption{spine}{\iuc@spinetrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\LoadClass[a4paper,12pt,oneside]{report}

% ---------------------------------------------------------------------------
% Engine check
% ---------------------------------------------------------------------------
\RequirePackage{iftex}
\ifTUTeX\else
  \ClassError{iucthesis}{This class needs XeLaTeX or LuaLaTeX}%
    {Compile with: latexmk -xelatex main.tex}
\fi

% ---------------------------------------------------------------------------
% Packages
% ---------------------------------------------------------------------------
\RequirePackage{etoolbox}
\RequirePackage{amsmath,amssymb}
\RequirePackage{fontspec}
\RequirePackage{unicode-math}
\RequirePackage[british]{babel}
\RequirePackage[style=american]{csquotes}% APA 7 uses double quotation marks
\RequirePackage{setspace}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{pdflscape}
\RequirePackage{enumitem}
\RequirePackage{calc}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{caption}

% ---------------------------------------------------------------------------
% Fonts (Manual 10.1)
%   Body:  Times New Roman 12 pt  -> fallback TeX Gyre Termes (metric clone)
%   Cover: Arial Narrow           -> fallback TeX Gyre Heros Cn
% The real fonts are used automatically when installed on the system.
% ---------------------------------------------------------------------------
\IfFontExistsTF{Times New Roman}{%
  \setmainfont{Times New Roman}%
}{%
  \ClassWarningNoLine{iucthesis}{Times New Roman not found; using TeX Gyre Termes}%
  \setmainfont{TeX Gyre Termes}%
}
\IfFontExistsTF{Arial Narrow}{%
  \newfontfamily\iuc@coverfont{Arial Narrow}%
}{%
  \ClassWarningNoLine{iucthesis}{Arial Narrow not found; using TeX Gyre Heros Cn}%
  \newfontfamily\iuc@coverfont{TeX Gyre Heros Cn}%
}
\setmathfont{TeX Gyre Termes Math}
\setmonofont{Latin Modern Mono}[Scale=MatchLowercase]

% ---------------------------------------------------------------------------
% Metadata (set these in metadata.tex)
% ---------------------------------------------------------------------------
\newcommand\iuc@title{Thesis Title}
\newcommand\iuc@author{Candidate Name}
\newcommand\iuc@matricno{}
\newcommand\iuc@address{}
\newcommand\iuc@degree{Degree Name}
\newcommand\iuc@degreeabbr{}
\newcommand\iuc@institution{Innovative University College}
\newcommand\iuc@submissiondate{Month Year}
\newcommand\iuc@submissionyear{}
\newcommand\iuc@declarationdate{\today}
\renewcommand\title[1]{\renewcommand\iuc@title{#1}}
\renewcommand\author[1]{\renewcommand\iuc@author{#1}}
\newcommand\matricno[1]{\renewcommand\iuc@matricno{#1}}
\newcommand\address[1]{\renewcommand\iuc@address{#1}}
\newcommand\degree[1]{\renewcommand\iuc@degree{#1}}
\newcommand\degreeabbr[1]{\renewcommand\iuc@degreeabbr{#1}}
\newcommand\institution[1]{\renewcommand\iuc@institution{#1}}
\newcommand\submissiondate[1]{\renewcommand\iuc@submissiondate{#1}}
\newcommand\submissionyear[1]{\renewcommand\iuc@submissionyear{#1}}
\newcommand\declarationdate[1]{\renewcommand\iuc@declarationdate{#1}}

% ---------------------------------------------------------------------------
% Spine mode: a 297 mm strip typeset on its own (see spine.tex)
% Manual 5.1 "Hardbound spine information"
% ---------------------------------------------------------------------------
\ifiuc@spine
  \RequirePackage{geometry}
  \RequirePackage{tikz}
  \newlength\spinewidth
  \setlength\spinewidth{16mm}% binder confirms the real width
  % paper = the spine strip; \spinewidth may be changed in the preamble
  \AtEndPreamble{\geometry{paperwidth=\spinewidth,paperheight=297mm,margin=0pt}}
  \newcommand\iuc@spinefont{\iuc@coverfont\bfseries\fontsize{16}{19}\selectfont}
  \newcommand\makespine{%
    \thispagestyle{empty}%
    \noindent\begin{tikzpicture}[x=1mm,y=1mm]
      % page outline and the two 60 mm clear zones (guides only)
      \useasboundingbox (0,0) rectangle (\spinewidth,297mm);
      \draw[gray!50] (0,0) rectangle (\spinewidth,297mm);
      \draw[gray!50,dashed] (0,237) -- (\spinewidth,237);
      \draw[gray!50,dashed] (0,60) -- (\spinewidth,60);
      % name starts at the upper printable boundary, reading top to bottom
      \node[rotate=-90,anchor=west,inner sep=0pt,font=\iuc@spinefont]
        at (0.5\spinewidth,237mm) {\def\\{ }\MakeUppercase{\iuc@author}};
      % degree abbreviation and year end at the lower printable boundary
      \node[rotate=-90,anchor=east,inner sep=0pt,font=\iuc@spinefont]
        at (0.5\spinewidth,60mm) {\iuc@degreeabbr\hspace{15mm}\iuc@submissionyear};
    \end{tikzpicture}%
  }
  \expandafter\endinput
\fi

% ---------------------------------------------------------------------------
% Page layout (Manual 8.1, 9)
%   top 30, bottom 25, left 38, right 25 mm.
%   Page number centred; footer baseline 12.5 mm above the bottom edge.
% ---------------------------------------------------------------------------
\RequirePackage[a4paper,top=30mm,bottom=25mm,left=38mm,right=25mm,
  headheight=0pt,headsep=0pt,footskip=12.5mm]{geometry}
\ifiuc@showframe
  \RequirePackage{showframe}
\fi
% extra space above chapter, appendix, and References headings (40 mm top)
\newlength\iuc@openingskip
\setlength\iuc@openingskip{10mm}
% \vspace* at the top of a page leaves an empty zero-height line, so the
% heading that follows drops by one single-spaced baselineskip (14.5 pt at
% 12 pt). Subtract it so the heading sits exactly 10 mm below the 30 mm top.
\newlength\iuc@openingvskip
\setlength\iuc@openingvskip{\dimexpr\iuc@openingskip-14.5pt\relax}

\pagestyle{plain}% centred page number, no header, no rules

% ---------------------------------------------------------------------------
% Spacing and paragraphs (Manual 8.2, 8.3)
% ---------------------------------------------------------------------------
\newcommand\iuc@bodyspacing{%
  \doublespacing
  \setlength\parindent{2em}%
  \setlength\parskip{6pt}%
}
\newcommand\iuc@frontspacing{%
  \setstretch{1}%
  \setlength\parindent{0pt}%
  \setlength\parskip{12pt}%
}
\setlist{itemsep=0pt,parsep=0pt,topsep=3pt,partopsep=0pt}
\raggedbottom
% Justified text: allow a little extra stretch rather than overfull lines
% (helps the Malay abstract, which uses English hyphenation patterns).
\setlength\emergencystretch{1.5em}

% Block quotations of 40+ words: 1.27 cm left indent, double-spaced,
% no extra space before or after (Manual 15.1 "Quotations")
\renewenvironment{quote}
  {\list{}{\setlength\leftmargin{1.27cm}\setlength\rightmargin{0pt}%
           \setlength\topsep{0pt}\setlength\partopsep{0pt}%
           \setlength\parsep{0pt}\setlength\listparindent{0pt}}%
   \item\relax}
  {\endlist}
\let\quotation\quote
\let\endquotation\endquote

% ---------------------------------------------------------------------------
% Headings (Manual 10.2, 10.3)
% ---------------------------------------------------------------------------
\setcounter{secnumdepth}{2}% chapter, section, subsection
\setcounter{tocdepth}{1}%   contents lists chapters and sections only

\newif\ifiuc@inappendix
\newcommand\iuc@chaptertitle[1]{%
  \MakeUppercase{#1}%
  \ifiuc@inappendix
    \addcontentsline{loa}{iucappendix}{\protect\numberline{\thechapter}#1}%
  \fi}

% Numbered chapter: CHAPTER 1 / 12 pt / INTRODUCTION / 24 pt; 40 mm top
\titleformat{\chapter}[display]
  {\normalfont\normalsize\bfseries\centering\setstretch{1}}
  {\MakeUppercase{\chaptertitlename}\ \thechapter}
  {12pt}
  {\iuc@chaptertitle}
% (the display shape also picks up the 6 pt body \parskip; remove it too)
\newlength\iuc@chaptervskip
\setlength\iuc@chaptervskip{\dimexpr\iuc@openingvskip-6pt\relax}
\titlespacing*{\chapter}{0pt}{\iuc@chaptervskip}{24pt}

% Unnumbered \chapter* (if used directly): same look as front-matter headings
\titleformat{name=\chapter,numberless}[block]
  {\normalfont\normalsize\bfseries\centering\setstretch{1}}
  {}{0pt}{\MakeUppercase}
\titlespacing*{name=\chapter,numberless}{0pt}{-14.5pt}{24pt}

% Section / subsection: bold, left aligned, 24 pt before, 12 pt after.
% The 6 pt paragraph skip is subtracted so the visible gaps match.
\titleformat{\section}
  {\normalfont\normalsize\bfseries\setstretch{1}}{\thesection}{1.5em}{}
\titlespacing*{\section}{0pt}{18pt}{6pt}
\titleformat{\subsection}
  {\normalfont\normalsize\bfseries\setstretch{1}}{\thesubsection}{1.5em}{}
\titlespacing*{\subsection}{0pt}{18pt}{6pt}

% Lower levels are not permitted by the manual
\renewcommand\subsubsection{%
  \ClassError{iucthesis}{\protect\subsubsection\space is not permitted}%
    {The IUC manual allows chapters, sections, and subsections only.}}
\renewcommand\paragraph{%
  \ClassError{iucthesis}{\protect\paragraph\space is not permitted}%
    {The IUC manual allows chapters, sections, and subsections only.}}

% Heading with 40 mm top margin that is not a numbered chapter (REFERENCES)
\newcommand\iuc@openingheading[1]{%
  \clearpage
  \vspace*{\iuc@openingvskip}%
  \phantomsection
  \addtocontents{toc}{\protect\addvspace{12pt}}%
  \addcontentsline{toc}{chapter}{#1}%
  {\normalfont\normalsize\bfseries\centering\setstretch{1}
   \MakeUppercase{#1}\par}%
  \vspace{24pt}%
  \@afterheading}

% ---------------------------------------------------------------------------
% Captions, tables, figures (Manual 12, 13)
%   Numbered by chapter. Table caption above; figure caption below.
%   Captions, tables, and notes single-spaced.
% ---------------------------------------------------------------------------
\captionsetup{labelsep=colon,justification=centering,font=singlespacing,
  labelfont=up,textfont=up,skip=6pt}
\captionsetup[table]{position=top}
\captionsetup[figure]{position=bottom}
% applied inside every float box (table, figure)
\g@addto@macro\@floatboxreset{\setstretch{1}\setlength\parskip{0pt}\centering}
\AtBeginEnvironment{longtable}{\setstretch{1}}
\setlength\abovetopsep{0pt}

% \tablenote{...}  -> "Note. ..." below the table
\newcommand\tablenote[1]{%
  \par\vspace{3pt}%
  {\raggedright\noindent\textit{Note.}\ #1\par}}
% \figuresource{...} -> "Source: ..." below the figure caption
\newcommand\figuresource[1]{%
  \par\vspace{2pt}%
  {\centering\textit{Source:}\ #1\par}}

% ---------------------------------------------------------------------------
% Equations (Manual 14)
%   Numbered by chapter at the right margin: (3.1)
%   \eqtitle{Short title} inside the equation adds it to the List of Equations
% ---------------------------------------------------------------------------
\numberwithin{equation}{chapter}
\newcommand\eqtitle[1]{%
  \addcontentsline{loe}{iucequation}{\protect\numberline{\theequation}#1}}

% ---------------------------------------------------------------------------
% Contents and lists (Manual 6.5, 6.6)
% ---------------------------------------------------------------------------
\newif\ifiuc@tocappendix
\newcommand\iuc@tocappendix{\global\iuc@tocappendixtrue}
\newif\ifiuc@tocnopage
% Write to the .toc immediately so the marker precedes entries that come
% from \include'd files (their .aux link is written immediately).
\newcommand\iuc@immediatetoc[1]{%
  \immediate\write\@auxout{\string\@writefile{toc}{#1}}}

% Chapter-level entries:
%   numbered chapter  -> CHAPTER 1: INTRODUCTION   (no page number)
%   appendix          -> APPENDIX A: TITLE         (page number)
%   unnumbered        -> AUTHOR DECLARATION ...    (page number)
\titlecontents{chapter}[0pt]{}
  {\ifiuc@tocappendix
     \global\iuc@tocnopagefalse APPENDIX\ \thecontentslabel:\ %
   \else
     \global\iuc@tocnopagetrue CHAPTER\ \thecontentslabel:\ %
   \fi\MakeUppercase}
  {\global\iuc@tocnopagefalse\MakeUppercase}
  {\ifiuc@tocnopage\hfill\else\hfill\contentspage\fi}
\titlecontents{section}[4em]{}
  {\contentslabel{2.5em}}{\hspace*{-2.5em}}
  {\hfill\contentspage}

\newcommand\iuc@dotfill{\titlerule*[0.6em]{.}}
\titlecontents{figure}[3em]{\addvspace{6pt}}
  {\contentslabel{3em}}{\hspace*{-3em}}{\iuc@dotfill\contentspage}
\titlecontents{table}[3em]{\addvspace{6pt}}
  {\contentslabel{3em}}{\hspace*{-3em}}{\iuc@dotfill\contentspage}
\contentsuse{iucequation}{loe}
\contentsuse{iucappendix}{loa}
\titlecontents{iucequation}[3em]{\addvspace{6pt}}
  {\contentslabel{3em}}{\hspace*{-3em}}{\hfill\contentspage}
\titlecontents{iucappendix}[3em]{\addvspace{6pt}}
  {\contentslabel{3em}}{\hspace*{-3em}}{\hfill\contentspage}

% Omit a list when its file from the previous run has no entries.
% On the first run (no file yet) the list is printed; latexmk reruns.
\newif\ifiuc@listnonempty
\def\iuc@flagentry#1#2#3#4{\global\iuc@listnonemptytrue}
\newcommand\iuc@checklist[1]{%
  \global\iuc@listnonemptyfalse
  \IfFileExists{\jobname.#1}{%
    \setbox\z@\vbox{%
      \makeatletter
      \let\contentsline\iuc@flagentry
      \let\addvspace\@gobble
      \@input{\jobname.#1}}}%
    {\global\iuc@listnonemptytrue}}
% #1 ext, #2 heading
\newcommand\iuc@makelist[2]{%
  \iuc@checklist{#1}%
  \ifiuc@listnonempty\iuc@typesetlist{#1}{#2}\else\iuc@openlist{#1}\fi}
% When a list is omitted, still open its output file (as \@starttoc would)
% so that entries added later are recorded and the list reappears.
\newcommand\iuc@openlist[1]{%
  \if@filesw
    \expandafter\newwrite\csname tf@#1\endcsname
    \immediate\openout\csname tf@#1\endcsname\jobname.#1\relax
  \fi}
\newcommand\iuc@typesetlist[2]{%
  \iucfrontchapter{#2}%
  {\setlength\parskip{0pt}\@starttoc{#1}}}

\renewcommand\tableofcontents{%
  \iucfrontchapter{Table of Contents}%
  {\setlength\parskip{0pt}%
   \noindent\textbf{CONTENT}\hfill\textbf{PAGE}\par
   \vspace{12pt}%
   \@starttoc{toc}}}
\renewcommand\listoftables{\iuc@makelist{lot}{List of Tables}}
\renewcommand\listoffigures{\iuc@makelist{lof}{List of Figures}}
\newcommand\listofequations{\iuc@makelist{loe}{List of Equations}}
\newcommand\listofappendices{\iuc@makelist{loa}{List of Appendices}}

% ---------------------------------------------------------------------------
% Document divisions
% ---------------------------------------------------------------------------
% Front-matter heading: new page, 30 mm top, centred bold uppercase,
% 24 pt after, listed in the contents (Manual 6)
\newcommand\iucfrontchapter[1]{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{\MakeUppercase{#1}}%
  {\normalfont\normalsize\bfseries\centering\setstretch{1}%
   \MakeUppercase{#1}\par}%
  \vspace{24pt}%
  \@afterheading}

\newif\ifiuc@inmain
\newcommand\frontmatter{%
  \clearpage
  \iuc@frontspacing}
\newcommand\mainmatter{%
  \clearpage
  \pagenumbering{arabic}%
  \iuc@inmaintrue
  \iuc@bodyspacing
  \iuc@immediatetoc{\string\addvspace{12pt}}}

\renewcommand\appendix{%
  \clearpage
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand\chaptername{Appendix}%
  \renewcommand\thechapter{\Alph{chapter}}%
  \global\iuc@inappendixtrue
  \iuc@bodyspacing
  \iuc@immediatetoc{\string\iuc@tocappendix\string\addvspace{12pt}}}

% ---------------------------------------------------------------------------
% Outer cover (Manual 5.1): white page in the PDF; Arial Narrow 18 pt,
% bold uppercase, single-spaced. Margins 60/40/40/25 mm. No page number.
% ---------------------------------------------------------------------------
\newcommand\makecover{%
  \newgeometry{top=60mm,bottom=40mm,left=40mm,right=25mm,
    headheight=0pt,headsep=0pt,footskip=12.5mm}%
  \pagenumbering{Alph}%
  \thispagestyle{empty}%
  {\centering\setstretch{1}%
    \iuc@coverfont\bfseries\fontsize{18}{21.6}\selectfont
    \MakeUppercase{\iuc@title}\par
    \vfill
    \MakeUppercase{\iuc@author}\par
    \vfill
    \MakeUppercase{\iuc@institution}\par}
  \restoregeometry
  \clearpage}

% ---------------------------------------------------------------------------
% Internal title page (Manual 5.2): Roman page i, number hidden.
% ---------------------------------------------------------------------------
\newcommand\maketitlepage{%
  \newgeometry{top=60mm,bottom=40mm,left=40mm,right=25mm,
    headheight=0pt,headsep=0pt,footskip=12.5mm}%
  \pagenumbering{roman}%
  \thispagestyle{empty}%
  {\centering\setstretch{1}\setlength\parskip{0pt}%
    {\fontsize{14}{16.8}\selectfont\bfseries\MakeUppercase{\iuc@title}\par}
    \vfill
    \iuc@author\par
    \vfill
    \iuc@Doctype\ submitted in partial fulfilment for the degree of\par
    {\bfseries\MakeUppercase{\iuc@degree}\par}
    \vfill
    \MakeUppercase{\iuc@institution}\par
    \vfill
    \iuc@submissiondate\par}
  \restoregeometry
  \clearpage
  \iuc@frontspacing}

% ---------------------------------------------------------------------------
% Author declaration (Manual 6.1): Roman page ii. Exact wording required.
% ---------------------------------------------------------------------------
\newcommand\makedeclaration{%
  \iucfrontchapter{Author Declaration}%
  {\setlength\parskip{0pt}%
   \noindent I hereby declare that the work in this \iuc@doctype\ is my own
   except for quotations and summaries which have been duly acknowledged.\par
   \vspace{36pt}%
   \noindent
   \begin{minipage}[b]{0.42\textwidth}
     Date: \iuc@declarationdate
   \end{minipage}\hfill
   \begin{minipage}[b]{0.52\textwidth}
     \begin{tabular}{@{}l@{\hspace{1em}}p{\linewidth-6.5em}@{}}
       Signature: & \rule{\linewidth}{0.4pt}\\[2pt]
       Name:      & \iuc@author\\
       Matric No: & \iuc@matricno\\
       Address:   & \raggedright\iuc@address
     \end{tabular}
   \end{minipage}\par}}

% ---------------------------------------------------------------------------
% Front-matter environments (Manual 6.2 - 6.4)
% ---------------------------------------------------------------------------
\newcommand\iuc@kwlabel{Keywords}
\newcommand\keywords[1]{\par\vspace{6pt}\noindent\textbf{\iuc@kwlabel:}\ #1\par}

\newenvironment{acknowledgement}
  {\iucfrontchapter{Acknowledgement}}{\par}
\newenvironment{dedication}
  {\iucfrontchapter{Dedication}}{\par}
\newenvironment{abstrak}
  {\iucfrontchapter{Abstrak}\renewcommand\iuc@kwlabel{Kata kunci}}{\par}
\renewenvironment{abstract}
  {\iucfrontchapter{Abstract}\renewcommand\iuc@kwlabel{Keywords}}{\par}
% Generic front-matter page, e.g. List of Abbreviations, Glossary
\newenvironment{frontpage}[1]
  {\iucfrontchapter{#1}}{\par}

% ---------------------------------------------------------------------------
% References (Manual 15): APA 7, double-spaced, 1.27 cm hanging indent,
% no extra space between entries, heading uses chapter-opening margins.
% ---------------------------------------------------------------------------
\RequirePackage[style=apa,backend=biber]{biblatex}
% APA 7 follows US punctuation: commas and full stops go inside quotation marks
\DefineBibliographyExtras{british}{\uspunctuation}
\setlength\bibhang{1.27cm}
\setlength\bibitemsep{0pt}
\setlength\bibparsep{0pt}
\defbibheading{iuc}[References]{\iuc@openingheading{#1}}
\newcommand\printreferences{%
  \begingroup
  \doublespacing
  \setlength\parskip{0pt}%
  \printbibliography[heading=iuc]%
  \endgroup}

% ---------------------------------------------------------------------------
% PDF: hyperlinks without coloured boxes (prints cleanly)
% ---------------------------------------------------------------------------
\RequirePackage[hidelinks,bookmarksnumbered]{hyperref}
\pdfstringdefDisableCommands{\def\\{ }}
\AtBeginDocument{%
  \hypersetup{pdftitle={\iuc@title},pdfauthor={\iuc@author}}}

\endinput
