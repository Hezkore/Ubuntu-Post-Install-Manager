#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_configuration_menu () {
	items=(
		"Config_Git" "Configure Git username and email" "ON"
		"Config_Mimeapps" "Configure and reset file type associations" "ON"
		"Config_Flameshot" "Configure Flameshot to stay in the background" "ON"
		"Config_IMWheel" "Configure IMWheel scroll wheel speed" "ON"
		"Config_IMWheel_Start" "Configure IMWheel to start at login" "ON"
		"Config_Telegram_Start" "Configure Telegram to start at login" "ON"
		"Config_Discord_Start" "Configure Discord to start at login" "ON"
		"Config_Steam_Start" "Configure Steam to start at login" "ON"
		"Config_Geary_Start" "Configure Geary to check for incoming email" "ON"
		"Config_Enabled_Ext" "Enable user extensions and disable built-in" "ON"
	
		"Configure_User_Themes" "Configure User Themes" "ON"
		"Configure_ArcMenu" "Configure ArcMenu" "ON"
		"Configure_Tray_Icons_Reloaded" "Configure Tray Icons Reloaded" "ON"
		"Configure_No_Annoyance" "Configure No Annoyance" "ON"
		"Configure_Dash_to_Panel" "Configure Dash-to-Panel" "ON"
		"Configure_Clean_System_Menu" "Configure Clean System Menu" "ON"
		"Configure_Panel_Date_Format" "Configure Panel Date Format" "ON"
		"Configure_Application_Volume_Mixer" "Configure Application Volume Mixer" "ON"
		"Configure_Impatience" "Configure Impatience" "ON"
		"Configure_No_Overview" "Configure No Overview" "ON"
		"Configure_Game_Mode_Status_Icon" "Configure Game Mode Status Icon" "ON"
		"Configure_Blur_My_Shell" "Configure Blur My Shell" "ON"
		"Configure_GNOME_4x_UI_Improvements" "Configure Gnome 4x UI Improvements" "ON"
	)
	generate_selection_menu "Configuration Options" "${items[@]}"
}

function config_git () {
	if bin_exists "git"; then
	
		git_username=$(whiptail --inputbox "Enter your Git username" 0 0 --title "Git Configuration" 3>&1 1>&2 2>&3)
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			git config --global user.name "$git_username"
			echo "Username: $git_username"
		fi
		
		git_usermail=$(whiptail --inputbox "Enter your Git E-Mail" 0 0 --title "Git Configuration" 3>&1 1>&2 2>&3)
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			git config --global user.email $git_usermail
			echo "E-Mail: $git_usermail"
		fi
		
		whiptail --title "Git Configuration" --msgbox "Your Git config:\n$(git config --global --list)" 0 0
		
		return 0
	else
		LAST_ERROR="Git is not installed, cannot start configuration"
		return 1
	fi
}

