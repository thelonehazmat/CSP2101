#!/bin/bash

read -p "Enter directory to list:" directoryName #Asks the user what direcory to list
ls "$directoryName" #lists direcory

exit 0