all: makepdf

makepdf: opencal-userguide.tex
	pdflatex opencal-userguide.tex

clean:
	@$(RM) *.aux *.dvi *.log *.nav *.out *.pdf *.snm *.toc *.vrb *~