function config_mimeapps () {
	file="$HOME/.config/mimeapps.list"
	
	# Remove any existing associations
	echo "Resetting $file"
	sudo rm -f "$file"
	
	# Create category
	touch "$file"
	echo '[Default Applications]' >> "$file"
	
	# Create new associations based on what's installed
	if bin_exists "audacious"; then
		echo "Writing audacious mimetypes"
		echo 'audio/x-s3m=audacious.desktop' >> "$file"
		echo 'audio/x-stm=audacious.desktop' >> "$file"
		echo 'audio/3gpp=audacious.desktop' >> "$file"
		echo 'audio/ac3=audacious.desktop' >> "$file"
		echo 'audio/AMR=audacious.desktop' >> "$file"
		echo 'audio/AMR-WB=audacious.desktop' >> "$file"
		echo 'audio/basic=audacious.desktop' >> "$file"
		echo 'audio/flac=audacious.desktop' >> "$file"
		echo 'audio/midi=audacious.desktop' >> "$file"
		echo 'audio/mp4=audacious.desktop' >> "$file"
		echo 'audio/mpeg=audacious.desktop' >> "$file"
		echo 'audio/mpegurl=audacious.desktop' >> "$file"
		echo 'audio/ogg=audacious.desktop' >> "$file"
		echo 'audio/prs.sid=audacious.desktop' >> "$file"
		echo 'audio/vnd.rn-realaudio=audacious.desktop' >> "$file"
		echo 'audio/x-ape=audacious.desktop' >> "$file"
		echo 'audio/x-flac=audacious.desktop' >> "$file"
		echo 'audio/x-gsm=audacious.desktop' >> "$file"
		echo 'audio/x-it=audacious.desktop' >> "$file"
		echo 'audio/x-m4a=audacious.desktop' >> "$file"
		echo 'audio/x-matroska=audacious.desktop' >> "$file"
		echo 'audio/x-mod=audacious.desktop' >> "$file"
		echo 'audio/x-mp3=audacious.desktop' >> "$file"
		echo 'audio/x-mpeg=audacious.desktop' >> "$file"
		echo 'audio/x-mpegurl=audacious.desktop' >> "$file"
		echo 'audio/x-ms-asf=audacious.desktop' >> "$file"
		echo 'audio/x-ms-asx=audacious.desktop' >> "$file"
		echo 'audio/x-ms-wax=audacious.desktop' >> "$file"
		echo 'audio/x-ms-wma=audacious.desktop' >> "$file"
		echo 'audio/x-musepack=audacious.desktop' >> "$file"
		echo 'audio/x-pn-aiff=audacious.desktop' >> "$file"
		echo 'audio/x-pn-au=audacious.desktop' >> "$file"
		echo 'audio/x-pn-realaudio=audacious.desktop' >> "$file"
		echo 'audio/x-pn-realaudio-plugin=audacious.desktop' >> "$file"
		echo 'audio/x-pn-wav=audacious.desktop' >> "$file"
		echo 'audio/x-pn-windows-acm=audacious.desktop' >> "$file"
		echo 'audio/x-realaudio=audacious.desktop' >> "$file"
		echo 'audio/x-real-audio=audacious.desktop' >> "$file"
		echo 'audio/x-sbc=audacious.desktop' >> "$file"
		echo 'audio/x-scpls=audacious.desktop' >> "$file"
		echo 'audio/x-speex=audacious.desktop' >> "$file"
		echo 'audio/x-tta=audacious.desktop' >> "$file"
		echo 'audio/x-wav=audacious.desktop' >> "$file"
		echo 'audio/x-wavpack=audacious.desktop' >> "$file"
		echo 'audio/x-vorbis=audacious.desktop' >> "$file"
		echo 'audio/x-vorbis+ogg=audacious.desktop' >> "$file"
		echo 'audio/x-xm=audacious.desktop' >> "$file"
		echo 'x-content/audio-player=audacious.desktop' >> "$file"
	fi
	
	if bin_exists "wine"; then
		echo "Writing wine mimetypes"
		echo 'application/x-ms-dos-executable=wine.desktop' >> "$file"
	fi
	
	if bin_exists "code"; then
		echo "Writing code mimetypes"
		echo 'application/x-shellscript=code.desktop' >> "$file"
		echo 'application/xml=code.desktop' >> "$file"
		echo 'application/xhtml+xml=code.desktop' >> "$file"
		echo 'application/json=code.desktop' >> "$file"
		echo 'text/xml=code.desktop' >> "$file"
	fi
	
	if bin_exists "gedit"; then
		echo "Writing gedit mimetypes"
		echo 'text/plain=org.gnome.gedit.desktop' >> "$file"
	fi
	
	if bin_exists "gdebi"; then
		echo "Writing gdebi mimetypes"
		echo 'application/vnd.debian.binary-package=gdebi.desktop' >> "$file"
	fi
	
	if bin_exists "geary"; then
		echo "Writing geary mimetypes"
		echo 'x-scheme-handler/mailto=geary.desktop' >> "$file"
	fi
}

