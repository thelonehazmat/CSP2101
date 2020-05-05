#!/bin/bash

#Brandon Royce
#Student Number: 10471905

#rm rectangle_F.txt
initialFile=rectangle.txt
#read -p "What file would you like to format?" initialFile

sed -e '1d' \
-e 's/Rec[0-9]/Name: &/' \
-e 's/,[0-9]/   Height: &/1' \
-e 's/,[0-9]/   Width: &/2' \
-e 's/,[0-9]/   Area: &/3' \
-e 's/,[A-Z][a-z]*\+/   Colour: &/' \
-e 's/,//g' $initialFile > rectangle_F.txt

exit 0