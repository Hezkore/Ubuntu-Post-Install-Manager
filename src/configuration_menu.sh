#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_configuration_menu () {
	items=(
		"Config_Git" "Configure Git username and email" "OFF"
		"Config_Mimeapps" "Configure and reset file type associations" "ON"
		"Config_Flameshot" "Configure Flameshot to stay in the background" "ON"
		"Config_IMWheel" "Configure IMWheel scroll wheel speed" "ON"
		"Config_IMWheel_Start" "Configure IMWheel to run at start" "ON"
		"Config_Telegram_Start" "Configure Telegram to run at start" "ON"
		"Config_Discord_Start" "Configure Discord to run at start" "ON"
		"Config_Steam_Start" "Configure Steam to run at start" "ON"
		"Config_Geary_Start" "Configure Geary to check for incoming email" "ON"
		"Config_Geary_Settings" "Configure Geary settings" "ON"
		"Config_Lollypop_Window" "Configure Lollypop window size" "ON"
		
		# GNOME itself
		"Config_GNOME_Mouse" "Configure GNOME mouse to have zero acceleration" "ON"
		"Config_GNOME_Middle_Paste" "Configure GNOME no middle mouse button paste" "ON"
		"Config_GNOME_Weekdate" "Configure GNOME calendar to show week numbers" "ON"
		"Config_GNOME_ResizeRight" "Configure GNOME to resize with right mouse button" "ON"
		"Config_GNOME_NoMaximize" "Configure GNOME to never auto maximize windows" "ON"
		"Config_GNOME_Center" "Configure GNOME to place windows in the center" "ON"
		"Config_GNOME_NoAttach" "Configure GNOME to not attach modal dialogs" "ON"
		"Config_GNOME_FileChooser" "Configure GNOME file chooser settings" "ON"
		"Config_GNOME_Favorites" "Configure GNOME favorite apps" "ON"
		
		# GNOME keyboard shortcuts
		"Config_GNOME_Shortcuts" "Configure GNOME keyboard shortcuts" "ON"
		
		# GNOME extensions
		"Config_Enabled_Ext" "Enable user extensions and disable built-in" "ON"
		"Configure_Ding" "Configure DING GNOME Extension" "ON"
		"Configure_ArcMenu" "Configure ArcMenu GNOME Extension" "ON"
		"Configure_Tray_Icons_Reloaded" "Configure Tray Icons Reloaded GNOME Extension" "ON"
		"Configure_Dash_to_Panel" "Configure Dash-to-Panel GNOME Extension" "ON"
		"Configure_Clean_System_Menu" "Configure Clean System Menu GNOME Extension" "ON"
		"Configure_Panel_Date_Format" "Configure Panel Date Format GNOME Extension" "ON"
		"Configure_Impatience" "Configure Impatience GNOME Extension" "ON"
		"Configure_Game_Mode_Status_Icon" "Configure GameMode Status Icon GNOME Extension" "ON"
		"Configure_Blur_My_Shell" "Configure Blur My Shell GNOME Extension" "ON"
		"Configure_GNOME_UI_Improvements" "Configure UI Improvements GNOME Extension" "ON"
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
	NEEDS_LOGOUT=true
}

function config_imwheel () {
	if bin_exists "wget"; then
		sudo mkdir -p /etc/X11/imwheel
		wget -O imwheelrc https://raw.githubusercontent.com/Hezkore/Ubuntu-Post-Install-Manager/master/extra/imwheelrc
		sudo mv imwheelrc /etc/X11/imwheel/
		NEEDS_LOGOUT=true
		return 0
	else
		LAST_ERROR="WGet is not installed, cannot download configuration"
		return 1
	fi
}

function config_imwheel_start () {
	echo "Creating autostart desktop entry..."
	sudo echo -e "[Desktop Entry]\nName=IMWheel\nIcon=imwheel\nExec=imwheel -d -b 45\nTerminal=false\nType=Application\nX-GNOME-Autostart-enabled=true" > "$HOME/.config/autostart/imwheel.desktop"
	NEEDS_LOGOUT=true
}

function config_telegram_start () {
	echo "Creating autostart desktop entry..."
	sudo echo -e "[Desktop Entry]\nName=Telegram\nIcon=telegram\nExec=telegram-desktop -startintray\nTerminal=false\nType=Application\nX-GNOME-Autostart-enabled=true\nX-GNOME-Autostart-Delay=1" > "$HOME/.config/autostart/Telegram.desktop"
	NEEDS_LOGOUT=true
}

