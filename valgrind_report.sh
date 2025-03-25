#!/bin/bash

if [ $# -lt 1 ];then 
# Aucun argument n'a été donné
    exit
fi

display_read() {

    local error_read=$(echo "$1" | grep -E '.*at.*\(.*\.c:[0-9]+\)' | cut -d " " -f 7-)
    #echo "$error_read"
    while IFS= read -r R; do
        echo "Erreur en lecture dans $R" >&2
    done <<< "$error_read"

}

display_write() {
    
    local error_write=$(echo "$1" | grep -E '.*at.*\(.*\.c:[0-9]+\)' | cut -d " " -f 7-)
    #echo "$error_write"
    while IFS= read -r W; do
        echo "Erreur en ecriture dans $W" >&2
    done <<< "$error_write"

}


arg="${@:2}" # Equivalent de arg=$(cut -d " " -f 2- <<< "$@")

full_report=$(valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$1 $arg 2>&1) 

if [ -n "$(echo "$full_report" | grep "no leaks are possible")" ]; then
    exit
fi

if [ -n "$(echo "$full_report" | grep -E "Invalid (read|write)")" ]; then
    error_all=$(echo "$full_report" | sed -n '/Invalid read\|Invalid write/,/Address 0x/p')
    #echo "$error_all"
    #display_write "$error_all"
    #display_read "$error_all"
    
    if [[ -n "$(echo "$error_all" | grep "Invalid write")" && -n "$(echo "$error_all" | grep "Invalid read")" ]]; then
        error_write=$(echo "$error_all" | sed -n '/Invalid write/,/Address 0x/p')
        display_write "$error_write"

        error_read=$(echo "$error_all" | sed -n '/Invalid read/,/Address 0x/p')
        display_read "$error_read"

    elif [[ -n "$(echo "$error_all" | grep "Invalid write")" && -z "$(echo "$error_all" | grep "Invalid read")" ]]; then
        error_write=$(echo "$error_all" | sed -n '/Invalid write/,/Address 0x/p')
        display_write "$error_write"

    elif [[ -n "$(echo "$error_all" | grep "Invalid read")" && -z "$(echo "$error_all" | grep "Invalid write")" ]]; then
        error_read=$(echo "$error_all" | sed -n '/Invalid read/,/Address 0x/p')
        display_read "$error_read"

    fi
        
fi


definitely_lost=$(echo "$full_report" | grep "definitely lost: " | cut -d " " -f 7)
indirectly_lost=$(echo "$full_report" | grep "indirectly lost: " | cut -d " " -f 7)
possibly_lost=$(echo "$full_report" | grep "possibly lost: " | cut -d " " -f 9)

all_lost=0
all_lost=$(echo "$definitely_lost + $indirectly_lost" | bc -l)
all_lost=$(echo "$all_lost + $possibly_lost" | bc -l)


echo "Total des fuites : $all_lost octets" >&2

