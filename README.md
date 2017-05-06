# OpenCAL-user-guide
User guide of the OpenCAL library

To build the user guide, please clone the repo in the same directory in which you cloned the OpenCAL-1.0 examples.

\
 - ...
 - opencal-examples-1.0
 - opencal-user-guide
 - ...
 - ...

#Generate HTML docs
- Pandoc is required (http://pandoc.org/)
` pandoc --mathjax=https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML  --filter pandoc-crossref -s --toc --chapters -f latex -t html opencal-userguide.tex -o opencal-userguide.html `
which uses mathjax to render latex equations in the final html doc. 

`-s` mean standalone document

`--toc --chapters` is used to output the table of content

`-f` and `-t` controls inputand output formats


API format is not limited to HTML, a docx doc can be obtained for example using the following:
`
pandoc -s --toc --chapters -c style.css --default-image-extension=png -f latex -t docx opencal-userguide.tex -o opencal-userguide.docx
`
