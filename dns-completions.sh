#!/bin/bash

_setdns_completions()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="empty electro 403 --help -h"

    if [[ ${cur} == -* ]] ; then
        COMPREPLY=( $(compgen -W "--help -h" -- ${cur}) )
        return 0
    fi

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _setdns_completions setdns