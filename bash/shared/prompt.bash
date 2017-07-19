#!/usr/bin/env bash

if [[ -e /usr/lib/git-core/git-sh-prompt ]]; then
    source '/usr/lib/git-core/git-sh-prompt'
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="verbose git"
    GIT_PS1_SHOWCOLORHINTS=1
fi

function custom_prompt {
    if [[ $? -eq 0 ]]; then
        local exit_status="${green}$symbol_closed_arrow"
    else
        local exit_status="${red}$symbol_closed_arrow"
    fi

    if [[ -e /usr/lib/git-core/git-sh-prompt ]]; then
        git_part="__git_ps1 ${yellow}(%s) "
        export PS1="${normal}\n${green}\u@\h ${purple}\w $(${git_part}) $exit_status ${normal}\n\$ "
    else
        export PS1="${normal}\n${green}\u@\h ${purple}\w $exit_status ${normal}\n\$ "
    fi
}

PROMPT_COMMAND=custom_prompt
