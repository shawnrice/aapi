#!/bin/sh

# Script to check an internet connection.

test_connection() {
  ping -c 1 -t 2 -q www.google.com > /dev/null 2>&1

  if [ 0 -eq $? ]; then
    echo 1
  else
    echo 0
  fi
}

if [ `test_connection` -eq 1 ]; then
  echo "Yes"
else
  echo "No"
fi
