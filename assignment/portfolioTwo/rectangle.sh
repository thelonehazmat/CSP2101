#!/bin/bash

#Brandon Royce
#Student Number: 10471905


read -p "What file would you like to format? " initialFile #Asks what file will be processed
read -p "What file would you like to output to? " outputFile #Asks where the results will be stored

sed -e '1d' \
-e 's/Rec[0-9]/Name: &/' \
-e 's/,[0-9]/\tHeight: &/1' \
-e 's/,[0-9]/\tWidth: &/2' \
-e 's/,[0-9]/\tArea: &/3' \
-e 's/,[A-Z][a-z]*\+/\tColour: &/' \
-e 's/,//g' $initialFile > $outputFile #Saves results

echo -e "Results succesfully stored in $outputFile\n"

exit 0