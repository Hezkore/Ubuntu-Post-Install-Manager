#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_extensions_menu () {
	items=(
		"Install_User_Themes" "Install User Themes" "ON"
		"Install_ArcMenu" "Install ArcMenu" "ON"
		"Install_Tray_Icons_Reloaded" "Install Tray Icons Reloaded" "ON"
		"Install_No_Annoyance" "Install No Annoyance" "ON"
		"Install_Dash_to_Panel" "Install Dash-to-Panel" "ON"
		"Install_Clean_System_Menu" "Install Clean System Menu" "ON"
		"Install_Panel_Date_Format" "Install Panel Date Format" "ON"
		"Install_Application_Volume_Mixer" "Install Application Volume Mixer" "ON"
		"Install_Impatience" "Install Impatience" "ON"
		"Install_No_Overview" "Install No Overview" "ON"
		"Install_Game_Mode_Status_Icon" "Install Game Mode Status Icon" "ON"
		"Install_Blur_My_Shell" "Install Blur My Shell" "ON"
		"Install_GNOME_UI_Improvements" "Install Gnome 4x UI Improvements" "ON"
	)
	generate_selection_menu "Extension Options" "${items[@]}"
}

function _install_ext_id () {
	if bin_exists "gnome-shell-extension-installer"; then
		gnome-shell-extension-installer $1 <<< ${GNOME_VER_INT}
		# Always signal restart after an extension is installed
		NEEDS_LOGOUT=true
		return 0
	else
		LAST_ERROR="GNOME Shell Extension Installer is not installed, cannot download extension"
		return 1
	fi
}

function install_user_themes () {
	_install_ext_id 19
}

function install_arcmenu () {
	_install_ext_id 3628
}

function install_tray_icons_reloaded () {
	_install_ext_id 2890
}

function install_no_annoyance () {
	_install_ext_id 2182
}

function install_dash_to_panel () {
	_install_ext_id 1160
}

function install_clean_system_menu () {
	_install_ext_id 4298
}

function install_panel_date_format () {
	_install_ext_id 1462
}

function install_application_volume_mixer () {
	_install_ext_id 3499
}

function install_impatience () {
	_install_ext_id 277
}

function install_no_overview () {
	_install_ext_id 4099
}

function install_game_mode_status_icon () {
	_install_ext_id 1852
}

function install_blur_my_shell () {
	_install_ext_id 3193
}

function install_gnome_ui_improvements () {
	_install_ext_id 4158
}