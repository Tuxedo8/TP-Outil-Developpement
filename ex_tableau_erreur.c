#include <stdio.h>
#include <stdlib.h>




int main(int argc, char *argv[]) {
    int **p, ok=1;
    p = malloc(sizeof(int *)*10);
    if (p == NULL)
        exit(1);
    for (int i=0; i<10 && ok; i++) {
        p[i] = malloc(sizeof(int)*10);
        ok = (p[i] != NULL);
    }
    if (ok) {
        printf("Square matrix of size %d allocated\n", 10);
        for (int i=0; i<10; i++)
            for (int j=0; j<=10; j++)
                p[i][j] = 42;
        printf("Matrix initialized\n");
    } else
        printf("Cannot allocate matrix\n");
        /*
        for (int i=0; i<10 && (p[i] != NULL); i++)
            free(p[i]);
        free(p);
        printf("Matrix freed\n");
        */
    return 0;
}
