#!/bin/bash

# First line of the script is the shebang which tells the system how to execute

# Task  2: Echo
echo "Scripting is fun and this is the Day_1 of BASH SCRIPTING CHALLENGES"

# Task  3: Variables
variable1="Hello"
variable2="World"

# Task  4: Using Variables
read -p "Enter the first number: " variable1
read -p "Enter the second number: " variable2
sum=$(expr "$variable1" + "$variable2")
echo "The sum of $variable1 and $variable2 is: $sum"

# Task  5: Using Built-in Variables
current_date=$(date +"%Y-%m-%d %H:%M:%S")
echo "Current date and time: $current_date"
echo "Currently running script: ${BASH_SOURCE[0]}"
echo "Process ID of the current script: $$"

# Task  6: Wildcards
read -p "Enter the directory path: " directory_path
read -p "Enter the file extension to list (without the dot): " file_extension
ls "$directory_path"/*."$file_extension"


#Make sure to provide execution permission with the following command:
#chmod +x day1_script.sh
