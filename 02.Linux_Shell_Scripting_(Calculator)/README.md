# Linx Shell Scripting

`#!/bin/bash` # Every bash script begins with a "shebang (#!)" followed by /bin/bash which is the path to bash in the root file.

### #Prompt user for a number

`read -p "Enter a number for the multiplication table: " num`

#### #The above command promts the user to enter a number for the multiplication table and saves the input in the "num" string

`echo ""` # Inserts blank line

#### NOTE: Anywhere you see `echo ""`, just understand that I'm trying to give a blank line to ensure my work is organized. Another way to do achieve that is to use  `echo -e` within `\n`. Example ` echo -e "\n<text>.\n"`. 

### #Ask if user wants full or partial table
`read -p "Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial): " str`

#### #The above code asks the user to choose if they want a full table or a partial table and saves it in the "str" string.

`echo ""` # Inserts another blank line

`while true; do`
#### #I'm employing the while-loop to create a condtion.     
    # Partial table option
    if [ "$str" == "p" ]; then
        # Ask for starting and ending numbers and validate input
        read -p "Enter a starting number (between 1 and 10): " startnum
        read -p "Enter the ending number (between 1 and 10): " endnum

#### #The above syntax is simply saying that if the user's input saved in the `$str`string is 'p', then it should ask for a starting number and save the input in a "`startnum`" string. Then it should ask for the ending number and save the user input in an "`endnum`" string. We used and if-statement.

        # Validate that startnum is less than or equal to endnum
        if [ "$startnum" -gt "$endnum" ]; then
            echo "" # Inserts a blank line
            echo "ERROR! Starting number is greater than the ending number."
            echo "Please try again."
            echo "" # Inserts another blank line
            continue  # Loop again if invalid range
        fi

#### #The above syntax is saying that if the starting number is greater than the ending number, it should give an error output and ask that the user tries again. We used a "Break and Continue" statement. `continue` makes the output loop again if the user inputs an invalid range. 

        # Print partial multiplication table
        echo "" # Inserts a blank line
        echo "Your partial multiplication table for $num is:"
        for (( i=$startnum; i<=$endnum; i++ )); do
            echo "$num * $i = $(( num * i ))"
        done
        break  # Exit the loop after the partial table is printed

#### #The above syntax uses a for loop in a C-style syntax where we control the initialization, the condition and the increment.
#### `(( i=$startnum; i<=$endnum; i++ ))`tells the loop that the first value should be the number in the `$startnum` string, and should continue till it gets to the value in the `$endnum` string, increasing it by 1 value (`i++`).
#### `echo "$num * $i = $(( num * i ))"` syntax mean it'll print the value in the '`$num`' string and multiply it each time with each of the output values produced by the previous for loop.
#### `break` exits the loop after the partial table has been printed.


    # Full table option
    elif [ "$str" == "f" ]; then
        echo ""
        echo "Your full multiplication table for $num is:"
        for i in {1..10}; do
            echo "$num * $i = $(( num * i ))"
        done
        break  # Exit the loop after the full table is printed

#### The above syntax is another if statement connoted by `elif`, stating that if the user input for the table option is 'f' (full table), it'll first print "Your full multiplication table for $num is:". The `for` loop iterates over a range of numbers (in this case, 1-10), multipling the value in the `$num` string by each number beging from 1 to 10.
#### `break` exits the loop after the full table has been printed.

    # Invalid input option
    else
        echo "" # Insert a blank line
        echo "Your input is invalid. Enter 'f' for full or 'p' for partial."
        read -p "Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial): " str
    fi
done

#### #The above syntax prints "Your input is invalid. Enter 'f' for full or 'p' for partial." if the user enters any value that is not either 'f' or 'p', then asks the user to input another value. The `while` loop repeats the loop as long as the specified condition is not met. To stop the loop you must enter a valid value.
#### `done`  serves as the terminating keyword that marks the end of the loop's body.

#Thank you