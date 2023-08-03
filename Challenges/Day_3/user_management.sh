#!/bin/bash

# Function to display usage information
usage() {
  echo "Usage: user_management.sh [options]"
  echo "Options:"
  echo "  -c, --create    Create a new user account"
  echo "  -d, --delete    Delete an existing user account"
  echo "  -r, --reset     Reset the password for an existing user account"
  echo "  -l, --list      List all user accounts on the system"
  echo "  -h, --help      Display this usage information"
}

# Function to create a new user account
create_user() {
  read -p "Enter the new username: " new_username
  # Check if the username already exists
  if id "$new_username" &>/dev/null; then
    echo "Username '$new_username' already exists. Please choose a different username."
  else
    read -s -p "Enter the password for '$new_username': " new_password
    echo
    sudo useradd -m "$new_username" &>/dev/null
    echo "$new_username:$new_password" | sudo chpasswd
    echo "User account '$new_username' created successfully."
  fi
}

# Function to delete an existing user account
delete_user() {
  read -p "Enter the username to delete: " delete_username
  # Check if the username exists
  if id "$delete_username" &>/dev/null; then
    sudo userdel -r "$delete_username"
    echo "User account '$delete_username' deleted successfully."
  else
    echo "Username '$delete_username' does not exist."
  fi
}

# Function to reset the password for an existing user account
reset_password() {
  read -p "Enter the username to reset password: " reset_username
  # Check if the username exists
  if id "$reset_username" &>/dev/null; then
    read -s -p "Enter the new password for '$reset_username': " new_password
    echo
    echo "$reset_username:$new_password" | sudo chpasswd
    echo "Password for '$reset_username' reset successfully."
  else
    echo "Username '$reset_username' does not exist."
  fi
}

# Function to list all user accounts on the system
list_users() {
  echo "User Accounts:"
  awk -F: '{printf "Username: %s, UID: %s\n", $1, $3}' /etc/passwd
}

# Main script logic
if [ $# -eq 0 ]; then
  echo "Error: No options provided."
  usage
  exit 1
fi

case "$1" in
  -c | --create)
    create_user
    ;;
  -d | --delete)
    delete_user
    ;;
  -r | --reset)
    reset_password
    ;;
  -l | --list)
    list_users
    ;;
  -h | --help)
    usage
    ;;
  *)
    echo "Error: Invalid option."
    usage
    exit 1
    ;;
esac

exit 0

