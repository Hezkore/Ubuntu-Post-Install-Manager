# Ubuntu Post-Install Manager
A simple script that helps you get started with Ubuntu and GNOME.

**Make sure to read everything below!**

![demo](https://github.com/Hezkore/Ubuntu-Post-Install-Manager/blob/master/extra/demo.png?raw=true)

## Requirements
### • X11 session
Ubuntu starts a Wayland session by default, *which is not supported*.\
If you don't know what this means, then just log out, click your user and click the cog in the lower right corner.\
Make sure **"Ubuntu on Xorg"** is selected and login as usual.\
![xorg](https://github.com/Hezkore/Ubuntu-Post-Install-Manager/blob/master/extra/xorg.jpg?raw=true)\
Wayland is the future for Linux and you may still use it.\
But some software - like IMWheel - does not work correctly in a Wayland session.

### • 20GB disk
Ubuntu takes up almost 10GB on a fresh install, and has a tendency to balloon up to 17GB.\
Make sure Ubuntu is installed to a disk greater than 20GB.\
That way the script has some space to work with.

### • 1024x768 resolution
Ubuntu doesn't work too well on resolutions lower than 1024x768.\
The ArcMenu GNOME extension also needs at least a height of 642 pixels, which is why no menu is displayed on 800x600.

## How to install & run
Download the script by clicking the green **"Code ▼"** button here on GitHub, then click **"[Download Zip](https://github.com/Hezkore/Ubuntu-Post-Install-Manager/archive/refs/heads/master.zip)"** and save the file.\
The file - named **"Ubuntu-Post-Install-Manager-master.zip"** - will most likely save to **"/home/[user]/Downloads/"**.\
Unpack the script by right clicking **"Ubuntu-Post-Install-Manager-master.zip"**  and selecting **"Extract Here"**, which creates the folder **"Ubuntu-Post-Install-Manager-master"**.\
Right click the **"Ubuntu-Post-Install-Manager-master"** folder and select **"Open in Terminal"**.\
In the newly opened terminal, type `./ubuntu_pim.sh` and press Enter to run the script.\
*(Pro tip: you can press **TAB** after you've written `./u` to autocomplete the remaining part of the command)*

## Navigation & usage
Press the Up and Down arrow keys to move your selection up and down.\
Press TAB to move your selection between the lower two menu buttons.\
Press Enter to confirm your selection.\
Press Space to toggle a option on or off in the customize menu.

## Notice
You can run the script right after you've installed Ubuntu, or after you've updated Ubuntu and your drivers.\
Most efficient might be right after install, as the script will update Ubuntu and your drivers on its own.

I recommend doing all the steps in order, unless you know what you're doing.\
The default options in each customization menu are the recommended options, which means you can simply press Enter to confirm.

When asked to enter your password in the terminal; you won't be able to see the password as you type.\
This is a security feature in Linux.

When installing the recommended software, you will be asked to enter your password in a popup screen twice.\
I recommend you stay by the computer until you've gotten past those two password popups.\
*(Removing Snap and installing Flatpak creates a password request popup)*

If the machine is not made for gaming, messaging or email, then I recommend you *NOT* check these options:
* Step **"5. Configuration"**
	* Uncheck "Configure Geary to check for incoming email"
	* Uncheck "Configure Telegram to run at start"
	* Uncheck "Configure Discord to run at start"
	* Uncheck "Configure Steam to run at start"

*(You can also disable these later by running the application **"Startup Applications"**)*

If the machine is made for gaming, then I recommend reading the [Gaming](#gaming) section for some useful tips and guides.

If Steam, Discord, Telegram or Geary is set to run at start; a login screen will automatically appear for each application when you log in.\
They will stop appearing once you've signed in to the application.

If Steam does not start minimized after you've signed in; it means you've got **"Run Steam when my computer starts"** enabled in your Steam settings.\
This is not the script, but rather how Steam normally works.\
To fix this; disable **"Run Steam when my computer starts"** in Steam settings.\
You can run the script and check **"Configure Steam to run at start"** in step **"5. Configuration"** to have Steam start minimized at start.

If you're new to the GNOME file browser *(aka. Nautilus)* you'll quickly notice that clicking the current directory path at the top does nothing, you instead need to press **CTRL + L** to edit it.\
*(Good for copying or pasting paths)*

The **"*Windows* key"**  is usually called the **"*Super* key"** in Linux.

Hold **Super** then click and hold your **left mouse button** to drag a window around without having to grab the window's title bar.\
Hold **Super** then click and hold the **right mouse button** to to resize a window without having to grab the window's edge.\
*(Learn to use this!)*

* Other keyboard Shortcuts
	* Flameshot capture screenshot area
		* **Shift + F1**
	* Open Nautilus *(files)*
		* **Super + E**
	* Open Terminal
		* **Super + T**
		* **Ctr + Alt + T**
	* Open System Monitor
		* **Ctrl + Alt + Delete**
		* **Ctrl + Shift + Escape**

## Gaming
To enable Linux support for all Steam games (via Proton):
* Steam >
	* Settings >
		* Steam Play >
			* "Enable Steam Play for supported titles"
			* "Enable Steam Play for all other titles"
		* Shader Pre-Caching
			* "Enable Shader Pre-Caching"
			* "Allow background processing of Vulkan shaders"
		* (recommended)
			* Interface >
				* Change "Select which Steam window appears when the program starst." to "Library"
				* Disable "Run Steam when my computer starts" (see [Notes](#notes) for more info)
				* Disable "Notify me about additions or changes to my games, new releases, and upcoming releases."
			* Library >
				* "Low Bandwidth Mode"
				* "Low Performance Mode"

Visit [ProtonDB](https://www.protondb.com/) to find out if your favorite games runs on Linux.

Adding a non-Steam game to Steam lets you use Proton with local games, you can also use Lutris for gaming.

You can enable Game Mode in Steam by right clicking any game > Properties ... > Launch Options > Write `gamemoderun %command%`.\
I have not noticed any performance increase using Game Mode.

Use GOverlay to enable in-game a FPS counter, effects and many other things.\
Start the application **"GOverlay"** and check **"Global Enable"** in the MangoHud tab, and make sure the **"Hide"** checkbox is checked in the **"Visual"** section.\
Don't forget to click **"Save"** at the bottom of the window and restart!\
Then just press **Right Shift + F12** in-game to toggle MangoHud.\
Any effects you've added via vkBasalt can be toggled by pressing the **Home** key.