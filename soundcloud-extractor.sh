#!/bin/sh

# 


PAGE=`mktemp /tmp/sndcld-page-XXXXXXX`
AUDIO=`mktemp /tmp/sndcld-audio-XXXXXXX`



wget -U "Mozilla/5.0 (X11; Linux x86_64; rv:20.0) Gecko/20100101 Firefox/20.0"  -O $PAGE $1

CLIENTID=`cat $PAGE | grep window.SC.*clientID |tr , "\n"|grep clientID|cut -f2 -d:|sed -e 's/"//'`
echo $CLIENTID
