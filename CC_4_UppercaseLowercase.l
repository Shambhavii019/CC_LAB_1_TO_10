%{
#include <stdio.h>
%}

%%

[A-Z]       { putchar(yytext[0] + 32); }   /* uppercase → lowercase */
[a-z]       { putchar(yytext[0] - 32); }   /* lowercase → uppercase */

.           { putchar(yytext[0]); }        /* print other characters as-is */

%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
