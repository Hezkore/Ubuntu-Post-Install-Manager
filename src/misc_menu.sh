#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_misc_menu () {
	items=(
		"Folder_Setup" "Create common folder directories" "ON"
		"Wine_Windows_Folder" "Create Windows folders for Wine" "ON"
		"Disable_Error_Report" "Disable Ubuntu error reporting" "ON"
		"Nautilus_New_Docs" "Add 'New Document' menu to Nautilus" "ON"
		"Nautilus_Admin" "Add 'Open as Admin' option to Nautilus" "OFF"
		"Nautilus_DOSBox" "Add 'Run with DOSbox' script to Nautilus" "ON"
		"Nautilus_Typeahead" "Add PPA repo with Nautilus Typeahead" "ON"
		"Nautilus_Remove_Typeahead" "Remove Nautilus Typeahead and PPA" "OFF"
	)
	generate_selection_menu "Miscellaneous Options" "${items[@]}"
}

function folder_setup () {
	# Common user directories
	create_dir ~/Applications
	create_dir ~/Games
	create_dir ~/Projects/Others
	create_dir ~/Projects/3D
	#create_dir ~/Projects/Code/BlitzMax
	#create_dir ~/Projects/Code/Bash
	create_dir ~/Projects/Code/C
	#create_dir ~/Projects/Code/Cpp
	#create_dir ~/Projects/Code/D
	create_dir ~/Projects/Code/JavaScript
	create_dir ~/Projects/Code/TypeScript
	create_dir ~/Projects/Images
	create_dir ~/Projects/Audio
	create_dir ~/Projects/Video
	create_dir ~/Projects/Misc
	
	# Make sure some standard local dirs exist
	create_dir ~/.config/autostart
	create_dir ~/.local/bin
	create_dir ~/.local/share/icons
	create_dir ~/.local/share/fonts
}

function wine_windows_folder () {
	# Make sure the Wine folder exists
	create_dir "$HOME/.wine/drive_c/Games"
	
	# Create the shortcut
	if [[ -d "$HOME/.wine/drive_c" ]]; then
		if [[ -d "$HOME/Windows" ]]; then
			echo "Windows folder already exists"
		else
			echo "Creating Wine drive C shortcut as Windows"
			ln -s "$HOME/.wine/drive_c" "$HOME/Windows"
		fi
		
		if [[ -d "$HOME/.wine/drive_c/syswine" ]]; then
			echo "syswine folder already exists"
		else
			echo "Creating Wine system shortcut as syswine"
			ln -s "$HOME/.wine" "$HOME/.wine/drive_c/syswine"
		fi
		
		if [[ -d "$HOME/Games" ]]; then
			if [[ -d "$HOME/Games/Windows Games" ]]; then
				echo "Windows Games fodler already exists"
			else
				if [[ -d "$HOME/.wine/drive_c/Games" ]]; then
					echo "Creating Wine Games shortcut as Windows Games"
					ln -s "$HOME/.wine/drive_c/Games" "$HOME/Games/Windows Games"
				fi
			fi
		fi
	else
		LAST_ERROR=".wine/drive_c folder doesn't exist"
		return 1
	fi
}

function disable_error_report () {
	sudo systemctl stop apport.service
	sudo systemctl disable apport.service
	sudo systemctl mask apport.service
}

function nautilus_new_docs () {
	echo "Creating template for empty document"
	touch ~/Templates/Empty\ Document
	create_dir ~/Templates/Code
	echo "Creating template for BlitzMax"
	echo -e "SuperStrict\n\nFramework brl.standardio\n\nPrint(\"Hello World\")" > ~/Templates/Code/blitzmax.bmx
	echo "Creating template for C++"
	echo -e "#include <iostream>\n\nint main() {\n\tstd::cout << \"Hello World\";\n\treturn 0;\n}" > ~/Templates/Code/cpp.cpp
	echo "Creating template for Bash"
	echo -e "#"'!'"/bin/bash\n# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-\n\n# My bash script\n\necho \"Hello World\"" > ~/Templates/Code/bash.sh
}

function nautilus_admin () {
	sudo apt install nautilus-admin -y
	
	return 0
}

function nautilus_dosbox () {
	if bin_exists "wget"; then
		create_dir "$HOME/.local/share/nautilus/scripts"
		wget -O "$HOME/.local/share/nautilus/scripts/Run with DOSBox" https://raw.githubusercontent.com/Hezkore/nautilus-dosbox/master/Run%20with%20DOSBox
		chmod +x "$HOME/.local/share/nautilus/scripts/Run with DOSBox"
		return 0
	else
		LAST_ERROR="WGet is not installed, cannot download script"
		return 1
	fi
}

function nautilus_typeahead () {
	sudo add-apt-repository ppa:lubomir-brindza/nautilus-typeahead -y
	# Update Nautilus
	sudo apt install nautilus -y
	
	# Restart Nautilus
	nautilus -q
	
	return 0
}

function nautilus_remove_typeahead () {
	if bin_exists "ppa-purge"; then
		echo "Removing PPA..."
	else
		# Attempt to install PPA-Purge
		sudo apt install ppa-purge -y
		
		if bin_exists "ppa-purge"; then
			echo "Removing PPA..."
		else
			# We did our best!
			LAST_ERROR="PPA-Purge is not installed, cannot remove repo"
			return 1
		fi
	fi
	
	# Purge everything from PPA
	sudo ppa-purge -y ppa:lubomir-brindza/nautilus-typeahead
	
	# Restart Nautilus
	nautilus -q
	
	return 0
}