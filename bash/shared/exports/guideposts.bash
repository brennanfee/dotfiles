#!/usr/bin/env bash

# The values exported here serve as navigational "guideposts".  They serve to smooth
# out minor differences in the way Windows WSL and Unixes (Linux and macOS) are
# set up.

# For Windows WSL I use the WSLENV environment variable to pass in the values
# some path values along with a custom value WIN_USER.  WIN_USER should be set
# to the %USERNAME% value in Windows.  The WIN_USER variable is used in
# situations where the Unix (WSL) and Windows usernames might differ (which
# will be common).  PROFILEPATH is a custom value that gets set with my standard
# PowerShell profile scripts and points to my main profile location.
# Both USERPROFILE and SystemRoot are standard paths available in Windows by
# default.  The WSLENV should be set to:
# USERPROFILE/up:PROFILEPATH/up:SystemRoot/up:WIN_USER

if [[ "${PROFILEPATH}x" == "x" ]]; then
  if [[ -d "$HOME/profile" ]]; then
    export PROFILEPATH="$HOME/profile"
  else
    export PROFILEPATH="$HOME"
  fi
fi

# This is only here for Windows and WSL.  For all non-Windows machines $HOME is "home", but
# for my WSL shells I keep track of two homes.  The "Linux" home stays as "home" (cd -) but
# I also track the "windows" home (usually C:\Users\<username>).  This I map to cdh.  On
# linux cdh is the same as just cd, but on windows they will be two different paths with
# two different environment variables $HOME and $WIN_HOME pointing to each, respectively.
if [[ "${USERPROFILE}x" != "x" && -d $USERPROFILE ]]; then
  export WIN_HOME="$USERPROFILE"
else
  export WIN_HOME="$HOME"
fi
