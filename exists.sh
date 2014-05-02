#!/bin/bash

path="$( cd "$(dirname "$0")" ; pwd -P )"
data="$HOME/Library/Application Support/Alfred 2/Workflow Data/com.api"

if [ ! -f "$data/endpoints/endpoints.list" ]; then
  $path/endpoints.sh
fi

if [ -z "$1" ]; then
  echo "ERROR: Empty Argument"
  exit 1
fi

bundle=$1
w=$( cat "$data/endpoints/endpoints.list" | grep $bundle | sed 's|"||g' )
wpath=${w#$bundle=}
if [ ! -z $wpath ]; then
  echo "$wpath"
else
  echo "FALSE"
fi
