%{
#include "y.tab.h"
%}

%%

[0-9]+                  { return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*  { return ID; }

[+\-*/()]               { return yytext[0]; }

[ \t\n]+               { /* ignore whitespace */ }

.                      { /* ignore */ }

%%

int yywrap() { return 1; }
