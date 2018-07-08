# dotfiles

My personal and work [dotfiles](https://dotfiles.github.io/) for Mac, Linux, and Windows (WSL).

## Overview

I use the excellent [RCM](https://github.com/thoughtbot/rcm) from Thoughtbot to manage my dotfiles.
This tool is equally usable on Linux, Mac, and now Windows using the
[Windows Subsystem For Linux (WSL)](https://msdn.microsoft.com/en-us/commandline/wsl/about).

If you haven't already read about RCM I highly encourage you to read and understand it before
attempting to understand how things are structured here.  An excellent overview article
on RCM can be found [here](https://robots.thoughtbot.com/rcm-for-rc-files-in-dotfiles-repos).

## Setting up a machine

**Prerequisites: RCM and CURL.**

To set up or reinstall a machine to use the dotfiles you must first install RCM and curl.  At this
point you should also install any needed SSH keys in order to perform the following clone.  Once configured,
clone this repo into the ~/.dotfiles directory and follow the steps below.

1.  Execute ~/.dotfiles/setup.sh
1.  Edit ~/.rcrc as needed for the machine you are on.  Tags may need to be changed, etc.
1.  Then simply run 'rcup'

It is common to have to restart your shell after running rcup.

## dotfiles-private

Given that this repo is intended to be public it prohibits placing anything "sensitive" into
the repository.  Due to that, everything has been pre-configured to support a second dotfiles
repository placed into ~/.dotfiles-private.  Within that an rcs folder can be used to contain
overrides and extensions to the dotfiles placed here.

NOTE: The mkrc command won't really work in this case because the rcs will always go
into the public repository when executing mkrc.  Any files needed to be in the private
repository will need to be placed there manually.

## OS and local override files

A number of dotfiles support "include" files in various ways.  All of the files that do
support such a construct have been pre-configured to allow both an OS specific override as well
as a local (host specific) override.  In all cases the order is: first the global settings, then
the OS settings, finally the local settings.  All of which can further be overridden using a
dotfiles-private repository.

## Windows, WSL, and PowerShell

For Windows machines the above steps should all be performed in the bash shell provided by
WSL.  After these steps you could then pull the [WinFiles](https://github.com/brennanfee/winfiles)
repo to set up PowerShell and the Windows side of things (see that repo for instructions).

