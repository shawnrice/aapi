#!/bin/bash

# $1 = Workflow
# $2 = External Trigger
# $3 = Callback Workflow
# $4 = Callback External Trigger
# $5 = Argument

data="$HOME/Library/Application Support/Alfred 2/Workflow Data/com.api"
cache="$HOME/Library/Caches/com.runningwithcrayons.Alfred-2/Workflow Data/com.api"
hsdir="$cache/handshake"

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
  echo "ERROR: A-Handshake Protocol requires a minimum of four arguments."
  exit 1
fi

handshake="$1"
callback="$2" # Or can we call this a "shakeback"? No. That's way too cheesy.

for d in "$data" "$cache" "$hsdir" "$hsdir/$1"
do
  if [ ! -d "$d" ]; then
    mkdir "$d"
  fi
done

echo "$4@$3" > "$hsdir/$1/$2"

osascript -e "tell application \"Alfred 2\" to run trigger \"com.api.exists\" in workflow \"com.api\" with argument \"com.api\""

if [ ! -z "$4" ]; then
  osascript -e "tell application \"Alfred 2\" to run trigger \"$2\" in workflow \"$1\" with argument \"$5\""
else
  osascript -e "tell application \"Alfred 2\" to run trigger \"$2\" in workflow \"$1\""
fi

rm "$hsdir/$1/$2"

For instance...
./handshake.sh 'alfred.cron.spr' 'com.alfred.cron.spr.add' 'com.api' 'com.api.handshake' 'test'
