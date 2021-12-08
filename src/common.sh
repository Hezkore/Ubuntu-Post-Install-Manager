#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function bin_exists () {
  command -v "$1" >/dev/null 2>&1
}

function add_ppa () {
	if bin_exists "add-apt-repository"; then
		sudo add-apt-repository $1 -y
		# This isn't actually required anymore on newer APT
		# But we'll have to detect that newer APT version!
		sudo apt update
		return 0
	else
		LAST_ERROR="Software-properties-common is not installed, cannot add custom PPA"
		#echo "$LAST_ERROR"
		return 1
	fi
}

function create_dir () {
	mkdir -p $1
	if [[ -d $1 ]]; then
		echo "Created directory $1"
		return 0
	else
		LAST_ERROR="Unable to create directory $1"
		return 1
	fi
}

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
		warning_message+="You are not running a X11 session.\nPlease log out and select \"Ubuntu on Xorg\".\n\n"
		echo "Not a X11 session"
	fi
	
	# Must be using GNOME desktop
	if $GNOME; then
		# Must be using GNOME 40
		if ! [ $GNOME_VER_INT = 40 ]; then
			warning_message+="You are not using GNOME version 40.\nGNOME version $GNOME_VER is not guaranteed to work with this script.\n\n"
			echo "Incorrect GNOME version"
		fi
	else
		warning_message+="You are not using GNOME desktop.\nMost configuration options in this script require GNOME.\n\n"
		echo "Not using GNOME"
	fi
	
	# Warn about weird PATH
	PATHS=($(echo $PATH | tr ':' "\n"))
	local_exists=false
	for dir in "${PATHS[@]}"; do
		if [ $dir = "$HOME/.local/bin" ]; then
			local_exists=true
			break
		fi
	done
	if ! $local_exists; then

		# Okay so local bin dir did not exist, try to create it...
		mkdir -p "$HOME/.local/bin"
		# Now source .profile
		source ~/.profile
		# Now check again (ugh, repeated code!)
		PATHS=($(echo $PATH | tr ':' "\n"))
		for dir in "${PATHS[@]}"; do
			if [ $dir = "$HOME/.local/bin" ]; then
				local_exists=true
				break
			fi
		done

		if $local_exists; then
			#warning_message+="$HOME/.local/bin was added to the PATH environment variable.\n\n"
			echo -e "$HOME/.local/bin added to PATH"
		else
			warning_message+="$HOME/.local/bin is not in the PATH environment variable.\nSome applications might require it.\n\n"
			echo -e "\033[1m$HOME/.local/bin\033[0m is not in environment variable PATH"
		fi
	fi
	
	# Display any warnings
	if ! [ -z "$warning_message" ]; then
		warning_message+="The script might not work correctly due to these issues.\nDo you still want to continue?"
		
		echo -ne '\007' # Beep sound
		
		if (whiptail --title "Warning" \
			--yesno "$warning_message" \
			0 0)
		then
			echo "Issues might occur"
		else
			echo "User exit due to error"
			quit
		fi
	fi
}

function show_main_menu () {
	# Try to get sudo access early
	category=$(whiptail --ok-button "Run" --cancel-button "Exit" --notags \
	--title "$TITLE v$VERSION" --menu "\nMake sure to read the README" 0 0 0 "${CATEGORIES[@]}" 3>&1 1>&2 2>&3)
	
	if [ $? -gt 0 ]; then # User pressed Cancel
        quit
	else
		# Reset
		SHOW_RECOMMEND_OPTION=true
		$category
    fi
}

function notify_error () {
	if bin_exists "notify-send"; then
		notify-send "Ubuntu Post-Install Manager - Error when running action!"
	fi
	echo -ne '\007' # Beep sound
	
	sleep 0.5
	
	if (whiptail --title "Error #$exitstatus" \
		--yesno "There was an error while executing action \"$LAST_ACTION_NAME\".\nMessage: $LAST_ERROR.\n\nDo you want to continue with the next action?" \
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
	if bin_exists "notify-send"; then
		notify-send "Ubuntu Post-Install Manager - All actions complete"
	fi
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
	items_raw=("$@")
	
	# Ask if the user wants the recommended options
	rec_options=true
	if $SHOW_RECOMMEND_OPTION; then
		if [[ "${items_raw[@]}" =~ "ON" ]]; then
			if (whiptail --title "Recommended Options" --yes-button "Recommended" --no-button "Empty" --yesno "What options do you want to start with?" 0 0); then
				rec_options=true
			else
				rec_options=false
			fi
		fi
	fi
	
	# We need to strip out the title from the array
	items=()
	item_count=0
	index=0
	for i in "${items_raw[@]}"; do
		index="$(($index+1))"
		if ! ((index % 3)); then
			item_count="$(($item_count+1))"
		fi
		if (( index > 1 )); then
			# Do we want the recommended options?
			if ! $rec_options; then
				if [ "$i" = "ON" ]; then
					items+=("OFF")
				else
					items+=("$i")
				fi
			else
				items+=("$i")
			fi
		fi
	done
	
	choices=$(
		whiptail \
			--notags \
			--ok-button "Confirm" \
			--cancel-button "Back" \
			--separate-output \
			--checklist "$1" \
			--title "Customize" \
			0 0 0 \
			"${items[@]}" \
			3>&1 1>&2 2>&3
	)
	#choices_count="${#choices[@]}" # Why doesn't this work?!?!
	choices_count=0
	for choice in $choices; do
		choices_count="$(($choices_count+1))"
	done
	
	# Reset
	NEEDS_LOGOUT=false
	NEEDS_RESTART=false
	ERROR_COUNT=0
	ACTION_COUNT=0
	
	# Run actions
	if [ -z "$choices" ]; then
		return
	else
		# Ask if really ready
		if (whiptail --title "Are You Sure?" --yesno "Do you really want to start $choices_count action(s)?" 0 0); then
			sudo echo
			
			for choice in $choices; do
				exec_action $choice
			done
			
			# Notify the user that all actions are complete
			notify_complete
			
			# DO NOT RETURN!
			# We need to know if logout or reboot is needed
		else
			return 0
		fi
	fi
	
	# Did an action signal that a restart or log out is needed?
	if $NEEDS_RESTART; then
		if (whiptail --yes-button "Now" --no-button "Later" --defaultno --title "Important!" --yesno "You MUST restart for the changes to take effect.\nThis is required.\n\nRestart now?" 0 0); then
			gnome-session-quit --reboot --no-prompt
		else
			echo "It's important that you reboot!"
		fi
	else
		if $NEEDS_LOGOUT; then
			if (whiptail --yes-button "Now" --no-button "Later" --defaultno --title "Important!" --yesno "You need to restart or log out for the changes to take effect.\nThis is required before running the next step.\n\nLog out now?" 0 0); then
				gnome-session-quit --logout --no-prompt
			else
				echo "Remember to log out or reboot"
			fi
		fi
	fi
}