function config_discord_start () {
	echo "Creating autostart desktop entry..."
	sudo echo -e "[Desktop Entry]\nName=Discord\nIcon=discord\nExec=discord --start-minimized\nTerminal=false\nType=Application\nX-GNOME-Autostart-enabled=true\nX-GNOME-Autostart-Delay=2" > "$HOME/.config/autostart/Discord.desktop"
	NEEDS_LOGOUT=true
}

function config_steam_start () {
	echo "Creating autostart desktop entry..."
	sudo echo -e "[Desktop Entry]\nName=Steam\nIcon=steam\nExec=steam -silent\nTerminal=false\nType=Application\nX-GNOME-Autostart-enabled=true\nX-GNOME-Autostart-Delay=3" > "$HOME/.config/autostart/Steam-minimized.desktop"
	NEEDS_LOGOUT=true
}

function config_geary_start () {
	echo "Creating autostart desktop entry..."
	sudo echo -e "[Desktop Entry]\nName=Geary\nIcon=geary\nExec=geary --gapplication-service\nTerminal=false\nType=Application\nX-GNOME-Autostart-enabled=true" > "$HOME/.config/autostart/Geary.desktop"
	NEEDS_LOGOUT=true
}

function config_geary_settings () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME application configuration"
		return 1
	fi
	
	dconf write /org/gnome/Geary/startup-notifications true
	dconf write /org/gnome/Geary/optional-plugins "['sent-sound']"
}

function config_lollypop_window () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME application configuration"
		return 1
	fi
	
	dconf write /org/gnome/Lollypop/window-size "[1280, 720]"
}

function config_gnome_mouse () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME configuration"
		return 1
	fi
	
	dconf write /org/gnome/desktop/peripherals/mouse/accel-profile "'flat'"
	dconf write /org/gnome/desktop/peripherals/mouse/speed -0.1
}

function config_gnome_middle_paste () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME configuration"
		return 1
	fi
	
	dconf write /org/gnome/desktop/interface/gtk-enable-primary-paste false
}

function config_gnome_weekdate () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME configuration"
		return 1
	fi
	
	dconf write /org/gnome/desktop/calendar/show-weekdate true
}

function config_gnome_resizeright () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME configuration"
		return 1
	fi
	
	dconf write /org/gnome/desktop/wm/preferences/resize-with-right-button true
}

function config_gnome_nomaximize () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME configuration"
		return 1
	fi
	
	dconf write /org/gnome/mutter/auto-maximize false
}

function config_gnome_center () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME configuration"
		return 1
	fi
	
	dconf write /org/gnome/mutter/center-new-windows true
}

function config_gnome_noattach () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME configuration"
		return 1
	fi
	
	dconf write /org/gnome/mutter/attach-modal-dialogs false
	dconf write /org/gnome/shell/overrides/attach-modal-dialogs false
}

function config_gnome_filechooser () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME configuration"
		return 1
	fi
	
	dconf write /org/gtk/settings/file-chooser/show-hidden false
	dconf write /org/gtk/settings/file-chooser/sort-directories-first true
	
	# Not really related, but still recommended
	dconf write /org/gnome/nautilus/preferences/show-create-link true
	dconf write /org/gnome/nautilus/preferences/default-folder-viewer "'icon-view'"
	dconf write /org/gnome/nautilus/icon-view/default-zoom-level "'small'"
}

function config_gnome_favorites () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME configuration"
		return 1
	fi
	
	dconf write /org/gnome/shell/favorite-apps "['org.gnome.Nautilus.desktop', 'microsoft-edge.desktop']"
}

function config_gnome_shortcuts () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME keyboard shortcuts"
		return 1
	fi
	
	# Flameshot screenshot via Shift F1
	echo "Flamshot screenshot - Shift F1"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Shift>F1'"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'flameshot gui'"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'Capture area'"
	
	# Open Nautilus via Super E
	echo "Nautilus - Super E"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/binding "'<Super>E'"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/command "'nautilus -w'"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/name "'Open file browser'"
	
	# Open Terminal via Super T
	echo "Terminal - Super T"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/binding "'<Super>T'"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/command "'gnome-terminal'"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/name "'Open terminal'"
	
	# Disable Ctrl Alt Delete as Log out
	echo "Disable Log out"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/logout "@as []"
	
	# Open system monitor via Cltr Shift Escape AND Ctrl Alt Dlete
	echo "System Monitor - Ctrl Shift Escape & Ctrl Alt Delete"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/binding "'<Primary><Shift>Escape'"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/command "'gnome-system-monitor'"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/name "'Open system monitor'"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/binding "'<Primary><Alt>Delete'"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/command "'gnome-system-monitor'"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/name "'Open system monitor ALT'"
	
	# Apply
	echo "Adding shortcuts"
	dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/']"
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
		gnome-extensions enable gamemode@christian.kellner.me
		
		# A restart here might not be required, but just to be safe...
		NEEDS_LOGOUT=true
		
		return 0
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME configuration"
		return 1
	fi
}

