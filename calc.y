%code requires { #include "ast.h" }

%{
#include <stdio.h>

int  yylex(void);
void yyerror(const char *msg);
extern FILE *yyin;
extern int   yylineno;
%}

%union {
    long  num;
    Node *node;
}

%token <num> NUM
%token PLUS MINUS TIMES DIVIDE LPAREN RPAREN NEWLINE
%type  <node> expr

%destructor { free_tree($$); } <node>

%left  PLUS MINUS
%left  TIMES DIVIDE
%precedence NEG

%%
input : %empty
      | input line
      ;

line  : NEWLINE
      | expr NEWLINE      {
                            printf("line %d:\n", yylineno - 1);
                            print_tree($1, stdout);
                            free_tree($1);
                          }
      | error NEWLINE     { yyerrok; }
      ;

expr  : NUM                     { $$ = new_num($1); }
      | expr PLUS   expr        { $$ = new_binop('+', $1, $3); }
      | expr MINUS  expr        { $$ = new_binop('-', $1, $3); }
      | expr TIMES  expr        { $$ = new_binop('*', $1, $3); }
      | expr DIVIDE expr        { $$ = new_binop('/', $1, $3); }
      | MINUS expr %prec NEG    { $$ = new_neg($2); }
      | LPAREN expr RPAREN      { $$ = $2; }
      ;
%%

void yyerror(const char *msg) {
    fprintf(stderr, "line %d: %s\n", yylineno, msg);
}

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s <input file>\n", argv[0]);
        return 1;
    }
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror(argv[1]);
        return 1;
    }
    int result = yyparse();
    fclose(yyin);
    return result;
}