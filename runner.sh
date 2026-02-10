#!/bin/sh
# SPDX-License-Identifier: Apache-2.0

if [ $# -ne 2 ] ; then
	echo "usage: $0 <directory> <command>"
	exit 1
fi

DIRECTORY=$1
COMMAND=$2

DIR=$(pwd)
if [ -n "$DIRECTORY" ] ; then
	DIR="$DIR/$DIRECTORY"
fi

UNAME=$(uname)
if [ "$UNAME" = 'Darwin' ] ; then
	osascript -e "tell app \"Terminal\" to do script \"cd $DIR && $COMMAND\""
elif [ "$UNAME" = 'Linux' ] ; then
	if type gnome-terminal > /dev/null 2>&1 ; then
		#gnome-terminal --working-directory=$DIR -- bash -c "$COMMAND; bash"
		gnome-terminal -- bash -c "cd $DIR && $COMMAND; bash"
	elif type konsole > /dev/null 2>&1 ; then
		konsole --hold -e bash -c "cd $DIR && $COMMAND; bash" &
	elif type xfce4-terminal > /dev/null 2>&1 ; then
		xfce4-terminal --hold -e "bash -c 'cd $DIR && $COMMAND; bash'" &
	elif type xterm > /dev/null 2>&1 ; then
		xterm -hold -e "cd $DIR && $COMMAND" &
	else
		echo 'Your platform is not supported : no xterm, gnome-terminal, konsole, or xfce4-terminal'
		sh -c "cd $DIR && $COMMAND" &
	fi
else
	echo "Your platform is not supported : $(uname -a)"
	sh -c "cd $DIR && $COMMAND" &
fi
