#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

struct Node {
    char *val;
    int children_size;
    int line;
    struct Node **children;
};

struct Node* tree_node(char *s, int children_size, ...);

void pretty_print(struct Node *r, int level);

