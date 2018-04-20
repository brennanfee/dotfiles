#!/usr/bin/env bash

export PROMPT_DIRTRIM=4

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
        local exit_status="${color_green}${i_fa_check}"
    else
        local exit_status="${color_red}${i_fa_close} (\$?)"
    fi

    local ssh_text=""
    if [[ -n "$SSH_CLIENT" ]]; then
        local ssh_text=" (SSH)"
    fi

    if [[ -e /usr/lib/git-core/git-sh-prompt ]]; then
        git_part="__git_ps1 ${color_yellow}(%s) "
        export PS1="${color_normal}\n${color_green}\u@\h${color_yellow}${ssh_text} ${color_purple}\w $(${git_part}) $exit_status ${color_normal}\n\$ "
    else
        export PS1="${color_normal}\n${color_green}\u@\h${color_yellow}${ssh_text} ${color_purple}\w $exit_status ${color_normal}\n\$ "
    fi
}

PROMPT_COMMAND=custom_prompt
