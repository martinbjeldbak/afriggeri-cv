# Martin's fork of the [afriggeri/cv](https://github.com/afriggeri/cv) LaTeX document class.

See usage of this document class in my CV repository at [martinbjeldbak/cv](https://github.com/martinbjeldbak/cv).

This fork makes the following changes to afriggeri's document class:
- Loads the [`fontawesome`](https://www.ctan.org/tex-archive/fonts/fontawesome) LaTeX package to support social icons
- Loads the [`microtype`](https://www.ctan.org/pkg/microtype) package with options for XeTeX
- Loads the [`polyglossia`](https://www.ctan.org/pkg/polyglossia) package
- Adds macroes to make printing of social sites easy, such as `\github{martinbjeldbak}`, which will typeset the GitHub logo from [font-awesome](http://fortawesome.github.io/Font-Awesome/), followed by a vertially centered slash, followed by my GitHub username, all as a clickable entity
-- So far there are the following social macroes: `\telephone{}`, `\website{}`, `\email{}`, `\instagram{}`, `\facebook{}`, `\twitter{}`, `\github{}`, `\linkedin{}`
- Removes bibliography stuff

## Sample
![Sample image of generated PDF file](sample.png)

Original README:

## About
Latest version of my CV, typesetted in Helvetica and using colors inspired by Monokai (there is an `print` option which renders in black and white, and reverts the header to dark on light, if printing on paper is needed).

Uses TikZ for the header, XeTeX and fontspec to use Helvetica Neue, biblatex to print my publications and textpos for the aside.


## License

Copyright (C) 2012, Adrien Friggeri

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
