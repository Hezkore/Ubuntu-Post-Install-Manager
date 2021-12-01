#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

TITLE="Ubuntu Post-Install Manager"

clear

source src/common.sh

# Main categories
CATEGORIES=(
	"show_misc_menu"			"1. Miscellaneous"
	"show_software_menu"		"2. Software"
	"show_extensions_menu"		"3. Extensions"
	"show_configuration_menu"	"4. Configuration"
)
source src/misc_menu.sh
source src/software_menu.sh
source src/extensions_menu.sh
source src/configuration_menu.sh

# Make sure the system is compatible
fetch_system_information
show_system_warnings

# Main loop
while :;do
	show_main_menu
done