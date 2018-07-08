[diff]
  tool = bc
  guitool = bc
[difftool "bc"]
  cmd = \"/mnt/c/Program Files/Beyond Compare 4/BCompare.exe\" -expandall \"`echo $LOCAL | sed 's_/mnt/c_C:_'`\" \"`echo $REMOTE | sed 's_/mnt/c_C:_'`\"
  trustExitCode = true
[merge]
  tool = bc
[mergetool "bc"]
  cmd = \"/mnt/c/Program Files/Beyond Compare 4/BCompare.exe\" -expandall \"`echo $LOCAL | sed 's_/mnt/c_C:_'`\" \"`echo $REMOTE | sed 's_/mnt/c_C:_'`\" \"`echo $BASE | sed 's_/mnt/c_C:_'`\" \"`echo $MERGED | sed 's_/mnt/c_C:_'`\"
  trustExitCode = true

