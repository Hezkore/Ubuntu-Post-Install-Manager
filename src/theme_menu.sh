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
	
}