function config_flameshot () {
	mkdir -p "$HOME/.config/flameshot"
	sudo echo -e "[General]\ndisabledTrayIcon=true\nsaveAfterCopy=true\nshowHelp=false\nshowStartupLaunchMessage=false" > "$HOME/.config/flameshot/flameshot.ini"
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

function config_imwheel_start () {
	sudo echo -e "[Desktop Entry]\nName=imwheel\nIcon=imwheel\nExec=imwheel -d -b 45\nTerminal=false\nType=Application\nX-GNOME-Autostart-enabled=true" > "$HOME/.config/autostart/imwheel.desktop"
}

function config_telegram_start () {
	sudo echo -e "[Desktop Entry]\nName=telegram\nIcon=telegram\nExec=telegram-desktop -startintray\nTerminal=false\nType=Application\nX-GNOME-Autostart-enabled=true\nX-GNOME-Autostart-Delay=1" > "$HOME/.config/autostart/Telegram.desktop"
}

function config_discord_start () {
	sudo echo -e "[Desktop Entry]\nName=discord\nIcon=discord\nExec=discord --start-minimized\nTerminal=false\nType=Application\nX-GNOME-Autostart-enabled=true\nX-GNOME-Autostart-Delay=2" > "$HOME/.config/autostart/Discord.desktop"
}

function config_steam_start () {
	sudo echo -e "[Desktop Entry]\nName=steam\nIcon=steam\nExec=steam -silent\nTerminal=false\nType=Application\nX-GNOME-Autostart-enabled=true\nX-GNOME-Autostart-Delay=3" > "$HOME/.config/autostart/Steam-minimized.desktop"
}

function config_geary_start () {
	sudo echo -e "[Desktop Entry]\nName=geary\nIcon=geary\nExec=geary --gapplication-service\nTerminal=false\nType=Application\nX-GNOME-Autostart-enabled=true" > "$HOME/.config/autostart/Geary.desktop"
}

function config_enabled_ext () {
	if bin_exists "dconf"; then
		# Make sure user extensions are enabled
		dconf write /org/gnome/shell/disable-user-extensions false
		
		# Disable internal extensions
		gnome-extensions disable ubuntu-dock@ubuntu.com
		gnome-extensions disable workspace-indicator@gnome-shell-extensions.gcampax.github.com
		gnome-extensions disable windowsNavigator@gnome-shell-extensions.gcampax.github.com
		gnome-extensions disable window-list@gnome-shell-extensions.gcampax.github.com
		gnome-extensions disable ubuntu-appindicators@ubuntu.com
		gnome-extensions disable screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com
		gnome-extensions disable places-menu@gnome-shell-extensions.gcampax.github.com
		gnome-extensions disable native-window-placement@gnome-shell-extensions.gcampax.github.com
		gnome-extensions disable launch-new-instance@gnome-shell-extensions.gcampax.github.com
		gnome-extensions disable auto-move-windows@gnome-shell-extensions.gcampax.github.com
		gnome-extensions disable apps-menu@gnome-shell-extensions.gcampax.github.com
		
		# Enable our extensions
		gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
		gnome-extensions enable arcmenu@arcmenu.com
		gnome-extensions enable trayIconsReloaded@selfmade.pl
		gnome-extensions enable noannoyance@sindex.com
		gnome-extensions enable dash-to-panel@jderose9.github.com
		gnome-extensions enable clean-system-menu@astrapi.de
		gnome-extensions enable panel-date-format@keiii.github.com
		gnome-extensions enable volume-mixer@evermiss.net
		gnome-extensions enable impatience@gfxmonk.net
		gnome-extensions enable drive-menu@gnome-shell-extensions.gcampax.github.com
		gnome-extensions enable no-overview@fthx
		gnome-extensions enable blur-my-shell@aunetx
		gnome-extensions enable gnome-ui-tune@itstime.tech
		
		return 0
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME configuration"
		return 1
	fi
}

function configure_user_themes () {
	echo "FIX ME"
}

function _dconf_write () {
	echo "Writing $1 $2"
	dconf write "/org/gnome/shell/extensions/$1" "$2"
}

function configure_arcmenu () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME extension configuration"
		return 1
	fi
	
	_dconf_write arcmenu/alphabetize-all-programs true
	_dconf_write arcmenu/arc-menu-icon 69
	_dconf_write arcmenu/arc-menu-placement "'DTP'"
	_dconf_write arcmenu/available-placement "[false, true, false]"
	_dconf_write arcmenu/border-color "'rgba(255,255,255,0)'"
	_dconf_write arcmenu/button-padding 0
	#_dconf_write arcmenu/custom-hot-corner-cmd ""
	#_dconf_write arcmenu/custom-menu-button-icon "''"
	_dconf_write arcmenu/custom-menu-button-icon-size 23.0
	_dconf_write arcmenu/disable-category-arrows true
	_dconf_write arcmenu/disable-recently-installed-apps false
	_dconf_write arcmenu/disable-scrollview-fade-effect true
	_dconf_write arcmenu/disable-searchbox-border true
	_dconf_write arcmenu/disable-tooltips true
	_dconf_write arcmenu/distro-icon 0
	_dconf_write arcmenu/enable-custom-arc-menu true
	_dconf_write arcmenu/enable-horizontal-flip true
	_dconf_write arcmenu/enable-large-icons true
	_dconf_write arcmenu/enable-menu-button-arrow false
	_dconf_write arcmenu/enable-sub-menus false
	_dconf_write arcmenu/extra-categories "[(3, true), (0, false), (1, true), (2, false), (4, false)]"
	_dconf_write arcmenu/force-menu-location "'Off'"
	_dconf_write arcmenu/gap-adjustment -1
	_dconf_write arcmenu/highlight-color "'rgba(255,255,255,0.0633333)'"
	_dconf_write arcmenu/highlight-foreground-color "'rgb(246,245,244)'"
	_dconf_write arcmenu/hot-corners "'Default'"
	_dconf_write arcmenu/indicator-color "'rgb(41, 165, 249)'"
	_dconf_write arcmenu/indicator-text-color "'rgba(196, 196, 196, 0.3)'"
	_dconf_write arcmenu/menu-arrow-size 0
	_dconf_write arcmenu/menu-border-size 1
	_dconf_write arcmenu/menu-button-active-backgroundcolor "'rgba(255,18,18,0.18)'"
	_dconf_write arcmenu/menu-button-border-radius 0
	_dconf_write arcmenu/menu-button-color "'rgb(145,65,172)'"
	_dconf_write arcmenu/menu-button-hover-backgroundcolor "'rgba(255,255,255,0.08)'"
	_dconf_write arcmenu/menu-button-hover-color "'rgb(153,193,241)'"
	_dconf_write arcmenu/menu-button-icon "'Custom_Icon'"
	_dconf_write arcmenu/menu-button-override-border-radius true
	_dconf_write arcmenu/menu-color "'rgba(255,255,255,0)'"
	_dconf_write arcmenu/menu-corner-radius 0
	_dconf_write arcmenu/menu-font-size 10
	_dconf_write arcmenu/menu-foreground-color "'rgb(246,245,244)'"
	_dconf_write arcmenu/menu-height 593
	_dconf_write arcmenu/menu-hotkey "'Undefined'"
	_dconf_write arcmenu/menu-layout "'Brisk'"
	_dconf_write arcmenu/menu-margin 0
	_dconf_write arcmenu/menu-width 366
	_dconf_write arcmenu/multi-lined-labels false
	_dconf_write arcmenu/override-hot-corners false
	_dconf_write arcmenu/override-menu-button-active-background-color false
	_dconf_write arcmenu/override-menu-button-active-color false
	_dconf_write arcmenu/override-menu-button-color false
	_dconf_write arcmenu/override-menu-button-hover-background-color false
	_dconf_write arcmenu/override-menu-button-hover-color false
	_dconf_write arcmenu/pinned-app-list "['System Monitor', '', 'gnome-system-monitor.desktop', 'Terminal', '', 'org.gnome.Terminal.desktop', 'Bitwarden', '', 'com.bitwarden.desktop.desktop', 'Mail', '', 'org.gnome.Geary.desktop', 'Steam', '', 'steam.desktop', 'Spotify', '', 'spotify.desktop', 'Lollypop', '', 'org.gnome.Lollypop.desktop', 'Audacious', '', 'audacious.desktop', 'Telegram', '', 'telegramdesktop.desktop', 'Discord', '', 'discord.desktop', 'Blender', '', 'org.blender.Blender.desktop', 'Krita', '', 'org.kde.krita.desktop', 'Kdenlive', '', 'org.kde.kdenlive.desktop', 'OBS', '', 'com.obsproject.Studio.desktop', 'VSCode', '', 'code.desktop']"
	_dconf_write arcmenu/position-in-panel "'Left'"
	_dconf_write arcmenu/power-options "[(0, true), (1, true), (4, true), (2, true), (3, true), (5, false), (6, false)]"
	_dconf_write arcmenu/prefs-visible-page 0
	#_dconf_write arcmenu/recently-installed-apps "[]"
	_dconf_write arcmenu/remove-menu-arrow false
	_dconf_write arcmenu/right-panel-width 200
	_dconf_write arcmenu/search-provider-open-windows true
	_dconf_write arcmenu/searchbar-default-top-location "'Top'"
	_dconf_write arcmenu/separator-color "'rgba(255,255,255,0.0666667)'"
	_dconf_write arcmenu/show-search-result-details true
	_dconf_write arcmenu/vert-separator true
	_dconf_write arcmenu/windows-disable-frequent-apps true
	_dconf_write arcmenu/windows-disable-pinned-apps false
	
	_dconf_write arcmenu/reload-theme true
}

