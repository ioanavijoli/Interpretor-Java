#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include "tree.h"
#include "y.tab.h"

struct Node* tree_node(char *s, int children_size, ...) {
    struct Node *r = (struct Node*)malloc(sizeof(struct Node));
    r->val = (char*)malloc(strlen(s)+1);
    strcpy(r->val, s);
    r->children_size = children_size;
    r->children = (struct Node**)malloc(sizeof(struct Node*)*children_size);
    int i;
    va_list list;
    va_start(list, children_size);
    for (i = 0; i < children_size; i++) {
        r->children[i] = va_arg(list, struct Node*);
    }
    return r;
}

void pretty_print(struct Node *r, int level) {
    if (r == NULL) {
        return;
    }
    int i;
    for (i = 0; i < level; i++) {
        printf("  ");
    }
    if (strcmp(r->val, "(") == 0 || strcmp(r->val, ")") == 0) {
        printf("%s", r->val);
    } else {
        printf("%s", r->val);
        if (strcmp(r->val, ",") != 0) {
            printf(" ");
        }
    }
    printf("\n");
    for (i = 0; i < r->children_size; i++) {
        pretty_print(r->children[i], level + 1);
    }
}


