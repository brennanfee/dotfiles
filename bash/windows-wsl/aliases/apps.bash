# Aliases for linux apps, redirecting to windows versions

if [[ -d "$SCOOP/shims/gvim.exe" ]]; then
  alias gvim="$SCOOP/shims/gvim.exe"
fi

alias docker="docker.exe"
alias docker-compose="docker-compose.exe"
alias docker-machine="docker-machine.exe"
alias kubectl="kubectl.exe"
alias notary="notary.exe"

alias packer="$SCOOP/shims/packer.exe"
alias vagrant="vagrant.exe"

alias bcomp="/mnt/c/Program\ Files/Beyond\ Compare\ 4/BCompare.exe"
alias bcompare="/mnt/c/Program\ Files/Beyond\ Compare\ 4/BCompare.exe"
