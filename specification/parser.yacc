%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

typedef struct {
    int major;
    int minor;
    int patch;
    char *prerelease;
    char *build;
} SemVer;

%}

%union {
    int num;
    char *str;
}

%token <num> NUMBER
%token <str> IDENTIFIER
%token DOT DASH PLUS
%token CARET TILDE EQUAL LESS GREATER AND_OP

%%

/* Entry point handles compound multi-range logic */
constraint_input:
    expression_list
    ;

expression_list:
    expression
    | expression_list AND_OP expression { printf("  -> Joined via logical intersection (AND)\n"); }
    | expression_list expression        { printf("  -> Joined via implicit whitespace (AND)\n"); }
    ;

expression:
    operator version_core { printf("Parsed absolute bounding condition constraint.\n"); }
    | CARET version_core  { printf("Parsed Caret (^) pessimistic constraint (Up to next Major).\n"); }
    | TILDE version_core  { printf("Parsed Tilde (~) loose patching constraint (Up to next Minor).\n"); }
    | version_core        { printf("Parsed exact matching version requirement.\n"); }
    ;

operator:
    EQUAL
    | LESS
    | GREATER
    | LESS EQUAL          { printf("Operator: Less than or equal (<=)\n"); }
    | GREATER EQUAL       { printf("Operator: Greater than or equal (>=)\n"); }
    ;

version_core:
    NUMBER DOT NUMBER DOT NUMBER {
        printf("  Found base engine version node: %d.%d.%d\n", $1, $3, $5);
    }
    | NUMBER DOT NUMBER {
        printf("  Found partial release tuple node: %d.%d.x\n", $1, $3);
    }
    | NUMBER {
        printf("  Found generalized core version node: %d.x.x\n", $1);
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "SemVer Range Evaluation Fault: %s\n", s);
}

int main(void) {
    printf("Enter SemVer range statement (e.g., >=1.2.0 <2.0.0 or ^4.1.2): \n");
    return yyparse();
}
