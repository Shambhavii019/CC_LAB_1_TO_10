%{
#include <stdio.h>
#include <stdlib.h>

int stack[100];
int top = -1;

void push(int v) { stack[++top] = v; }
int pop() { return stack[top--]; }

%}

%token NUMBER

%%

input:
       input line
     | /* empty */
     ;

line:
       expr '\n'   { printf("Result = %d\n", $1); }
     ;

expr:
       NUMBER      { push($1); $$ = $1; }
     | expr NUMBER { push($2); $$ = $2; }
     | expr '+'    {
                        int b = pop();
                        int a = pop();
                        int r = a + b;
                        push(r);
                        $$ = r;
                    }
     | expr '-'    {
                        int b = pop();
                        int a = pop();
                        int r = a - b;
                        push(r);
                        $$ = r;
                    }
     | expr '*'    {
                        int b = pop();
                        int a = pop();
                        int r = a * b;
                        push(r);
                        $$ = r;
                    }
     | expr '/'    {
                        int b = pop();
                        int a = pop();
                        int r = a / b;
                        push(r);
                        $$ = r;
                    }
     ;

%%

int main() {
    printf("Enter postfix expression:\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Error: %s\n", s);
    return 0;
}
