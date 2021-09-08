#!/bin/bash
aw=4 #desired aspect ratio width...
ah=3 #and height
in=$1
out=$2

wid=`convert "$in" -format "%[w]" info:`
hei=`convert "$in" -format "%[h]" info:`

tarar=`echo $aw/$ah | bc -l`
imgar=`convert "$in" -format "%[fx:w/h]" info:`

if (( $(bc <<< "$tarar > $imgar") ))
then
  nhei=`echo $wid/$tarar | bc`
  convert "$in" -gravity center -crop ${wid}x${nhei}+0+0 "$out"
elif (( $(bc <<< "$tarar < $imgar") ))
then
  nwid=`echo $hei*$tarar | bc`
  convert "$in" -gravity center -crop ${nwid}x${hei}+0+0 "$out"
else
  cp "$in" "$out"
fi