# Used internally
function _dconf_write_ext () {
	echo "Writing $1 $2"
	dconf write "/org/gnome/shell/extensions/$1" "$2"
}

function configure_ding () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME extension configuration"
		return 1
	fi
	
	_dconf_write_ext ding/icon-size "'large'"
	_dconf_write_ext ding/show-home false
	_dconf_write_ext ding/show-volumes true
}

function configure_arcmenu () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME extension configuration"
		return 1
	fi
	
	_dconf_write_ext arcmenu/alphabetize-all-programs true
	_dconf_write_ext arcmenu/arc-menu-icon 5
	_dconf_write_ext arcmenu/arc-menu-placement "'DTP'"
	_dconf_write_ext arcmenu/available-placement "[false, true, false]"
	_dconf_write_ext arcmenu/border-color "'rgba(255,255,255,0)'"
	_dconf_write_ext arcmenu/button-padding 0
	#_dconf_write_ext arcmenu/custom-hot-corner-cmd ""
	_dconf_write_ext arcmenu/custom-menu-button-icon "'Distro_Icon'"
	_dconf_write_ext arcmenu/custom-menu-button-icon-size 23.0
	_dconf_write_ext arcmenu/disable-category-arrows true
	_dconf_write_ext arcmenu/disable-recently-installed-apps false
	_dconf_write_ext arcmenu/disable-scrollview-fade-effect true
	_dconf_write_ext arcmenu/disable-searchbox-border true
	_dconf_write_ext arcmenu/disable-tooltips true
	_dconf_write_ext arcmenu/distro-icon 5
	_dconf_write_ext arcmenu/enable-custom-arc-menu true
	_dconf_write_ext arcmenu/enable-horizontal-flip true
	_dconf_write_ext arcmenu/enable-large-icons true
	_dconf_write_ext arcmenu/enable-menu-button-arrow false
	_dconf_write_ext arcmenu/enable-sub-menus false
	_dconf_write_ext arcmenu/extra-categories "[(3, true), (0, false), (1, true), (2, false), (4, false)]"
	_dconf_write_ext arcmenu/force-menu-location "'Off'"
	_dconf_write_ext arcmenu/gap-adjustment -1
	_dconf_write_ext arcmenu/highlight-color "'rgba(255,255,255,0.0633333)'"
	_dconf_write_ext arcmenu/highlight-foreground-color "'rgb(246,245,244)'"
	_dconf_write_ext arcmenu/hot-corners "'Default'"
	_dconf_write_ext arcmenu/indicator-color "'rgb(41, 165, 249)'"
	_dconf_write_ext arcmenu/indicator-text-color "'rgba(196, 196, 196, 0.3)'"
	_dconf_write_ext arcmenu/menu-arrow-size 0
	_dconf_write_ext arcmenu/menu-border-size 0
	_dconf_write_ext arcmenu/menu-button-active-backgroundcolor "'rgba(255,18,18,0.18)'"
	_dconf_write_ext arcmenu/menu-button-border-radius 0
	_dconf_write_ext arcmenu/menu-button-color "'rgb(145,65,172)'"
	_dconf_write_ext arcmenu/menu-button-hover-backgroundcolor "'rgba(255,255,255,0.08)'"
	_dconf_write_ext arcmenu/menu-button-hover-color "'rgb(153,193,241)'"
	_dconf_write_ext arcmenu/menu-button-icon "'Custom_Icon'"
	_dconf_write_ext arcmenu/menu-button-override-border-radius true
	_dconf_write_ext arcmenu/menu-color "'rgba(32,32,32,0.98)'"
	_dconf_write_ext arcmenu/menu-corner-radius 0
	_dconf_write_ext arcmenu/menu-font-size 10
	_dconf_write_ext arcmenu/menu-foreground-color "'rgb(246,245,244)'"
	_dconf_write_ext arcmenu/menu-height 593
	_dconf_write_ext arcmenu/menu-hotkey "'Undefined'"
	_dconf_write_ext arcmenu/menu-layout "'Brisk'"
	_dconf_write_ext arcmenu/menu-margin 0
	_dconf_write_ext arcmenu/menu-width 366
	_dconf_write_ext arcmenu/multi-lined-labels false
	_dconf_write_ext arcmenu/override-hot-corners false
	_dconf_write_ext arcmenu/override-menu-button-active-background-color false
	_dconf_write_ext arcmenu/override-menu-button-active-color false
	_dconf_write_ext arcmenu/override-menu-button-color false
	_dconf_write_ext arcmenu/override-menu-button-hover-background-color false
	_dconf_write_ext arcmenu/override-menu-button-hover-color false
	_dconf_write_ext arcmenu/position-in-panel "'Left'"
	_dconf_write_ext arcmenu/power-options "[(0, true), (1, true), (4, true), (2, true), (3, true), (5, false), (6, false)]"
	_dconf_write_ext arcmenu/prefs-visible-page 0
	#_dconf_write_ext arcmenu/recently-installed-apps "[]"
	_dconf_write_ext arcmenu/remove-menu-arrow false
	_dconf_write_ext arcmenu/right-panel-width 200
	_dconf_write_ext arcmenu/search-provider-open-windows true
	_dconf_write_ext arcmenu/searchbar-default-top-location "'Top'"
	_dconf_write_ext arcmenu/separator-color "'rgba(255,255,255,0.0666667)'"
	_dconf_write_ext arcmenu/show-search-result-details true
	_dconf_write_ext arcmenu/vert-separator true
	_dconf_write_ext arcmenu/windows-disable-frequent-apps true
	_dconf_write_ext arcmenu/windows-disable-pinned-apps false
	
	# Add pinned app based on what's installed
	# TODO
	_dconf_write_ext arcmenu/pinned-app-list "['System Monitor', '', 'gnome-system-monitor.desktop', 'Terminal', '', 'org.gnome.Terminal.desktop', 'Bitwarden', '', 'com.bitwarden.desktop.desktop', 'Mail', '', 'org.gnome.Geary.desktop', 'Steam', '', 'steam.desktop', 'Spotify', '', 'spotify.desktop', 'Lollypop', '', 'org.gnome.Lollypop.desktop', 'Audacious', '', 'audacious.desktop', 'Telegram', '', 'telegramdesktop.desktop', 'Discord', '', 'discord.desktop', 'Blender', '', 'org.blender.Blender.desktop', 'Krita', '', 'org.kde.krita.desktop', 'Kdenlive', '', 'org.kde.kdenlive.desktop', 'OBS', '', 'com.obsproject.Studio.desktop', 'VSCode', '', 'code.desktop']"
	
	# This is required for ArcMenu to update
	_dconf_write_ext arcmenu/reload-theme true
}

