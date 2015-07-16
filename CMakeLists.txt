cmake_minimum_required(VERSION 3.0)

project(UseLATEX_DOC NONE)

include(UseLATEX.cmake)

# Note that normally CMakeLists.txt would not be considered an
# input to the document, but in this special case of documenting
# UseLATEX.cmake the contents of this file is actually included
# in the document.

add_latex_document(opencal-userguide.tex
	INPUTS CMakeLists.txt
	#INPUTS sources/IncludedFile.tex #other files in other subdirs
	#BIBFILES MyDoc.bib
	IMAGE_DIRS images
  )


#add_latex_document(DefaultDvi.tex FORCE_DVI)
#add_latex_document(DefaultPdf.tex FORCE_PDF)
