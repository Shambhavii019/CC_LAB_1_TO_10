%{
#include "y.tab.h"
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }

[+\-*/]     { return yytext[0]; }

[ \t\n]+    { /* ignore whitespace */ }

.           { /* ignore other char */ }

%%

int yywrap() {
    return 1;
}
