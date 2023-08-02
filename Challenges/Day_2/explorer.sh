#!/bin/bash

# This script is an interactive file and directory explorer.
# It displays a list of all the files and directories in the current path,
# and allows the user to enter lines of text and count the number of characters in each line.

# Part 1: File and Directory Exploration

echo "Welcome to the Interactive File and Directory Explorer!"

while true; do
  # List all the files and directories in the current path.
  ls -lh

  # Check if the user wants to exit.
  read -p "Do you want to exit (y/N)? " answer

  # If the user enters "y", exit the loop.
  if [[ $answer =~ ^y$ ]]; then
    break
  fi
done

# Part 2: Character Counting

echo "Now, we will count the number of characters in each line of text you enter."

# Prompt the user to enter a line of text.
while true; do
  read -p "Enter a line of text: " line

  # If the user enters an empty string, exit the loop.
  if [[ $line = "" ]]; then
    break
  fi

  # Count the number of characters in the line.
  character_count=$(echo $line | wc -m)

  # Display the character count.
  echo "The number of characters in the line is: $character_count"
done

# Exit the script.
exit 0
