#!/bin/sh

mkdir -p html 

pandoc  --mathjax=https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML  --filter pandoc-crossref -s --toc --chapters -c github-pandoc.css  --default-image-extension=png -f latex -t html opencal-userguide.tex -o opencal-userguide_FULL.html


htmldoc -t htmlsep -v -d html opencal-userguide_FULL.html 

mkdir -p html_sanitized
#fix utf8
HEADER=`cat header.html`
echo "HEADER $HEADER"
export HEAD=$HEADER
cd html/
for f in ./*.html;
do 
	echo "Processing $f file..";
	python ../fix-htmldoc-utf8.py $f > ../html_sanitized/$f
	
	#add custom header: style and math javascriptv
	perl -0777 -i.original -pe 's/<STYLE.*<\/STYLE>/$ENV{HEAD}/migs' ../html_sanitized/$f

done

cd ../html_sanitized
#mv all images
IMGS=`find ../images/ -name "*.png"`
for i in $IMGS
do
	cp $i .
done
cp ../github-pandoc.css .
