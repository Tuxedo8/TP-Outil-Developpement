#!/bin/bash

for i in "$@"; do
    file1=$i
    file2=$(cut -d "." -f 1 <<< "$i")
    if [ ${#file1} -gt ${#file2} ]; then

        make $file2
        if [ $? -gt 0 ]; then
            exit 1
        fi
    else ./$file1
    fi
done
