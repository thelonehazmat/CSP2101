#!/bin/bash

#Brandon Royce
#10471905

site=https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152 #Stores image gallery address in a variable

rm results.txt &> /dev/null #Removes old file and pipes error into null if it didn't exist
curl -s $site > results.txt #Downloads Image gallery html page
grep -Eo '(http|https)://[^"]+' results.txt | grep "DSC0" | sed -n 's/.*\///w results.txt' #Strips all text except for file names

#Functions

inputCheck() { #Function for checking complicated input
    local exitStatus
    exitStatus=1
    userInput=$1
    until (( exitStatus == 0 )) #Ends loop once grep finds the file
    do
        
        if grep -q -Fx "DSC0$userInput.jpg" results.txt #Checks if user input is a valid file name
        then
            exitStatus=0     #If input is correct ends the loop      
        else
            exitStatus=1
            echo "Invalid input"
            read -p "Try another entry: " userInput
        fi
    done
    correctInput=$userInput #Returns correct input
}

downloadOutput() { #Outputs a message of file size etc.
    local size
    local file
    file=$(echo $1 | grep -Eo "(1|2)[0-9]+") #Sanitises input
    size=$(curl -sI https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$file.jpg | grep -i Content-Length | tr -d '\r' | awk '{print $2/1000}') #Gets file size
    echo -e "\nDownloading DSC0$file, with the file name DSC0$file.jpg, with a file size of $size KB...File Download Complete\n" #Outputs result
    
    
}

specificFile() { #Uses wget to download a specific image
    local specifiedFile
    read -p "What are the last four digits of the file's name? " specifiedFile
    inputCheck $specifiedFile
    wget -q -P $storage "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$correctInput.jpg"
    downloadOutput $correctInput
}

allFiles() { #Uses a loop to download all the images
    while IFS='\n' read -r line #Loops through all the file names
    do
    wget -q -P $storage "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/$line"
    downloadOutput $line
    done < results.txt
}


rangeFiles(){ #Downloads a range of files
    local lower
    local upper

    read -p "What is the start of the range you wish to download (Last four digits of file)? " lower
    inputCheck $lower
    lower=$correctInput #Assigns lower file name

    read -p "What is the end of the range you wish to download (Last four digits of file)? " upper
    inputCheck $upper
    upper=$correctInput

    files=$(sed -n "/DSC0$lower.jpg/,/DSC0$upper.jpg/p" results.txt) #Grabs all the lines between two file names
    for fileName in $files  #Loops through the files stored in files
    do
    wget -q -P $storage "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/$fileName"
    downloadOutput $fileName
    done
}

randomFiles() { #Downloads a random number of files the user specifies
    local randomRange
    until [[ "$randomRange" =~ ^[0-9]+$ ]] #Checks input is a number and isn't null
    do
        read -p "How many random images do you wish to download (Enter digits only)? " randomRange
    done

    for ((i=0; i<$randomRange; i++)) do #Loop through desired amount of images
    randomFile=$(shuf -n 1 results.txt) #Chooses a random file
        wget -q -P $storage "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/$randomFile"
        downloadOutput $randomFile
        done
}

#Main body

until [[ -n $storage ]] #Checks user input isn't null
do
    read -p "What directory would you like to save the files to? " storage #Saves where to save the files
done

until [[ $option = "x" ]]; do #Loops until user chooses to exit program
    echo -e "\nPress 1 to download a specified file \nPress 2 to download all files \nPress 3 to download a range of files \nPress 4 to download random files\nPress x to exit\n"
    read -p "What would you like to do? " option

    if [ $option = "1" ]; then
        specificFile #Calls specific file function
        echo -e "\nPROGRAM FINISHED"

    elif [ $option = "2" ]; then
        allFiles #Calls all files function
        echo -e "\nPROGRAM FINISHED"

    elif [ $option = "3" ]; then
        rangeFiles #Calls range files function
        echo -e "\nPROGRAM FINISHED"

    elif [ $option = "4" ]; then
        randomFiles #Calls random files option
        echo -e "\nPROGRAM FINISHED"

    elif [ $option = "x" ]; then
        echo -e "\nPROGRAM FINISHED"

    else
        echo "Please enter either 1, 2, 3, 4 or x only." #Called if user input is invalid

    fi

done
exit 0