function configure_tray_icons_reloaded () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME extension configuration"
		return 1
	fi
	
	_dconf_write trayIconsReloaded/icon-brightness=-20
	_dconf_write trayIconsReloaded/icon-contrast=0
	_dconf_write trayIconsReloaded/icon-margin-horizontal=0
	_dconf_write trayIconsReloaded/icon-margin-vertical=0
	_dconf_write trayIconsReloaded/icon-padding-horizontal=5
	_dconf_write trayIconsReloaded/icon-padding-vertical=0
	_dconf_write trayIconsReloaded/icon-saturation=0
	_dconf_write trayIconsReloaded/icon-size=18
	_dconf_write trayIconsReloaded/icons-limit=16
	_dconf_write trayIconsReloaded/position-weight=20
	_dconf_write trayIconsReloaded/tray-margin-left=0
	_dconf_write trayIconsReloaded/tray-margin-right=0
	_dconf_write trayIconsReloaded/tray-position='right'
}

function configure_no_annoyance () {
	echo "FIX ME"
}

function configure_dash_to_panel () {
	echo "FIX ME"
}

function configure_clean_system_menu () {
	echo "FIX ME"
}

function configure_panel_date_format () {
	echo "FIX ME"
}

function configure_application_volume_mixer () {
	echo "FIX ME"
}

function configure_impatience () {
	echo "FIX ME"
}

function configure_no_overview () {
	echo "FIX ME"
}

function configure_game_mode_status_icon () {
	echo "FIX ME"
}

function configure_blur_my_shell () {
	echo "FIX ME"
}

function configure_gnome_4x_ui_improvements () {
	echo "FIX ME"
}
