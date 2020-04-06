#!/bin/bash

#Name: Brandon Royce
#Student Number: Brandon Royce

echo "Welcome to the guessing game. Guess the number or press q to quit"

generateNumber() #Generates random number when called
{
    local age=$((20 + RANDOM % 70)) #Generates and stores number in local variable
    return $age #Returns local variable as in integer
}

#Tests user answer
test()
{
    if  (($guess == $age)) ; then
        echo "Success, you guessed the age"
        exit
    
    elif [ $guess == "q" ]; then
        echo "Goodbye"
        exit

    elif (($guess > $age)); then
        echo "Too high"

    elif (($guess < $age)); then
        echo "Guess is too low"
    
    else
        echo "Try again"

    fi
}

generateNumber #Calls number generator
age=$? #Reads random number into age

while ((1==1)); do
    read -p "Guess the number: " guess
    test
done

exit 0