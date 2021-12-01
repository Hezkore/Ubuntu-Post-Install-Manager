#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_configuration_menu () {
	items=(
		"Config_Mimeapps" "Configure and reset file type associations" "ON"
		"Config_Flameshot" "Configure Flameshot to stay in background" "ON"
		"Config_IMWheel" "Configure IMWheel scroll wheel speed" "ON"
		"Config_IMWheel_Start" "Configure IMWheel to start at login" "ON"
		"Config_Telegram_Start" "Configure Telegram to start at login" "ON"
		"Config_Discord_Start" "Configure Discord to start at login" "ON"
		"Config_Steam_Start" "Configure Steam to start at login" "ON"
		"Config_Geary_Start" "Configure Geary continuously check for new mail" "ON"
	)
	generate_selection_menu "Configuration Options" "${items[@]}"
}

function config_mimeapps () {
	file="$HOME/.config/mimeapps.list"
	
	# Remove any existing associations
	echo "Resetting $file"
	sudo rm -f "$file"
	
	# Create category
	touch "$file"
	echo '[Default Applications]' >> "$file"
	
	# Create new associations based on what's installed
	if bin_exists "audacious"; then
		echo "Writing audacious mimetypes"
		echo 'audio/x-s3m=audacious.desktop' >> "$file"
		echo 'audio/x-stm=audacious.desktop' >> "$file"
		echo 'audio/3gpp=audacious.desktop' >> "$file"
		echo 'audio/ac3=audacious.desktop' >> "$file"
		echo 'audio/AMR=audacious.desktop' >> "$file"
		echo 'audio/AMR-WB=audacious.desktop' >> "$file"
		echo 'audio/basic=audacious.desktop' >> "$file"
		echo 'audio/flac=audacious.desktop' >> "$file"
		echo 'audio/midi=audacious.desktop' >> "$file"
		echo 'audio/mp4=audacious.desktop' >> "$file"
		echo 'audio/mpeg=audacious.desktop' >> "$file"
		echo 'audio/mpegurl=audacious.desktop' >> "$file"
		echo 'audio/ogg=audacious.desktop' >> "$file"
		echo 'audio/prs.sid=audacious.desktop' >> "$file"
		echo 'audio/vnd.rn-realaudio=audacious.desktop' >> "$file"
		echo 'audio/x-ape=audacious.desktop' >> "$file"
		echo 'audio/x-flac=audacious.desktop' >> "$file"
		echo 'audio/x-gsm=audacious.desktop' >> "$file"
		echo 'audio/x-it=audacious.desktop' >> "$file"
		echo 'audio/x-m4a=audacious.desktop' >> "$file"
		echo 'audio/x-matroska=audacious.desktop' >> "$file"
		echo 'audio/x-mod=audacious.desktop' >> "$file"
		echo 'audio/x-mp3=audacious.desktop' >> "$file"
		echo 'audio/x-mpeg=audacious.desktop' >> "$file"
		echo 'audio/x-mpegurl=audacious.desktop' >> "$file"
		echo 'audio/x-ms-asf=audacious.desktop' >> "$file"
		echo 'audio/x-ms-asx=audacious.desktop' >> "$file"
		echo 'audio/x-ms-wax=audacious.desktop' >> "$file"
		echo 'audio/x-ms-wma=audacious.desktop' >> "$file"
		echo 'audio/x-musepack=audacious.desktop' >> "$file"
		echo 'audio/x-pn-aiff=audacious.desktop' >> "$file"
		echo 'audio/x-pn-au=audacious.desktop' >> "$file"
		echo 'audio/x-pn-realaudio=audacious.desktop' >> "$file"
		echo 'audio/x-pn-realaudio-plugin=audacious.desktop' >> "$file"
		echo 'audio/x-pn-wav=audacious.desktop' >> "$file"
		echo 'audio/x-pn-windows-acm=audacious.desktop' >> "$file"
		echo 'audio/x-realaudio=audacious.desktop' >> "$file"
		echo 'audio/x-real-audio=audacious.desktop' >> "$file"
		echo 'audio/x-sbc=audacious.desktop' >> "$file"
		echo 'audio/x-scpls=audacious.desktop' >> "$file"
		echo 'audio/x-speex=audacious.desktop' >> "$file"
		echo 'audio/x-tta=audacious.desktop' >> "$file"
		echo 'audio/x-wav=audacious.desktop' >> "$file"
		echo 'audio/x-wavpack=audacious.desktop' >> "$file"
		echo 'audio/x-vorbis=audacious.desktop' >> "$file"
		echo 'audio/x-vorbis+ogg=audacious.desktop' >> "$file"
		echo 'audio/x-xm=audacious.desktop' >> "$file"
		echo 'x-content/audio-player=audacious.desktop' >> "$file"
	fi
	
	if bin_exists "wine"; then
		echo "Writing wine mimetypes"
		echo 'application/x-ms-dos-executable=wine.desktop' >> "$file"
	fi
	
	if bin_exists "code"; then
		echo "Writing code mimetypes"
		echo 'application/x-shellscript=code.desktop' >> "$file"
		echo 'application/xml=code.desktop' >> "$file"
		echo 'application/xhtml+xml=code.desktop' >> "$file"
		echo 'application/json=code.desktop' >> "$file"
		echo 'text/xml=code.desktop' >> "$file"
	fi
	
	if bin_exists "gedit"; then
		echo "Writing gedit mimetypes"
		echo 'text/plain=org.gnome.gedit.desktop' >> "$file"
	fi
	
	if bin_exists "gdebi"; then
		echo "Writing gdebi mimetypes"
		echo 'application/vnd.debian.binary-package=gdebi.desktop' >> "$file"
	fi
	
	if bin_exists "geary"; then
		echo "Writing geary mimetypes"
		echo 'x-scheme-handler/mailto=geary.desktop' >> "$file"
	fi
}

function config_imwheel () {
	if bin_exists "wget"; then
		sudo mkdir -p /etc/X11/imwheel
		wget -O imwheelrc https://raw.githubusercontent.com/Hezkore/Ubuntu-Post-Install-Manager/master/extra/imwheelrc
		sudo mv imwheelrc /etc/X11/imwheel/
		return 0
	else
		LAST_ERROR="WGet is not installed, cannot download configuration"
		return 1
	fi
}