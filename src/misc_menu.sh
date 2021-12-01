#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_misc_menu () {
	items=(
		"Folder_Setup" "Create common folder directories" "ON"
		"Nautilus_New_Docs" "Add 'New Document' menu to Nautilus" "ON"
		"Nautilus_Admin" "Add 'Open as Admin' option to Nautilus" "OFF"
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

function nautilus_new_docs () {
	touch ~/Templates/Empty\ Document
	mkdir ~/Templates/Code
	echo -e "SuperStrict\n\nFramework brl.standardio\n\nPrint(\"Hello World\")" > ~/Templates/Code/blitzmax.bmx
	echo -e "#include <iostream>\n\nint main() {\n\tstd::cout << \"Hello World\";\n\treturn 0;\n}" > ~/Templates/Code/cpp.cpp
	echo -e "#"'!'"/bin/bash\n# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-\n\n# My bash script\n\necho \"Hello World\"" > ~/Templates/Code/bash.sh
}

function nautilus_admin () {
	sudo apt install nautilus-admin -y
}