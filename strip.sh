#!/bin/bash

# Vérifie si au moins un argument est passé
if [ "$#" -eq 0 ]; then
    echo "Aucun argument fourni."
    exit 1
fi

# Fonction pour traiter un fichier ou un répertoire
process_item() {
    local item="$1"

    if [ -d "$item" ]; then
        # Si c'est un répertoire, traiter tous les fichiers non cachés
        for file in "$item"/*; do
            # Vérifie si le fichier existe (pour éviter les erreurs si le répertoire est vide)
            if [ -e "$file" ]; then
                process_item "$file"
            fi
        done
    elif [ -f "$item" ]; then
        # Si c'est un fichier, vérifier s'il est au format ELF
        if file "$item" | grep -q "ELF"; then
            strip "$item"
        else
            rm "$item"
        fi
    fi
}

# Traiter chaque argument
for arg in "$@"; do
    process_item "$arg"
done
