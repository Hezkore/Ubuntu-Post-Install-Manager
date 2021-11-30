#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_misc_menu () {
	items=(
		"Folder_Setup" "Create common folder directories" "ON"
	)
	generate_selection_menu "Miscellaneous Options" "${items[@]}"
}

function folder_setup () {
	# Common user directories
	create_dir ~/Applications
	create_dir ~/Games
	create_dir ~/Projects/Others
	create_dir ~/Projects/Code/BlitzMax
	create_dir ~/Projects/Code/Bash
	create_dir ~/Projects/Code/C
	create_dir ~/Projects/Code/Cpp
	create_dir ~/Projects/Code/D
	create_dir ~/Projects/Code/TypeScript
	create_dir ~/Projects/Images
	create_dir ~/Projects/Audio
	
	# Make sure autostart directory exists!
	create_dir ~/.config/autostart
}