#!/bin/bash

_setdns_completions()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Read DNS names from text file
    CONFIG_FILE="/usr/local/etc/dns_settings.txt"
    opts=$(awk '{print $1}' $CONFIG_FILE)
    opts+=" --help -h"

    if [[ ${cur} == -* ]] ; then
        COMPREPLY=( $(compgen -W "--help -h" -- ${cur}) )
        return 0
    fi

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _setdns_completions setdns