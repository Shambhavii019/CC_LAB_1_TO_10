%{
#include <stdio.h>
#include <string.h>

int comment_count = 0;
int keyword_count = 0;
int identifier_count = 0;
int word_count = 0;
int line_count = 0;
int space_count = 0;

char *keywords[] = {
    "int","float","char","double","if","else","for","while",
    "do","return","void","switch","case","break","long","short"
};
int keyword_total = 16;

int is_keyword(char *str) {
    for(int i = 0; i < keyword_total; i++)
        if(strcmp(str, keywords[i]) == 0)
            return 1;
    return 0;
}
%}

%%

"//".*                  { comment_count++; line_count++; }
"/*"([^*]|\*+[^*/])*"*/" { comment_count++; }

[ \t]                   { space_count++; }
\n                      { line_count++; }

[a-zA-Z_][a-zA-Z0-9_]*  {
                            word_count++;
                            if(is_keyword(yytext))
                                keyword_count++;
                            else
                                identifier_count++;
                        }

[0-9]+                  { word_count++; }

.                       { /* ignore other characters */ }

%%

int main() {
    yylex();
    printf("\n===== OUTPUT =====\n");
    printf("Comments     : %d\n", comment_count);
    printf("Keywords     : %d\n", keyword_count);
    printf("Identifiers  : %d\n", identifier_count);
    printf("Words        : %d\n", word_count);
    printf("Lines        : %d\n", line_count);
    printf("Spaces       : %d\n", space_count);
    return 0;
}

int yywrap() {
    return 1;
}
