struct post {
    char name[40]; /* <- Ful h�rdkodning */
    float bmi;
    struct post * next;
};

typedef struct post Post;

void writePost(Post * p);

void writeList(Post * p);

/* find tar en funktionspekare som f�rsta parameter */
Post * find(int (* compare) (Post * a, Post * b), Post sought, Post * list);

int compare_names(Post * a, Post * b);

int compare_bmi(Post * a, Post * b);

void insert(Post ** list);

void load_names(char * filename, Post ** list);

