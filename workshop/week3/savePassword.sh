#!/bin/bash

read -p "Type a folder name:" folderName #Asks for directory to save file
read -p "Type a secret password:" passwordOutput #Asks user for file contents

mkdir "$folderName" #Makes new folder

echo "$passwordOutput" > "./$folderName/secrets.txt" #Outputs password to specified folder

exit 0