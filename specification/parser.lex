%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
%}

%option noyywrap

%%

"&&"        { return AND_OP; }
"||"        { printf("Lexer Warning: Logical OR grouping encountered.\n"); }
"^"         { return CARET; }
"~"         { return TILDE; }
"="         { return EQUAL; }
"<"         { return LESS; }
">"         { return GREATER; }
"."         { return DOT; }
"-"         { return DASH; }
"+"         { return PLUS; }

[0-9]+ {
    yylval.num = atoi(yytext);
    return NUMBER;
}

[a-zA-Z][a-zA-Z0-9]* {
    yylval.str = strdup(yytext);
    return IDENTIFIER;
}

[ \t\r\n]   { /* Skip token evaluation spacing */ }
.           { /* Discard invalid system characters safely */ }

%%
