#!/bin/bash

set -e  # Arrêter le script en cas d'erreur

if [ $# -lt 1 ];then 
# Aucun argument n'a été donné
    exit 1
fi

compilateur=(clang gcc)

arg=$(cut -d " " -f 2- <<< "$@")

prog=$1

ext="${prog##*.}"
# Permet de récupérer le nom de l'extension
# donc supprime tout après le dernier points (point inclus)


for i in "${compilateur[@]}"; do
   

    if [ "$ext" == "c" ]; then
        $i $CFLAGS -o "${prog%.c}" "$prog" > /dev/null 2>&1 # $CFLAGS car c'est une variable d'environnement
        bin_prog="${prog%.c}"
        # ${prog%.c} me donne le nom du programme sans .c
    else
        make CC=$i CFLAGS="$CFLAGS" $prog > /dev/null 2>&1
        bin_prog="${prog%.*}"
    fi

    if [ $? -ne 0 ];then
        exit 2
    fi

    
    start_time=$(date +%s.%N)
    ./$bin_prog $arg > /dev/null 2>&1 # Récupération du temps d'execution
    end_time=$(date +%s.%N)

    time_=$(echo "$end_time - $start_time" | bc)

    if [ "$i" == "clang" ];then
        time_clang=$time_
        #echo "TIME CLANG : $time_clang"
    else
        time_gcc=$time_
        #echo "TIME GCC : $time_gcc"
    fi


done


if [ $(echo "$time_clang < $time_gcc" | bc -l) -eq 1 ]; then
    echo "clang est meilleur que gcc"
elif [ $(echo "$time_clang > $time_gcc" | bc -l) -eq 1 ]; then
    echo "gcc est meilleur que clang"
else
    echo "clang et gcc sont similaires"
fi

# On utilise bc -l pour comparer les 2 valeurs de temps, qui sont des float, dans la sortie standard
exit 0
