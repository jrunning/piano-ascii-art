#!/bin/bash

# create variables
while read L; do
	k="`echo "$L" | cut -d '=' -f 1`"
	v="`echo "$L" | cut -d '=' -f 2`"
	export "$k=$v"
done < <(grep -e '^\(title\|artist\|album\|stationName\|pRet\|pRetStr\|wRet\|wRetStr\|songDuration\|songPlayed\|rating\|coverArt\)=' /dev/stdin)

DIR=$(cd `dirname $0` && pwd) # Where this script lives

case "$1" in
	# React when the song changes
	songstart)
		# This makes sure the directory for storing the album art exists

		if [ ! -d ~/.config/pianobar/art ] 
		then
			mkdir ~/.config/pianobar/art
		fi
		# Change to the album art directory
		cd ~/.config/pianobar/art
		# Get rid of any existing album art, but don't complain if there isn't any

    # TODO: Cache album art instead
		rm * 2> /dev/null

		# $coverArt is a URL pointing to the album art, so download it
		wget -q "$coverArt"

		# Finally, show the cover image as beautiful ASCII art
		source $DIR/img2txt-opts.sh
		img2txt $I2T_OPTS *
	;;

  # Try to handle errors
  userlogin)
    echo "Successfully logged in." | growlnotify $growlArgs
  ;;
  *)

		if [ "$pRet" -ne 1 ]; then
      echo '$1 failed: $pRetStr' | growlnotify $growlArgs
		elif [ "$wRet" -ne 1 ]; then
      echo '$1 failed: Network error: $wRetStr' | growlnotify $growlArgs
		fi
  ;;
esac

