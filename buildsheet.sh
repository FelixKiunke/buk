#!/bin/bash

sheet=$1
sheetnum=$(echo "$sheet" | sed 's/^u0//' | sed 's/^u//')

exs=$(ls "$sheet" | grep 'u[0-9][0-9]a[0-9]' | sed 's/^.*a//' | sed 's/\.tex$//')

cp template.tex $sheet/$sheet.tex

sed -i "s/SHEETNUM/$sheetnum/" $sheet/$sheet.tex

echo -n "" > $sheet/tmp.tex
for n in $exs; do
	echo '\aufgabe{'"$sheetnum.$n"'}' >> $sheet/tmp.tex
	echo '\input{'"${sheet}a$n.tex"'}' >> $sheet/tmp.tex
done

sed -i "/% EXERCISES/r $sheet/tmp.tex" $sheet/$sheet.tex

rm "$sheet/tmp.tex"

cd $sheet
pdflatex "$sheet.tex"
