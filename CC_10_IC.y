%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 0;

char *newTemp() {
    char *t = (char*)malloc(5);
    sprintf(t, "t%d", ++tempCount);
    return t;
}

typedef struct {
    char code[200];
    char place[10];
} Node;

int yylex();
void yyerror(const char *s);

%}

%token ID NUMBER

%left '+' '-'
%left '*' '/'

%%

start:
        expr '\n'  { 
                        printf("\nGenerated Intermediate Code:\n");
                        printf("%s", $1.code);
                        printf("\nFinal result in: %s\n", $1.place);
                   }
        ;

expr:
        expr '+' expr {
                Node n;
                char *t = newTemp();

                sprintf(n.code, "%s%s%s = %s + %s\n",
                        $1.code, $3.code, t, $1.place, $3.place);

                strcpy(n.place, t);
                $$ = n;
        }
        | expr '-' expr {
                Node n;
                char *t = newTemp();

                sprintf(n.code, "%s%s%s = %s - %s\n",
                        $1.code, $3.code, t, $1.place, $3.place);

                strcpy(n.place, t);
                $$ = n;
        }
        | expr '*' expr {
                Node n;
                char *t = newTemp();

                sprintf(n.code, "%s%s%s = %s * %s\n",
                        $1.code, $3.code, t, $1.place, $3.place);

                strcpy(n.place, t);
                $$ = n;
        }
        | expr '/' expr {
                Node n;
                char *t = newTemp();

                sprintf(n.code, "%s%s%s = %s / %s\n",
                        $1.code, $3.code, t, $1.place, $3.place);

                strcpy(n.place, t);
                $$ = n;
        }
        | '(' expr ')' {
                $$ = $2;
        }
        | ID {
                Node n;
                n.code[0] = '\0';
                strcpy(n.place, yytext);
                $$ = n;
        }
        | NUMBER {
                Node n;
                n.code[0] = '\0';
                strcpy(n.place, yytext);
                $$ = n;
        }
        ;

%%

int main() {
    printf("Enter an arithmetic expression:\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}
