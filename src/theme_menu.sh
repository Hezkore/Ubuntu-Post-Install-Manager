#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_theme_menu () {
	items=(
		"Install_Fluent_Theme" "Download, install and apply the Fluent GTK theme" "ON"
		"Install_Fluent_Wallpapers" "Download, install and apply Fluent GTK wallpapers" "ON"
		"Install_Vimix_Icons" "Download, install and apply Vimix icons" "OFF"
		"Install_Windows_Icons" "Download, install and apply Windows icons" "ON"
		"Install_Mouse_Cursor" "Download, install and apply mouse cursor" "ON"
		"Install_Font_SegoeUI" "Download, install and apply Segoe UI font" "ON"
		"Install_Nerd_Fonts" "Download Nerd Fonts for coders" "ON"
		"Config_GNOME_Terminal_Theme" "Configure GNOME terminal theme" "ON"
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
			if [ $color = "default" ]; then
					dconf write /org/gnome/desktop/interface/gtk-theme "'Fluent-round-light-compact'"
				dconf write /org/gnome/shell/extensions/user-theme/name "'Fluent-dark'"
			else
				dconf write /org/gnome/desktop/interface/gtk-theme "'Fluent-round-$color-light-compact'"
				dconf write /org/gnome/shell/extensions/user-theme/name "'Fluent-$color-dark'"
			fi
			
			# gedit needs to change as well, otherwise it's just all black
			dconf write /org/gnome/gedit/preferences/editor/scheme "'Yaru-dark'"
			
			return 0
		else
			LAST_ERROR="DConf is not installed, cannot apply theme"
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
			LAST_ERROR="DConf is not installed, cannot apply wallpaper"
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
			LAST_ERROR="DConf is not installed, cannot apply icons"
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
			"$dir/install.sh" -w
			
			dconf write /org/gnome/desktop/interface/icon-theme "'Win11'"
			
			return 0
		else
			LAST_ERROR="DConf is not installed, cannot apply icons"
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
		LAST_ERROR="DConf is not installed, cannot apply mouse theme"
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
			
			dconf write /org/gnome/desktop/interface/font-name "'Segoe UI Variable Static Text 9.5'"
			dconf write /org/gnome/desktop/interface/document-font-name "'Sans 10'"
			dconf write /org/gnome/desktop/interface/monospace-font-name "'Ubuntu Mono 13'"
			dconf write /org/gnome/desktop/wm/preferences/titlebar-font "'Segoe UI Variable Static Text Semi-Bold 11'"
			
			dconf write /org/gnome/desktop/interface/font-antialiasing "'rgba'"
			dconf write /org/gnome/desktop/interface/font-hinting "'slight'"
			
			return 0
		else
			LAST_ERROR="DConf is not installed, cannot apply font"
			return 1
		fi
	else
		LAST_ERROR="WGet is not installed, cannot download font"
		return 1
	fi
}

function _install_nerd_font () {
	wget -O $1.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$1.zip
	sudo mkdir -p "/usr/share/fonts/truetype/$1-nerd-font"
	sudo unzip -o -d "/usr/share/fonts/truetype/$1-nerd-font" $1.zip "*.ttf"
	sudo unzip -o -d "/usr/share/fonts/opentype/$1-nerd-font" $1.zip "*.otf" "*.ttc"
	sudo rm -f $1.zip
}

function install_nerd_fonts () {
	if bin_exists "wget"; then
		
		# Make a temporary storage space for the fonts
		mkdir -p "$HOME/.nerd-fonts"
		cd "$HOME/.nerd-fonts"
		
		_install_nerd_font 3270
		_install_nerd_font Agave
		_install_nerd_font CascadiaCode
		_install_nerd_font Cousine
		_install_nerd_font CodeNewRoman
		_install_nerd_font DejaVuSansMono
		_install_nerd_font DroidSansMono
		_install_nerd_font FiraMono
		_install_nerd_font Go-Mono
		_install_nerd_font Hack
		_install_nerd_font Hasklig
		_install_nerd_font Inconsolata
		_install_nerd_font JetBrainsMono
		_install_nerd_font LiberationMono
		#_install_nerd_font Noto  #A bit too massive honestly...
		_install_nerd_font ProFont
		_install_nerd_font Overpass
		_install_nerd_font RobotoMono
		_install_nerd_font SpaceMono
		_install_nerd_font SourceCodePro
		
		# Cleanup
		sudo rm -rf "$HOME/.nerd-fonts"
		sudo find "/usr/share/fonts/truetype" -type d -empty -delete
		sudo find "/usr/share/fonts/opentype" -type d -empty -delete
		
		return 0
	else
		LAST_ERROR="WGet is not installed, cannot download fonts"
		return 1
	fi
}

function config_gnome_terminal_theme () {
	if bin_exists "dconf"; then
		echo "Fetching terminal profile..."
		
		# First we need to get a terminal profile
		# Notice that /org/gnome/terminal/legacy/profiles:/default does NOT work!
		term_profile_raw=$(dconf read /org/gnome/terminal/legacy/profiles:/list)
		term_profile=${term_profile_raw:2:36}
		
		# Apply our changes
		echo "Applying configuration to profile $term_profile..."
		dconf write /org/gnome/terminal/legacy/profiles:/:$term_profile/use-theme-transparency false
		dconf write /org/gnome/terminal/legacy/profiles:/:$term_profile/use-transparent-background true
		dconf write /org/gnome/terminal/legacy/profiles:/:$term_profile/background-transparency-percent 3
		
		# Font
		term_font_size="12"
		term_font_dir="Hack-nerd-font"
		term_font_file="Hack Regular Nerd Font Complete Mono.ttf"
		term_font_name="Hack Nerd Font Mono"
		
		term_font="/usr/share/fonts/truetype/$term_font_dir/$term_font_file"
		
		if [ -f "$term_font" ]; then
			echo "Applying font \"'$term_font_name $term_font_size'\"..."
			dconf write /org/gnome/terminal/legacy/profiles:/:$term_profile/use-system-font false
			dconf write /org/gnome/terminal/legacy/profiles:/:$term_profile/font "'$term_font_name $term_font_size'"
		else
			echo "The font $term_font_name was not found, using system font..."
			dconf write /org/gnome/terminal/legacy/profiles:/:$term_profile/use-system-font true
		fi
		
		return 0
	else
		LAST_ERROR="DConf is not installed, cannot change GNOME terminal configuration"
		return 1
	fi
}