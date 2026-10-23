%% friggeri-cv.cls -- a CV class in the style of Adrien Friggeri's
%% "friggeri-cv" (https://github.com/afriggeri/cv, MIT licence).
%%
%% This fork adds Font Awesome social icons, microtype/polyglossia setup and
%% drops the bibliography; the typesetting internals were modernised for a
%% current LaTeX kernel (see the Readme for the full list):
%%   * explicit \NeedsTeXFormat date and a maintained version string
%%   * no xltxtra (superseded by fontspec/realscripts)
%%   * fontawesome5 instead of the unmaintained fontawesome v4 (2016)
%%   * \section keeps its star/optional forms and produces PDF bookmarks
%%   * no redefinition of \bfseries or of xcolor's base colour names
%%   * a proper \if@cv@print switch instead of \def\@cv@print
%%   * l3 helpers where they make the code simpler (\tl_range, tel: URIs)
%%
%% Class options:
%%   print   greyscale variant for printing (colours collapse to grey)
%%
\NeedsTeXFormat{LaTeX2e}[2020-10-01]
\ProvidesClass{friggeri-cv}[2026/10/23 v2.0.0 CV class]

\newif\if@cv@print
\DeclareOption{print}{\@cv@printtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

%%%%%%%%%%%%
% Colours  %
%%%%%%%%%%%%
\RequirePackage{xcolor}

% Prefixed names: redefining xcolor's own `red', `blue', `green', ... would
% silently change the meaning of those colours everywhere else.
\definecolor{cvdarkgray}{HTML}{333333}
\definecolor{cvgray}{HTML}{4D4D4D}
\definecolor{cvlightgray}{HTML}{999999}
\definecolor{cvgreen}{HTML}{C2E15F}
\definecolor{cvorange}{HTML}{FDA333}
\definecolor{cvpurple}{HTML}{D3A4F9}
\definecolor{cvred}{HTML}{FB4485}
\definecolor{cvblue}{HTML}{6CE0F1}

\if@cv@print
  \colorlet{cvgreen}{cvgray}
  \colorlet{cvorange}{cvgray}
  \colorlet{cvpurple}{cvgray}
  \colorlet{cvred}{cvgray}
  \colorlet{cvblue}{cvgray}
  \colorlet{fillheader}{white}
  \colorlet{header}{cvgray}
\else
  \colorlet{fillheader}{cvgray}
  \colorlet{header}{white}
\fi

% Public colour roles used by the document.
\colorlet{textcolor}{cvgray}
\colorlet{headercolor}{cvgray}

%%%%%%%%%
% Fonts %
%%%%%%%%%

\RequirePackage{fontspec}
\RequirePackage[math-style=TeX]{unicode-math}

% `Ligatures=TeX' is the modern spelling of the old `Mapping=tex-text'.
\defaultfontfeatures{Ligatures=TeX}

\RequirePackage[activate={true,nocompatibility},factor=1100,stretch=10,shrink=10,expansion=false,verbose=silent]{microtype}

%%%%%%%%%%%%
% Language %
%%%%%%%%%%%%
\RequirePackage{polyglossia}
\setdefaultlanguage[variant=us]{english}

%%%%%%%%%%
% Header %
%%%%%%%%%%
\RequirePackage{tikz}

\newcommand{\rolefont}{%
  \fontsize{14pt}{24pt}\selectfont%
  \thinfont%
  \color{white}%
}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=4cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {%
      \fontsize{40pt}{72pt}\color{header}%
      {\thinfont #1}{\bodyfont  #2}
    };
    \node [anchor=north] at (name.south) {%
      \fontsize{14pt}{24pt}\color{header}%
      \thinfont #3%
    };
  \end{tikzpicture}
  \vspace{2.5cm}
  \vspace{-2\parskip}
}

%%%%%%%%%%%%%
% Structure %
%%%%%%%%%%%%%
\RequirePackage{parskip}

% Sections are not numbered on a CV; hyperref still creates bookmarks for them.
\setcounter{secnumdepth}{0}

\newcounter{colorCounter}

% Colour the first three characters of a section title, leaving the rest in
% headercolor. l3's \tl_range does the splitting, so titles shorter than three
% characters no longer break the way the old "grab three tokens" trick did.
\ExplSyntaxOn
\NewDocumentCommand \cv@sectioncolor { m }
  {
    \tl_set:Nn \l_tmpa_tl {#1}
    \group_begin:
      \color
        {
          \ifcase \value {colorCounter}
            cvblue \or cvred \or cvorange \or cvgreen \or cvpurple \else headercolor
          \fi
        }
      \tl_range:Nnn \l_tmpa_tl { 1 } { 3 }
    \group_end:
    \tl_range:Nnn \l_tmpa_tl { 4 } { -1 }
    \stepcounter { colorCounter }
  }
\ExplSyntaxOff

% Section title, through a wrapper so that \section*, \section[short]{long},
% PDF bookmarks and the (unused) table of contents all behave, while the layout
% stays exactly as designed for this CV.
\newcommand{\cv@section@title}[1]{%
  \texorpdfstring{\cv@sectioncolor{#1}}{#1}%
}

\newcommand{\cv@section@main}[2][]{%
  \par\vspace{\parskip}%
  {\LARGE\headingfont\color{headercolor}\cv@section@title{#2}}%
  \par\vspace{\parskip}%
  \phantomsection
  \addcontentsline{toc}{section}{#1}%
}

\newcommand{\cv@section@star}[1]{%
  \par\vspace{\parskip}%
  {\LARGE\headingfont\color{headercolor}\cv@section@title{#1}}%
  \par\vspace{\parskip}%
}

\renewcommand\section{\@ifstar{\cv@section@star}{\@dblarg\cv@section@main}}

\pagestyle{empty}

%%%%%%%%%%%%%%%%%%%%
% List environment %
%%%%%%%%%%%%%%%%%%%%

\setlength{\tabcolsep}{0pt}

% Width of the body column of an \entry; a single knob instead of a number
% buried in the definition below, should the page geometry change.
\newlength{\cv@entrywidth}
\setlength{\cv@entrywidth}{11.8cm}

\newenvironment{entrylist}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}

% #1 dates, #2 role/title, #3 place/link, #4 description
% The \leavevmode is essential: without it the colour whatsit lands in vertical
% mode inside the [t]-aligned \parbox, pushing the first line down by \parskip.
\newcommand{\entry}[4]{%
  #1&\parbox[t]{\cv@entrywidth}{%
    \leavevmode{\headingfont\color{headercolor}#2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=cvlightgray} #3}\\%
    #4\vspace{\parsep}%
  }\\}

%%%%%%%%%%%%%%
% Side block %
%%%%%%%%%%%%%%

\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}

% Aside headings are not document sections; they get their own command so that
% \section itself (and everything hyperref hooks into it) stays intact.
\newcommand{\cv@asidesection}[1]{%
  \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor}#1}%
}

\newenvironment{aside}{%
  \begingroup
  \let\section\cv@asidesection
  \begin{textblock}{3.6}(1.5, 4.33)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \endgroup
}

%%%%%%%%%%%%%%%%
% Social icons %
%%%%%%%%%%%%%%%%

% fontawesome5 is the maintained successor of fontawesome v4 (2016) and ships
% Instagram/Facebook/Twitter/LinkedIn/GitHub brand icons natively.
\RequirePackage{fontawesome5}

% `tel:' URIs must not contain spaces, so they are stripped for the link while
% the displayed number keeps its spacing. \href is deliberately called outside
% of the expl3 code: hyperref then gets a plain (already expanded) string and
% emits a proper /URI action; calling \href inside \ExplSyntaxOn makes it treat
% the target as a file and emit a /GoToR action instead.
\newcommand{\phone}[1]{%
  \def\cv@tel@uri{}%
  \@tfor\cv@tel@char:=#1\do{%
    \edef\cv@tel@uri{\cv@tel@uri\cv@tel@char}%
  }%
  \edef\cv@phone@link{\noexpand\href{tel:\cv@tel@uri}{#1}}%
  \cv@phone@link
}

\newcommand{\website}[1]{%
  \href{https://#1}{#1}%
}

\newcommand{\email}[1]{%
  \href{mailto:#1}{#1}%
}

\newcommand{\instagram}[1]{%
  \social{https://instagram.com}{\faInstagram}{#1}%
}

\newcommand{\facebook}[1]{%
  \social{https://facebook.com}{\faFacebookSquare}{#1}%
}

\newcommand{\twitter}[1]{%
  \social{https://twitter.com}{\faTwitterSquare}{#1}%
}

\newcommand{\github}[1]{%
  \social{https://github.com}{\faGithubSquare}{#1}%
}

\newcommand{\linkedin}[1]{%
  \social{https://linkedin.com/in}{\faLinkedin}{#1}%
}

\newcommand{\social}[3]{%
  \href{#1/#3}{#2 \raisebox{0.1ex}{\scriptsize/} #3}%
}

%%%%%%%%%%%%%%%%
% Other tweaks %
%%%%%%%%%%%%%%%%

\RequirePackage[left=6.1cm,top=2cm,right=1.5cm,bottom=2.5cm,nohead,nofoot]{geometry}

% hyperref goes last, as recommended. `pdfusetitle' has to be a package option
% (it patches \title and \author as hyperref is loaded), so the document's
% \title/\author end up as PDF metadata. No hidelinks/colorlinks here: the look
% of the document is defined by the CV itself, not by the class.
\RequirePackage[pdfusetitle]{hyperref}
\hypersetup{pdfdisplaydoctitle=true}

% Note: \XeTeXgenerateactualtext=1 would improve copy-paste and screen-reader
% output, but its whatsits make TeX insert \parskip inside every [t]-aligned
% \parbox and textblock, which shifts the layout. Left off deliberately.

