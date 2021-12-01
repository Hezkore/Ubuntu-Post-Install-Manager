#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_configuration_menu () {
	items=(
		"Config_IMWheel" "Configure IMWheel scroll wheel speed" "ON"
	)
	generate_selection_menu "Configuration Options" "${items[@]}"
}

function config_imwheel () {
	if bin_exists "wget"; then
		sudo mkdir -p /etc/X11/imwheel
		wget -O imwheelrc https://raw.githubusercontent.com/Hezkore/Ubuntu-Post-Install-Manager/master/extra/imwheelrc
		sudo mv imwheelrc /etc/X11/imwheel/
		return 0
	else
		LAST_ERROR="WGet is not installed, cannot download configuration"
		return 1
	fi
}