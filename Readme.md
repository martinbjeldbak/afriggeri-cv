# Martin's fork of the [afriggeri/cv](https://github.com/afriggeri/cv) LaTeX document class

See usage of this document class in my CV repository at [martinbjeldbak/cv](https://github.com/martinbjeldbak/cv).

## What this fork adds

- [Font Awesome 5](https://www.ctan.org/pkg/fontawesome5) icons, plus social macros
  that typeset an icon, a slash and the handle as one clickable link:
  `\phone{}`, `\website{}`, `\email{}`, `\instagram{}`, `\facebook{}`,
  `\twitter{}`, `\github{}`, `\linkedin{}` (and `\social{url}{icon}{handle}`)
- [`microtype`](https://www.ctan.org/pkg/microtype) with options suited to XeTeX/LuaLaTeX
- [`polyglossia`](https://www.ctan.org/pkg/polyglossia)
- No bibliography machinery

The document is responsible for the actual fonts (see [Usage](#usage)).

## Modernisation (2026)

The typesetting internals have been brought up to date with a current LaTeX kernel:

- `\NeedsTeXFormat{LaTeX2e}[2020-10-01]` and a versioned `\ProvidesClass`
- dropped `xltxtra` (superseded by `fontspec` + `realscripts`)
- dropped `fontawesome` v4 (last released 2016) in favour of `fontawesome5`; the
  hand-rolled Instagram glyph patch is gone
- `\section` keeps its `*` and `[short]` forms and now produces PDF bookmarks; the
  "three coloured characters" title effect uses l3's `\tl_range`, so titles shorter
  than three characters no longer break it. The aside headings get their own command
  instead of shadowing `\section`
- no longer redefines `\bfseries`, and no longer redefines the kernel's
  `\subsection` with a non-standard signature
- custom colours are prefixed (`cvgray`, `cvblue`, …) instead of overwriting
  xcolor's own `red`, `blue`, `green`, `orange` and `purple`; `fillheader`,
  `header`, `textcolor` and `headercolor` are kept as the public names
- `\if@cv@print` instead of `\def\@cv@print`
- `Ligatures=TeX` instead of the legacy `Mapping=tex-text`
- the body column width of `\entry` is a length (`\cv@entrywidth`) rather than
  `11.8cm` hardcoded in the definition
- `tel:` URIs are stripped of spaces while the displayed number keeps them
- hyperref is loaded with `pdfusetitle`, so `\title`/`\author` end up as PDF metadata

The class works with both XeLaTeX and LuaLaTeX. When fonts are loaded from a
directory rather than from the system font database, pass an explicit `Extension`
so that luaotfload can find the files.

## Usage

The class does not choose fonts; the document defines `\bodyfont`, `\thinfont` and
`\headingfont` (and may set the main font and the maths font):

```latex
\documentclass{friggeri-cv}

\setmainfont{LiberationSans-Regular}[
  Path = fonts/, Extension = .ttf,
  BoldFont = LiberationSans-Bold, Color = textcolor,
]
\newfontfamily\bodyfont{LiberationSans-Regular}[Path = fonts/, Extension = .ttf]
\newfontfamily\thinfont{LiberationSans-Regular}[Path = fonts/, Extension = .ttf]
\newfontfamily\headingfont{LiberationSans-Bold}[Path = fonts/, Extension = .ttf]
\setmathfont{XITS Math}[Path = fonts/, Extension = .otf]

\begin{document}
\header{first}{last}{software developer, \email{me@example.com}}

\begin{aside}
  \section{about}
  some place
  \phone{+45 12 34 56 78}
\end{aside}

\section{experience}
\begin{entrylist}
  \entry{since 2024}{Job Title}{Employer}{What I did}
\end{entrylist}
\end{document}
```

Pass the `print` class option for the greyscale variant.

## Sample

![Sample image of generated PDF file](sample.png)

---

Original README:

## About

Latest version of my CV, typesetted in Helvetica and using colors inspired by Monokai (there is an `print` option which renders in black and white, and reverts the header to dark on light, if printing on paper is needed).

Uses TikZ for the header, XeTeX and fontspec to use Helvetica Neue, biblatex to print my publications and textpos for the aside.

## License

Copyright (C) 2012, Adrien Friggeri

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
