#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_updates_menu () {
	items=(
		"Update_APT_Software" "Update APT software" "ON"
		"Clean_APT" "Auto remove redundant APT data and clean" "ON"
		"Update_Flatpak_Software" "Update all Flatpak software" "ON"
	)
	SHOW_RECOMMEND_OPTION=false
	generate_selection_menu "Update Options" "${items[@]}"
}

function update_apt_software () {
	echo "Checking for update..."
	sudo apt update -y
	
	avail=$(apt list --upgradable | awk '(NR>1)')
	echo "$avail"
	
	#if (whiptail --title "Available Updates" --scrolltext --yesno "$avail\n\nUpgrade software?" 0 0); then
	#	echo "Updating..."
		sudo apt upgrade -y
	#else
	#	echo "Skipping updates"
	#	return 0
	#fi
}

function clean_apt () {
	sudo apt autoremove -y
	sudo apt clean -y
}

function update_flatpak_software () {
	if bin_exists "flatpak"; then
		flatpak update
		return 0
	else
		LAST_ERROR="Flatpak is not installed, cannot update Flatpak software"
		return 1
	fi
}