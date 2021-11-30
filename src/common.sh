#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

# Quit properly
function quit () {
	exit 99
}

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
		warning_message+="You are not running a X11 session.\nPlease log out and start a X11 session.\n\n"
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
		warning_message+="The script might not work correctly.\nDo you still want to continue?"
		
		echo -ne '\007' # Beep sound
		
		if (whiptail --title "Warning" \
			--yesno "$warning_message" \
			0 0)
		then
			echo "Issues might occur"
		else
			quit
		fi
	fi
}

function show_main_menu () {
	actions=( "show_misc_menu" "1. Miscellaneous" \
	"show_software_menu" "2. Software" \
	"show_extensions_menu" "3. Extensions" \
	"show_configuration_menu" "4. Configuration" )
	
	category=$(whiptail --ok-button "Run" --cancel-button "Exit" --notags \
	--title "$TITLE" --menu "" 0 0 0 "${actions[@]}" 3>&1 1>&2 2>&3)
	
	if [ $? -gt 0 ]; then # User pressed Cancel
        quit
	else
		$category
    fi
}

function notify_error () {
	#notify-send "Error when running action!"
	echo -ne '\007' # Beep sound
	
	sleep 0.5
	
	if (whiptail --title "Error #$exitstatus" \
		--yesno "There was an error while executing action \"$LAST_ACTION_NAME\".\nMessage: $LAST_ERROR.\n\nDo you want to continue?" \
		0 0)
	then
		echo "== Resuming =="
		echo
	else
		echo "== Abort =="
		echo
		quit
	fi
	
	# Count error
	ERROR_COUNT="$(($ERROR_COUNT+1))"
}

function notify_complete () {
	#notify-send "Ubuntu Post-Install Script Done"
	echo -ne '\007' # Beep sound
	
	sleep 0.5
	
	whiptail --title "Complete" --msgbox "$ACTION_COUNT action(s) finished with $ERROR_COUNT error(s)." 0 0
}

function exec_action () {
	# Reset
	LAST_ERROR="Unknown Error"
	LAST_ACTION_NAME=${1//_/ }
	
	# Information
	echo "== $LAST_ACTION_NAME =="
	
	# Execute
	${1,,}
	
	# Fetch result
	exitstatus=$?
	
	# Error?
	if [ $exitstatus = 127 ]; then
		LAST_ERROR="Internal error"
	fi
	if [ $exitstatus = 0 ]; then
		echo "== Complete =="
		echo
	else
		echo "== Error #$exitstatus =="
		echo $LAST_ERROR
		notify_error
	fi
	
	# Count this action
	ACTION_COUNT="$(($ACTION_COUNT+1))"
}

function generate_selection_menu () {
	# We need to strip out the title from the array
	items_raw=("$@")
	items=()
	item_count=0
	index=0
	for i in "${items_raw[@]}"; do
		index="$(($index+1))"
		if ! ((index % 3)); then
			item_count="$(($item_count+1))"
		fi
		if (( index > 1 )); then
			items+=("$i")
		fi
	done
	
	choices=$(
		whiptail \
			--ok-button "Confirm" \
			--cancel-button "Abort" \
			--separate-output \
			--checklist \
			--title "Customize" \
			"$1" \
			0 0 \
			"$item_count" -- "${items[@]}" \
			3>&1 1>&2 2>&3
	)
	
	ERROR_COUNT=0
	ACTION_COUNT=0
	if [ -z "$choices" ]; then
		echo "Nothing selected"
	else
		for choice in $choices; do
			exec_action $choice
		done
	fi
	
	notify_complete
}