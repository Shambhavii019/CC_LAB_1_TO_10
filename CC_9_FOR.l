%{
#include "y.tab.h"
%}

%%

"for"               { return FOR; }
"("                 { return '('; }
")"                 { return ')'; }
";"                 { return ';'; }

"{"                 { return '{'; }
"}"                 { return '}'; }

"="                 { return '='; }
"++"                { return INC; }
"--"                { return DEC; }
"<="                { return LE; }
">="                { return GE; }
"=="                { return EQ; }
"!="                { return NE; }
"<"                 { return '<'; }
">"                 { return '>'; }

[a-zA-Z_][a-zA-Z0-9_]*   { return ID; }

[0-9]+               { return NUMBER; }

[ \t\n]+            { /* ignore whitespace */ }

.                   { return yytext[0]; }

%%

int yywrap() { return 1; }
