#!/bin/bash

# Prompt user for a number
read -p "Enter a number for the multiplication table: " num

echo "" # Inserts blank line

# Ask if user wants full or partial table
read -p "Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial): " str

echo "" # Inserts another blank line

while true; do
    # Partial table option
    if [ "$str" == "p" ]; then
        # Ask for starting and ending numbers and validate input
        read -p "Enter a starting number (between 1 and 10): " startnum
        read -p "Enter the ending number (between 1 and 10): " endnum

        # Validate that startnum is less than or equal to endnum
        if [ "$startnum" -gt "$endnum" ]; then
            echo "" # Insert a blank line
            echo "ERROR! Starting number is greater than the ending number."
            echo "Please try again."
            echo "" # Insert another blank line
            continue  # Loop again if invalid range
        fi

        # Print partial multiplication table
        echo "" # Insert a blank line
        echo "Your partial multiplication table for $num is:"
        for (( i=$startnum; i<=$endnum; i++ )); do
            echo "$num * $i = $(( num * i ))"
        done
        break  # Exit the loop after the partial table is printed

    # Full table option
    elif [ "$str" == "f" ]; then
        echo ""
        echo "Your full multiplication table for $num is:"
        for i in {1..10}; do
            echo "$num * $i = $(( num * i ))"
        done
        break  # Exit the loop after the full table is printed

    # Invalid input option
    else
        echo "" # Insert a blank line 
        echo "Your input is invalid. Enter 'f' for full or 'p' for partial."
        read -p "Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial): " str
    fi
done
