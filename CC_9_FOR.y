%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token FOR ID NUMBER
%token INC DEC LE GE EQ NE

%%

program:
        for_stmt
        ;

for_stmt:
        FOR '(' init_stmt ';' condition ';' inc_stmt ')' body
        {
            printf("Valid for loop\n");
        }
        ;

init_stmt:
        ID '=' NUMBER
        | /* empty */
        ;

condition:
        ID relop NUMBER
        | /* empty */
        ;

relop:
        '<' | '>' | LE | GE | EQ | NE
        ;

inc_stmt:
        ID INC
        | ID DEC
        | ID '=' ID '+' NUMBER
        | /* empty */
        ;

body:
        '{' stmt_list '}'
        ;

stmt_list:
        stmt_list stmt
        | stmt
        ;

stmt:
        ID '=' NUMBER ';'
        | /* empty */
        ;

%%

int main() {
    printf("Enter a for loop:\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}
