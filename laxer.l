%{
#include <stdio.h>
#include <stdlib.h>
#include "calc.tab.h"
%}

%option noyywrap nounput noinput
%option yylineno

%%
[0-9]+      { yylval.num = strtol(yytext, NULL, 10); return NUM; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return TIMES; }
"/"         { return DIVIDE; }
"("         { return LPAREN; }
")"         { return RPAREN; }
\n          { return NEWLINE; }
[ \t\r]+    { }
"#".*       { }
.           { fprintf(stderr, "line %d: unknown character '%s'\n", yylineno, yytext); }
%%