#!/bin/sh

# arguments: URL of soundcloud file you want to extract
# effects: audio file created in /tmp/ (with mktemp)
# stdout: path to audio file of that soundcloud page





PAGE=`mktemp /tmp/sndcld-page-XXXXXXX`
AUDIO=`mktemp /tmp/sndcld-audio-XXXXXXX`

# wget --quiet -U "Mozilla/5.0 (X11; Linux x86_64; rv:20.0) Gecko/20100101 Firefox/20.0"  -O $PAGE $1
wget --quiet -U "But"$RANDOM"ts"  -O $PAGE $1

# yes, the user-agent matters. if soundcloud recognizes the user-agent it serves a page
# that needs javascript to run before the HTML that invokes player.swf can appear
# its arguments.

# if soundcloud doesn't recognize the user-agent, it serves up a page that includes HTML that 
# directly includes the player.swf bit, no javascript execution needed ^_^

CLIENTID=`cat $PAGE | grep window.SC.*clientID |tr , "\n"|grep clientID|cut -f2 -d:|sed -e 's/"//g'`
echo $CLIENTID

AUDIOURL=`grep swf $PAGE |sed -e 's/.*swf?url=//'|sed -e 's/&amp.*//'|perl -nlpe 's/%(..)/pack("c",hex($1))/ge'`

echo $AUDIOURL

AUDIOURL=$AUDIOURL"/stream?client_id="$CLIENTID
echo $AUDIOURL

wget -U "But"$RANDOM"ts" -O $AUDIO $AUDIOURL

echo "audio file is at $AUDIO"

rm $PAGE


