#!/bin/bash

# Creates a map of bundles and directories.

path="$( cd "$(dirname "$0")" ; pwd -P )"
data="$HOME/Library/Application Support/Alfred 2/Workflow Data/com.api"
endpoints="$data/endpoints"

me=$(basename "$path")
pb="/usr/libexec/PlistBuddy"

if [ ! -d "$data" ]; then
  mkdir "$data"
fi
if [ ! -d "$endpoints" ]; then
  mkdir "$endpoints"
fi

echo "{" > "$endpoints/endpoints.json"
for w in "../"*
do
  bundle=`$pb -c "Print :bundleid" "$w/info.plist"`
  if [ ! -z $bundle ]; then
    echo "\"$bundle\": \"$path$w\"," | sed 's|'"$me"'\.\./||g' >> "$endpoints/endpoints.json"
  fi
done
echo `cat "$endpoints/endpoints.json" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' | sed -e '$s|,$|}|'`  > "$endpoints/endpoints.json"

if [ -f "$endpoints/endpoints.list" ]; then
  rm "$endpoints/endpoints.list"
fi
for w in "../"*
do
  bundle=`$pb -c "Print :bundleid" "$w/info.plist"`
  if [ ! -z $bundle ]; then
    echo "\"$bundle\"=\"$path$w\"" | sed 's|'"$me"'\.\./||g' >> "$endpoints/endpoints.list"
  fi
done

if [ -f "$endpoints/endpoints" ]; then
  if [ ! $(cat "$endpoints/endpoints") = "$path" ]; then
    echo "$path" > "$endpoints/endpoints"
  fi
else
  echo "$path" > "$endpoints/com.api"
fi
