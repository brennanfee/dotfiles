# Aliases for linux apps, redirecting to windows versions

if [[ -d "/mnt/c/Program\ Files\ \(x86\)/vim/vim81" ]]; then
    alias gvim="/mnt/c/Program\ Files\ \(x86\)/vim/vim81/gvim.exe"
elif [[ -d "/mnt/c/Program Files (x86)/vim/vim80" ]]; then
    alias gvim="/mnt/c/Program\ Files\ \(x86\)/vim/vim80/gvim.exe"
fi

alias docker="docker.exe"
alias docker-compose="docker-compose.exe"
alias docker-machine="docker-machine.exe"

alias start="cmd.exe /c start"
alias open="cmd.exe /c start"
alias xdg-open="cmd.exe /c start"
alias o="cmd.exe /c start"

alias packer="packer.exe"
alias vagrant="vagrant.exe"

alias bcomp="/mnt/c/Program\ Files/Beyond\ Compare\ 4/BCompare.exe"
alias bcompare="/mnt/c/Program\ Files/Beyond\ Compare\ 4/BCompare.exe"
