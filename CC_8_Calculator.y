%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token NUMBER

%%

input:
      /* empty */
    | input line
    ;

line:
      expr '\n'   { printf("= %d\n", $1); }
    | error '\n'  { printf("Syntax Error! Re-enter expression.\n"); yyclearin; }
    ;

expr:
      expr '+' expr   { $$ = $1 + $3; }
    | expr '-' expr   { $$ = $1 - $3; }
    | expr '*' expr   { $$ = $1 * $3; }
    | expr '/' expr   { 
                           if ($3 == 0) {
                               printf("Math Error: Division by zero\n");
                               $$ = 0;
                           } else {
                               $$ = $1 / $3;
                           }
                       }
    | '(' expr ')'     { $$ = $2; }
    | NUMBER
    ;

%%

int main() {
    printf("Enter expressions (Ctrl + D to exit):\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}
