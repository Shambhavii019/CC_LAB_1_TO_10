%{
#include <stdio.h>

int count = 0;
%}

%%

([Aa])[a-zA-Z]*      { count++; }     /* words starting with A or a */

[ \t\n]+             { /* ignore whitespace */ }

.                    { /* ignore other characters */ }

%%

int main() {
    yylex();
    printf("Number of words starting with A or a: %d\n", count);
    return 0;
}

int yywrap() {
    return 1;
}
