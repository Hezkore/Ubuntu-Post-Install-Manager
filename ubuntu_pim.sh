#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

TITLE="Ubuntu Post-Install Manager"
VERSION="1.0"

clear

source src/common.sh

# Main categories
CATEGORIES=(
	"show_misc_menu"			"1. Miscellaneous"
	"show_drivers_menu"			"2. Drivers"
	"show_software_menu"		"3. Software"
	"show_extensions_menu"		"4. Extensions"
	"show_configuration_menu"	"5. Configuration"
	"show_theme_menu"			"6. Theme"
	"show_firmware_menu"		"x. Firmware"
)
source src/misc_menu.sh
source src/drivers_menu.sh
source src/software_menu.sh
source src/extensions_menu.sh
source src/configuration_menu.sh
source src/theme_menu.sh
source src/firmware_menu.sh

# Make sure the system is compatible
fetch_system_information
show_system_warnings

# Main loop
while :;do
	show_main_menu
done