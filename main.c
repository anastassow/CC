//
// Created by Dimitar Anastassov on 28.09.26.
//
#include  <stdlib.h>
#include  <stdio.h>
#include  "ast.h"

int main(void) {

    Node *t1 = new_binop('+',
                   new_num(2),
                   new_binop('*', new_num(3), new_num(4)));

    /* -(3 - 5) * 10 */
    Node *t2 = new_binop('*',
                   new_neg(new_binop('-', new_num(3), new_num(5))),
                   new_num(10));

    printf("2 + 3 * 4:\n");
    print_tree(t1, stdout);

    printf("\n-(3 - 5) * 10:\n");
    print_tree(t2, stdout);

    free_tree(t1);
    free_tree(t2);

return  0;
}