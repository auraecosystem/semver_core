%{
/* C code and declarations */
#include <stdio.h>
%}

/* Definitions */
DIGIT      [0-9]
LETTER     [a-zA-Z]

%%

/* Rules */
{DIGIT}+           { printf("NUMBER: %s\n", yytext); }
{LETTER}+          { printf("WORD: %s\n", yytext); }
[ \t\n]+           ;   /* Ignore whitespace */
.                  { printf("CHAR: %s\n", yytext); }

%%

int main(void) {
    yylex();
    return 0;
}

int yywrap(void) {
    return 1;
}
