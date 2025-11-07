%{
#include <stdio.h>
%}

%%

.*com$      { printf("Matched line: %s", yytext); }

.*\n        { /* other lines ignored */ }

%%

int main() {
    printf("Enter input (Ctrl+D to stop):\n");
    yylex();
    return 0;
}

int yywrap() { return 1; }
