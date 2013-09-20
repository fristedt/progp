#include <stdlib.h>
#include <stdio.h>
#include "nod.h"

void writePost(Post * p) {
}

void writeList(Post * p) {
}

Post * find(int (* compare) (Post *  a, Post * b), Post sought, Post * list) {
}

int compare_names(Post * a, Post * b) {
}

int compare_bmi(Post * a, Post * b) {
}

void insert(Post ** list) {
}

void load_names(char * filename, Post ** list) {
    char name[40]; /* <- Ful hårdkodning */
    float bmi;
    FILE *fil = fopen(filename, "r");
    Post * p;
    if (fil == NULL) {
	printf("Filen inte funnen.\n");
    } else {
        while (fscanf(fil, "%s %f", name, &bmi) == 2) {
            p = (Post *) malloc(sizeof(Post));
            strcpy(p->name, name);
            p->bmi = bmi;
            
            p->next = *list;
            *list = p;
        }
    }
}

