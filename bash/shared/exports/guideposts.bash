#!/usr/bin/env bash

# The values exported here serve as navigational "guideposts".  I use these in other
# locations/scripts/functions as "markers".  On Unixes (Linux and OSX) most things
# are usually in $HOME, but on Windows they can be in wildly different locations
# (even across different Windows machines).

# For Windows WSL I use the WSLENV environment variable to pass in the values
# I am checking for below.  That value should be set up as well as the custom
# WIN_PROFILE value.  WSLENV should be set to "TMP/up:USERPROFILE/up:WIN_PROFILE/up".

# Set the temp directory if TMP env variable is set, generally this should only happen on windows.
# Lots of windows tools can't read the Linux tmp path.
if [[ "${TMP}x" != "x" && -d "$TMP" ]]; then
    export TMPDIR="$TMP"
fi

# This is only here for Windows and WSL.  For all non-Windows machines $HOME is "home", but
# for my WSL shells I keep track of two homes.  The "Linux" home stays as "home" (cd -) but
# I also track the "windows" home (usually C:\Users\<username>).  This I map to cdh.  On
# linux cdh is the same as just cd, but on windows they will be two different paths with
# two different environment variables $HOME and $WIN_HOME pointing to each, respectively.
if [[ "${USERPROFILE}x" != "x" && -d "$USERPROFILE" ]]; then
    export WIN_HOME="$USERPROFILE"
else
    export WIN_HOME="$HOME"
fi

# Lastly, my profile.  This is a root directory that I use to store most of the other
# organizational folders.  In both Unixes and Windows these are folders like Videos, Music,
# Downloads, etc.  For the Unixes, this is again usually the $HOME folder.  On Windows,
# it can be anywhere.  I create a Windows environment variable called WIN_PROFILE that
# should point to that location.
if [[ "${WIN_PROFILE}x" != "x" && -d "$WIN_PROFILE" ]]; then
    export MY_PROFILE="$WIN_PROFILE"
else
    export MY_PROFILE="$HOME"
fi
