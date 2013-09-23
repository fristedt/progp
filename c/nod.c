#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "nod.h"

void writePost(Post * p) {
  if (p == NULL) {
    printf("I cannot print that.\n");
    return;
  }

  printf("Namn: %s\n", p->name);
  printf("BMI: %.2f\n", p->bmi);
}

void writeList(Post * p) {
  if (p == NULL) {
    printf("Listan är tom.\n");
    return;
  }
  
  while (p != NULL) {
    writePost(p);
    p = p->next;
  } 
}

Post * find(int (* compare) (Post *  a, Post * b), Post sought, Post * list) {
  Post * p = list;
  while (p != NULL) {
    /* If p == sought. */
    if (!(* compare) (p, &sought)) {
      return p;
    }
    p = p->next;
  }
  return NULL;
}

int compare_names(Post * a, Post * b) {
  return strcmp(a->name, b->name);
}

int compare_bmi(Post * a, Post * b) {
  return a->bmi - b->bmi;
}

void insert(Post ** list) {
  int weight;
  float length;

  Post * p = (Post *) malloc(sizeof(Post));
  if (*list != NULL)
    (*list)->prev = p;

  p->next = *list;
  p->prev = NULL;
  *list = p;

  printf("Vad heter du? ");
  scanf("%s", p->name);

  printf("Hur lång är du (m)? ");
  scanf("%f", &length);

  printf("Vad väger du (kg)? ");
  scanf("%d", &weight);

  p -> bmi = weight / (length * length);
}

void delete(Post ** list) {
  if (*list == NULL) {
    printf("Listan är tom.\n");
    return;
  }
  char name[NAME_LENGTH];
  Post * p = *list;

  printf("Vem vill du ta bort? ");
  scanf("%s", name);

  while (p != NULL) {
    if (!strcmp(p->name, name)) {

      /* Removing last element. */
      if (p->prev == NULL && p->next == NULL) {
        *list = NULL;
        free(p);
        break;
      }

      /* Removing first element. */
      if (p->prev == NULL) {
        *list = p->next;
        (*list)->prev = NULL;
        free(p);
        break;
      }

      /* Removing last element. */
      if (p->next == NULL) {
        p->prev->next = NULL;
        free(p);
        continue;
      }

      p->prev->next = p->next; 
      p->next->prev = p->prev;
      free(p);
    }
    p = p->next;
  }
}

void load_names(char * filename, Post ** list) {
  char name[NAME_LENGTH]; 
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

      if (*list != NULL) {
        (*list)->prev = p;
      }

      p->next = *list;
      p->prev = NULL;
      *list = p;
    }
  }
}

