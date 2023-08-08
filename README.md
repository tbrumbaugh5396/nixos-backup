# nixos-backup

Currently, I am running NixOS.
I am interested in understanding exactly all of the different things I am running.

# Desktop Environment
The desktop environment I am currently running is services.xserver.desktopManager.xfce.enable = true;
This is xfce.
This program runs the desktop GUI experience.
The desktop is also responsable for the Hotkeys that are available.

# View which key
In linux, you can run the showkey command.

# Hotkeys
The hotkeys for xfce are available by going to the following tabs: [Applications] >> [Settings] >> [Keyboard] >> [Application Shortcuts]
I have added the shortcut to get to this page: Ctrl + K

I believe that these shortcuts are saved in:
- /home/username/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

There are more here: https://linuxhint.com/100_keyboard_shortcuts_linux/

# Macros


# Cool Tools for Shortcuts, Hotkeys, Macros, and Recording Tools
You can bind hotkeys to scripts.
Create GUI buttons to make what you are doing easier.
Use recording tools to recreate exactly what you've been doing.

From https://www.reddit.com/r/linux/comments/s625z4/macros_in_linux_keyboard_macros_and_otherwise/
-I just write bash scripts and then add a bash alias to my bashcr file. Mischief managed
-I use autokey                                        https://github.com/autokey/autokey

Here is a webpage for more:
- https://alternativeto.net/software/jitbit-macro-recorder/?platform=linux

Macros for linux:
- https://github.com/jordansissel/xdotool

I think this is Macros for Windows:
- https://www.autohotkey.com/

This looks like a Nix Specific key manager:
- https://nixos.wiki/wiki/Actkbd

# Additional
I think this tool is for programming your keyboard and mouse with custom macros.
https://github.com/tolga9009/sidewinderd

# NixOps
NixOps is a tool for deploying Nix to remote machines: https://github.com/NixOS/nixops

# NPM
How can you install and use npm packages using NixOS? 

## What are npm global packages and how can I use them in Nix?
npm stores the globally installed package in the node_modules folder. 
The global packages are all stored in a single place in your system depending on the setup of your operating system, irrespective of where you run npm install -g <package-name>.

## How to use global packages in Nix
There are multiple ways to use npm packages through nix:

### Process to get around npm packages in Nix
For my personal projects, I use nix-shell then within the shell I use npm scripts to prevent the need for npm global packages (like with gulp). The process looks something like this (and is probably very similar for yarn):

$ nix-shell -p nodejs-8_x
[nix-shell:yourproject]$ npm install # installs npm deps to project-local node_modules
[nix-shell:yourproject]$ npm exec (...) # using scripts configured in package.json

This works well for me since none of my packages have binary dependencies. This post describes the creation of a default.nix for your project so you won't have to specify dependencies for every invocation of nix-shell, but it's optional.

Another way is using npm2nix:
node2nix -i node-packages.json # creates ./default.nix
nix-shell # nix-shell will look for a default.nix, which above will have generated

Which will cause Nix to manage all npm packages in the project.

It may be a good idea to become familiar with nix-shell, since trying to install node packages / any dependency in your nix profile (through nix-env or nox) defeats the purpose of nix by polluting the "global" namespace.


# Nix Home Manager
https://discourse.nixos.org/t/adding-folders-and-scripts/5114

https://www.reddit.com/r/NixOS/comments/9bb9h9/post_your_homemanager_homenix_file/

https://nixos.wiki/wiki/Home_Manager
