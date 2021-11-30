#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

# Fetch system information and store in variables with simpler names \
# X11			True if the user is using X11 \
# GNOME			True if the user is using the GNOME desktop \
# GNOME_VER		The official GNOME desktop version \
# GNOME_VER_INT	GNOME version to use with extensions
function fetch_system_information () {
	# Using X11?
	X11=false
	if [ "$XDG_SESSION_TYPE" = "x11" ]; then
		X11=true
	fi
	
	# Using GNOME?
	GNOME=false
	if [ "$XDG_CURRENT_DESKTOP" = "ubuntu:GNOME" ]; then
		GNOME=true
	elif [ "$ORIGINAL_XDG_CURRENT_DESKTOP" = "ubuntu:GNOME" ]; then
		# Attempt to get the original desktop
		GNOME=true
	fi
	
	# GNOME version
	GNOME_VER=0
	GNOME_VER_INT=0
	if $GNOME; then
		GNOME_VER=$(gnome-shell --version | grep -Po \(?\<=Shell\\s\)\(\\d.*\))
		GNOME_VER_INT=$(gnome-shell --version | grep -Po \(?\<=Shell\\s\)\(\\d+\))
	fi
}

# Warn about incompatible system information
function show_system_warnings () {
	# Must be using X11
	if ! $X11; then
		warning_message+="You are not running a X11 session.\nPlease log out and select GNOME X11.\n\n"
	fi
	
	# Must be using GNOME desktop
	if $GNOME; then
		# Must be using GNOME 40
		if ! [ $GNOME_VER_INT = 40 ]; then
			warning_message+="You are not using GNOME version 40.\nGNOME version $GNOME_VER is not guaranteed to work with this script.\n\n"
		fi
	else
		warning_message+="You are not using GNOME desktop.\nMost configuration options in this script require GNOME.\n\n"
	fi
	
	# Display any warnings
	if ! [ -z "$warning_message" ]; then
		warning_message+="Do you want to continue?"
		
		echo -ne '\007' # Beep sound
		
		if (whiptail --title "Warning" \
			--yesno "$warning_message" \
			0 0)
		then
			echo "Issues might occur"
		else
			exit 99
		fi
	fi
}