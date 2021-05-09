# Aliases for linux apps, redirecting to windows versions

if [[ -e "/mnt/c/Program\ Files/Vim/vim82/gvim.exe" ]]; then
  alias gvim="/mnt/c/Program\ Files/Vim/vim82/gvim.exe"
fi

alias docker="docker.exe"
alias docker-compose="docker-compose.exe"
alias docker-machine="docker-machine.exe"
alias kubectl="kubectl.exe"
alias notary="notary.exe"

#if [[ -e "$SCOOP/shims/packer.exe" ]]; then
#  alias packer="$SCOOP/shims/packer.exe"
#fi
alias vagrant="vagrant.exe"

if [[ -e "/mnt/c/Program\ Files/Beyond\ Compare\ 4/BCompare.exe" ]]; then
  alias bcomp="/mnt/c/Program\ Files/Beyond\ Compare\ 4/BCompare.exe"
  alias bcompare="/mnt/c/Program\ Files/Beyond\ Compare\ 4/BCompare.exe"
fi
