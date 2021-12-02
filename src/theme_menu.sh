#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_theme_menu () {
	items=(
		"Install_Fluent_Theme" "Install and apply the Fluent GTK theme" "ON"
		"Install_Fluent_Wallpapers" "Install and apply Fluent GTK wallpapers" "ON"
		"Install_Vimix_Icons" "Install and apply Vimix icons" "OFF"
		"Install_Windows_Icons" "Install and apply Windows icons" "ON"
		"Install_Mouse_Cursor" "Install and apply mouse cursor" "ON"
		"Install_Font_SegoeUI" "Install and apply Segoe UI font" "ON"
	)
	generate_selection_menu "Theme Options" "${items[@]}"
}

function install_fluent_theme () {
	if bin_exists "git"; then
		if bin_exists "dconf"; then
			# Ask for color
			color=$(whiptail --ok-button "Apply" --cancel-button "Abort" --notags \
				--title "Theme Configuration" --menu "Select theme color to apply" 0 0 0  \
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

function install_fluent_wallpapers () {
	if bin_exists "git"; then
		if bin_exists "dconf"; then
			
			dir="$HOME/.local/share/ubuntu-post-install-manager/Fluent-gtk-theme-wallpapers"
			rm -rf "$dir"
			mkdir -p "$dir"
			
			git clone -b Wallpaper https://github.com/vinceliuice/Fluent-gtk-theme.git "$dir"
			"$dir/install-wallpapers.sh" -t building mountain flat gradient
			
			dconf write /org/gnome/desktop/background/picture-uri "'file:///$dir/wallpaper-1080p/Fluent-building-morning.png'"
			
			return 0
		else
			LAST_ERROR="dconf is not installed, cannot apply wallpaper"
			return 1
		fi
	else
		LAST_ERROR="Git is not installed, cannot download wallpapers"
		return 1
	fi
}

function install_vimix_icons () {
	if bin_exists "git"; then
		if bin_exists "dconf"; then
			
			dir="$HOME/.local/share/ubuntu-post-install-manager/vimix-icon-theme"
			rm -rf "$dir"
			mkdir -p "$dir"
			
			git clone https://github.com/vinceliuice/vimix-icon-theme.git "$dir"
			"$dir/install.sh" -a
			
			dconf write /org/gnome/desktop/interface/icon-theme "'Vimix'"
			
			return 0
		else
			LAST_ERROR="dconf is not installed, cannot apply icons"
			return 1
		fi
	else
		LAST_ERROR="Git is not installed, cannot download icons"
		return 1
	fi
}

function install_windows_icons () {
	if bin_exists "git"; then
		if bin_exists "dconf"; then
			
			dir="$HOME/.local/share/ubuntu-post-install-manager/win11-icon-theme"
			rm -rf "$dir"
			mkdir -p "$dir"
			
			git clone https://github.com/yeyushengfan258/Win11-icon-theme.git "$dir"
			"$dir/install.sh" -a
			
			dconf write /org/gnome/desktop/interface/icon-theme "'Win11'"
			
			return 0
		else
			LAST_ERROR="dconf is not installed, cannot apply icons"
			return 1
		fi
	else
		LAST_ERROR="Git is not installed, cannot download icons"
		return 1
	fi
}

function install_mouse_cursor () {
	if bin_exists "dconf"; then
		echo "Applying default mouse cursor"
		dconf write /org/gnome/desktop/interface/cursor-theme "'DMZ-Black'"
		return 0
	else
		LAST_ERROR="dconf is not installed, cannot apply mouse theme"
		return 1
	fi
}

function install_font_segoeui () {
	if bin_exists "wget"; then
		
		if bin_exists "dconf"; then
			wget -O "SegoeUI-VF.zip" https://aka.ms/SegoeUIVariable
			
			mkdir "$HOME/.local/share/fonts"
			unzip -o "SegoeUI-VF.zip" -d "$HOME/.local/share/fonts"
			rm -rf SegoeUI-VF.zip
			
			dconf write /org/gnome/desktop/interface/font-name "'Segoe UI Variable Static Text 9.5"
			dconf write /org/gnome/desktop/interface/document-font-name "'Sans 10'"
			dconf write /org/gnome/desktop/interface/monospace-font-name "'Ubuntu Mono 13'"
			dconf write /org/gnome/desktop/wm/preferences/titlebar-font "'Segoe UI Variable Static Text Semi-Bold 11'"
			
			return 0
		else
			LAST_ERROR="dconf is not installed, cannot apply font"
			return 1
		fi
	else
		LAST_ERROR="WGet is not installed, cannot download font"
		return 1
	fi
}