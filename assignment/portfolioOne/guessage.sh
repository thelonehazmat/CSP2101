#!/bin/bash

#Name: Brandon Royce
#Student Number: Brandon Royce

echo "Welcome to the guessing game. Guess the number or press q to quit"

generateNumber() #Function to generate random number when called
{
    local age=$(((RANDOM % 51)+20)) #Generates and stores number in local variable
    return $age #Returns local variable as in integer
}

#Function to test user answer
test()
{
    if  (($guess == $age)) ; then #If the guess is correct
        echo "Success, you guessed the age"
        exit
    
    elif [ $guess == "q" ]; then #If the escape character is used
        echo "Goodbye"
        exit

    elif (($guess > $age)); then #If the guess is too high
        echo "Too high"

    elif (($guess < $age)); then #If the guess is too low
        echo "Guess is too low"

    fi
}

generateNumber #Calls number generator
age=$? #Reads random number into age

while (true); do #Loops until broken by the correct number or q
    
    read -p "Guess the number: " guess #Prompts user for input
    
    if [[ $guess =~ ^[0-9]+$ ]]; then #Uses regular expression to check if it's an integer
        test #Calls test function

    else #Tells user that their integer is wrong
        echo "You have entered an invalid character, integers only"

    fi

done

exit 0