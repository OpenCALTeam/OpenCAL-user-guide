cmake_minimum_required(VERSION 3.0)

project(OpencalUserGuide NONE)
#SET(LATEX_OUTPUT_PATH build)

include(UseLATEX.cmake)


# Note that normally CMakeLists.txt would not be considered an
# input to the document, but in this special case of documenting
# UseLATEX.cmake the contents of this file is actually included
# in the document.
file(GLOB_RECURSE contents_files RELATIVE ${CMAKE_SOURCE_DIR} *.tex )

add_latex_document(opencal-userguide.tex
	#INPUTS CMakeLists.txt
	INPUTS ${contents_files}
    IMAGE_DIRS images
    #BIBFILES bibliography.bib
    #USE_INDEX
    #USE_GLOSSARY
    )


#add_latex_document(DefaultDvi.tex FORCE_DVI)
#add_latex_document(DefaultPdf.tex FORCE_PDF)#

