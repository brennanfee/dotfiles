#!/usr/bin/env bash

function custom_prompt {
    if [[ $? -eq 0 ]]; then
        local exit_status="${green}$symbol_closed_arrow"
    else
        local exit_status="${red}$symbol_closed_arrow"
    fi

    export PS1="${normal}\n${green}\u@\h ${purple}\w $exit_status ${normal}\n\$ "
}

PROMPT_COMMAND=custom_prompt