function configure_tray_icons_reloaded () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME extension configuration"
		return 1
	fi
	
	_dconf_write_ext trayIconsReloaded/icon-margin-horizontal 0
	_dconf_write_ext trayIconsReloaded/icon-margin-vertical 0
	_dconf_write_ext trayIconsReloaded/icon-padding-horizontal 5
	_dconf_write_ext trayIconsReloaded/icon-padding-vertical 0
	_dconf_write_ext trayIconsReloaded/icon-size 18
	_dconf_write_ext trayIconsReloaded/icons-limit 16
	_dconf_write_ext trayIconsReloaded/position-weight 20
	_dconf_write_ext trayIconsReloaded/tray-margin-left 0
	_dconf_write_ext trayIconsReloaded/tray-margin-right 0
	_dconf_write_ext trayIconsReloaded/tray-position "'right'"
	
	# Let the user adjust these
	#_dconf_write_ext trayIconsReloaded/icon-brightness -20
	#_dconf_write_ext trayIconsReloaded/icon-contrast 0
	#_dconf_write_ext trayIconsReloaded/icon-saturation 0
}

function configure_dash_to_panel () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME extension configuration"
		return 1
	fi
	
	_dconf_write_ext dash-to-panel/animate-appicon-hover false
	_dconf_write_ext dash-to-panel/animate-appicon-hover-animation-convexity "{'RIPPLE': 2.0, 'PLANK': 1.0, 'SIMPLE': 0.0}"
	_dconf_write_ext dash-to-panel/animate-appicon-hover-animation-duration "{'SIMPLE': uint32 160, 'RIPPLE': 130, 'PLANK': 100}"
	_dconf_write_ext dash-to-panel/animate-appicon-hover-animation-extent "{'RIPPLE': 4, 'PLANK': 4, 'SIMPLE': 1}"
	_dconf_write_ext dash-to-panel/animate-appicon-hover-animation-travel "{'SIMPLE': 0.040000000000000001, 'RIPPLE': 0.40000000000000002, 'PLANK': 0.0}"
	_dconf_write_ext dash-to-panel/animate-appicon-hover-animation-type "'SIMPLE'"
	_dconf_write_ext dash-to-panel/animate-appicon-hover-animation-zoom "{'SIMPLE': 1.1000000000000001, 'RIPPLE': 1.25, 'PLANK': 2.0}"
	_dconf_write_ext dash-to-panel/appicon-margin 0
	_dconf_write_ext dash-to-panel/appicon-padding 12
	_dconf_write_ext dash-to-panel/available-monitors "[0]"
	_dconf_write_ext dash-to-panel/click-action "'TOGGLE-SHOWPREVIEW'"
	_dconf_write_ext dash-to-panel/desktop-line-custom-color "'rgba(0,0,0,0.0)'"
	_dconf_write_ext dash-to-panel/desktop-line-use-custom-color true
	_dconf_write_ext dash-to-panel/dot-color-1 "'#529cd5'"
	_dconf_write_ext dash-to-panel/dot-color-2 "'#529cd5'"
	_dconf_write_ext dash-to-panel/dot-color-3 "'#529cd5'"
	_dconf_write_ext dash-to-panel/dot-color-4 "'#529cd5'"
	_dconf_write_ext dash-to-panel/dot-color-dominant true
	_dconf_write_ext dash-to-panel/dot-color-override false
	_dconf_write_ext dash-to-panel/dot-color-unfocused-1 "'#9a9996'"
	_dconf_write_ext dash-to-panel/dot-color-unfocused-2 "'#9a9996'"
	_dconf_write_ext dash-to-panel/dot-color-unfocused-3 "'#9a9996'"
	_dconf_write_ext dash-to-panel/dot-color-unfocused-4 "'#9a9996'"
	_dconf_write_ext dash-to-panel/dot-color-unfocused-different true
	_dconf_write_ext dash-to-panel/dot-position "'BOTTOM'"
	_dconf_write_ext dash-to-panel/dot-size 3
	_dconf_write_ext dash-to-panel/dot-style-focused "'SEGMENTED'"
	_dconf_write_ext dash-to-panel/dot-style-unfocused "'DOTS'"
	_dconf_write_ext dash-to-panel/focus-highlight true
	_dconf_write_ext dash-to-panel/focus-highlight-color "'#ffffff'"
	_dconf_write_ext dash-to-panel/focus-highlight-dominant true
	_dconf_write_ext dash-to-panel/focus-highlight-opacity 5
	_dconf_write_ext dash-to-panel/group-apps true
	_dconf_write_ext dash-to-panel/hide-overview-on-startup false
	_dconf_write_ext dash-to-panel/hotkeys-overlay-combo "'TEMPORARILY'"
	_dconf_write_ext dash-to-panel/leftbox-padding 15
	_dconf_write_ext dash-to-panel/leftbox-size 0
	_dconf_write_ext dash-to-panel/multi-monitors false
	_dconf_write_ext dash-to-panel/overview-click-to-exit false
	_dconf_write_ext dash-to-panel/panel-anchors "'{\"0\":\"MIDDLE\"}'"
	_dconf_write_ext dash-to-panel/panel-element-positions "'{\"0\":[{\"element\":\"showAppsButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"activitiesButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"leftBox\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"taskbar\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"centerBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"rightBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"systemMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"dateMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"desktopButton\",\"visible\":true,\"position\":\"stackedBR\"}]}'"
	_dconf_write_ext dash-to-panel/panel-element-positions-monitors-sync true
	_dconf_write_ext dash-to-panel/panel-lengths "'{\"0\":100}'"
	_dconf_write_ext dash-to-panel/panel-sizes "'{\"0\":48}'"
	_dconf_write_ext dash-to-panel/primary-monitor 0
	_dconf_write_ext dash-to-panel/secondarymenu-contains-showdetails true
	_dconf_write_ext dash-to-panel/show-appmenu false
	_dconf_write_ext dash-to-panel/show-apps-icon-file "''"
	_dconf_write_ext dash-to-panel/show-favorites true
	_dconf_write_ext dash-to-panel/show-favorites-all-monitors true
	_dconf_write_ext dash-to-panel/show-running-apps true
	_dconf_write_ext dash-to-panel/show-showdesktop-hover true
	_dconf_write_ext dash-to-panel/show-showdesktop-time 500
	_dconf_write_ext dash-to-panel/show-tooltip false
	_dconf_write_ext dash-to-panel/showdesktop-button-width 8
	_dconf_write_ext dash-to-panel/status-icon-padding 6
	_dconf_write_ext dash-to-panel/stockgs-keep-top-panel false
	_dconf_write_ext dash-to-panel/stockgs-panelbtn-click-only true
	_dconf_write_ext dash-to-panel/trans-bg-color "'#ffffff'"
	_dconf_write_ext dash-to-panel/trans-dynamic-anim-target 1.0
	_dconf_write_ext dash-to-panel/trans-dynamic-behavior "'MAXIMIZED_WINDOWS'"
	_dconf_write_ext dash-to-panel/trans-gradient-bottom-color "'#ffffff'"
	_dconf_write_ext dash-to-panel/trans-gradient-bottom-opacity 0.0
	_dconf_write_ext dash-to-panel/trans-gradient-top-color "'#ffffff'"
	_dconf_write_ext dash-to-panel/trans-gradient-top-opacity 0.0
	_dconf_write_ext dash-to-panel/trans-panel-opacity 0.80000000000000004
	_dconf_write_ext dash-to-panel/trans-use-custom-bg false
	_dconf_write_ext dash-to-panel/trans-use-custom-gradient false
	_dconf_write_ext dash-to-panel/trans-use-custom-opacity true
	_dconf_write_ext dash-to-panel/trans-use-dynamic-opacity false
	_dconf_write_ext dash-to-panel/tray-padding 4
	_dconf_write_ext dash-to-panel/tray-size 0
	_dconf_write_ext dash-to-panel/window-preview-title-position "'TOP'"
}

