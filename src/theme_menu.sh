#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_theme_menu () {
	items=(
		"Install_Fluent_Theme" "Install and apply the Fluent GTK theme" "ON"
		"Install_Fluent_Wallpapers" "Install and apply Fluent GTK wallpapers" "ON"
		"Install_Vimix_Icons" "Install and apply Vimix icons" "OFF"
		"Install_Windows_Icons" "Install and apply Windows icons" "ON"
	)
	generate_selection_menu "Theme Options" "${items[@]}"
}

function install_fluent_theme () {
	if bin_exists "git"; then
		if bin_exists "dconf"; then
			# Ask for color
			color=$(whiptail --ok-button "Apply" --cancel-button "Abort" --notags \
				--title "Theme Configuration" --menu "Select theme color" 0 0 0  \
				"default" "Default" \
				"purple" "Purple" \
				"pink" "Pink" \
				"red" "Red" \
				"orange" "Orange" \
				"yellow" "Yellow" \
				"green" "Green" \
				"grey" "Grey" \
				3>&1 1>&2 2>&3)
			
			# Download or abort
			if [ $? -gt 0 ]; then
				# User pressed abort
				echo "No theme will be installed"
				return 0
			else
				echo "Theme color $color"
				
				dir="$HOME/.local/share/ubuntu-post-install-manager/Fluent-gtk-theme"
				rm -rf "$dir"
				mkdir -p "$dir"
				
				git clone https://github.com/vinceliuice/Fluent-gtk-theme.git "$dir"
				
				"$dir/install.sh" -t all --tweaks round noborder square
				"$dir/install.sh" -t all --tweaks noborder square
			fi
			
			# Apply
			dconf write /org/gnome/desktop/interface/gtk-theme "'Fluent-round-$color-light-compact'"
			dconf write /org/gnome/shell/extensions/user-theme/name "'Fluent-$color-dark'"
			# gedit needs to change as well, otherwise it's just all black
			dconf write /org/gnome/gedit/preferences/editor/scheme "'Yaru-dark'"
			
			return 0
		else
			LAST_ERROR="dconf is not installed, cannot apply theme"
			return 1
		fi
	else
		LAST_ERROR="Git is not installed, cannot download theme"
		return 1
	fi
}