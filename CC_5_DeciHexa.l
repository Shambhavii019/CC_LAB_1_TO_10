%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%%

0[xX][0-9A-Fa-f]+   {
                        /* Hexadecimal → Decimal */
                        long dec = strtol(yytext, NULL, 16);
                        printf("Hex: %s → Decimal: %ld\n", yytext, dec);
                    }

[0-9]+              {
                        /* Decimal → Hexadecimal */
                        long dec = atol(yytext);
                        printf("Decimal: %ld → Hex: %lX\n", dec, dec);
                    }

[ \t\n]+            { /* ignore whitespace */ }

.                   { /* ignore everything else */ }

%%

int main() {
    printf("Enter numbers (decimal or hex with 0x prefix):\n");
    yylex();
    return 0;
}

int yywrap() { return 1; }