function configure_clean_system_menu () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME extension configuration"
		return 1
	fi
	
	_dconf_write_ext clean-system-menu/power-button-position 1
	_dconf_write_ext clean-system-menu/power-button-positionnumber 0
	_dconf_write_ext clean-system-menu/power-button-visible false
}

function configure_panel_date_format () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME extension configuration"
		return 1
	fi
	
	_dconf_write_ext panel-date-format/format "'   %R\n%d-%m-%y'"
}

function configure_impatience () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
		# Odd place for an extension to store its settings
		dconf write /org/gnome/shell/extensions/net/gfxmonk/impatience/speed-factor 0.88409703504043125
		return 0
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME extension configuration"
		return 1
	fi
}

function configure_game_mode_status_icon () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME extension configuration"
		return 1
	fi
	
	_dconf_write_ext gamemode/active-color "'rgb(115,210,22)'"
	_dconf_write_ext gamemode/active-tint false
	_dconf_write_ext gamemode/always-show-icon false
	_dconf_write_ext gamemode/emit-notifications false
}

function configure_blur_my_shell () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME extension configuration"
		return 1
	fi
	
	_dconf_write_ext blur-my-shell/appfolder-dialog-opacity 0.0
	_dconf_write_ext blur-my-shell/blur-appfolders false
	_dconf_write_ext blur-my-shell/blur-dash false
	_dconf_write_ext blur-my-shell/blur-lockscreen false
	_dconf_write_ext blur-my-shell/blur-overview false
	_dconf_write_ext blur-my-shell/blur-panel true
	_dconf_write_ext blur-my-shell/blur-window-list false
	_dconf_write_ext blur-my-shell/brightness 1.0
	_dconf_write_ext blur-my-shell/dash-opacity 0.0
	_dconf_write_ext blur-my-shell/debug false
	_dconf_write_ext blur-my-shell/hacks-level 0
	_dconf_write_ext blur-my-shell/hidetopbar false
	_dconf_write_ext blur-my-shell/sigma 55
	_dconf_write_ext blur-my-shell/static-blur true
	
	# Might not be required, but again, just to be safe
	NEEDS_LOGOUT=true
}

function configure_gnome_ui_improvements () {
	if bin_exists "dconf"; then
		echo "Applying configuration..."
	else
		LAST_ERROR="dconf is not installed, cannot change GNOME extension configuration"
		return 1
	fi
	
	_dconf_write_ext gnome-ui-tune/always-show-thumbnails true
	_dconf_write_ext gnome-ui-tune/increase-thumbnails-size true
	_dconf_write_ext gnome-ui-tune/overview-firefox-pip false
	_dconf_write_ext gnome-ui-tune/restore-thumbnails-background true
}
