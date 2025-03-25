#include <stdio.h>
#include <stdlib.h>

void write_to_array(int *arr, int size) {
    for (int i = 0; i <= size; i++) {  // Erreur : boucle dépasse la taille du tableau
        arr[i] = i * 2;  // Écriture hors limites
    }
}

void invalid_pointer_access() {
    int *ptr = NULL;  // Pointeur non initialisé
    *ptr = 42;  // Erreur d'écriture via un pointeur nul
}

int main() {
    int *array = malloc(5 * sizeof(int));
    if (!array) {
        perror("Erreur d'allocation");
        return EXIT_FAILURE;
    }

    write_to_array(array, 5);  // Problème 1 : dépassement des limites du tableau
    invalid_pointer_access();  // Problème 2 : écriture via pointeur nul

    free(array);
    return 0;
}

