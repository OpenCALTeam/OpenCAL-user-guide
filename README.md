# OpenCAL-user-guide
User guide of the OpenCAL library


#Generate HTML docs
- Pandoc is required (http://pandoc.org/)
` pandoc --mathjax=https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML  --filter pandoc-crossref -s --toc --chapters -f latex -t html opencal-userguide.tex -o opencal-userguide.html `
which uses mathjax to render latex equations in the final html doc. 

`-s` mean standalone document

`--toc --chapters` is used to output the table of content

`-f` and `-t` controls inputand output formats

