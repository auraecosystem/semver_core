%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

// Evaluation operator mappings
#define OP_EQ  1
#define OP_LT  2
#define OP_GT  3
#define OP_LTE 4
#define OP_GTE 5
#define OP_CAR 6
#define OP_TIL 7

// Global struct to pass results back to the C wrapper file
typedef struct {
    int op;
    int major;
    int minor;
    int patch;
} ConstraintResult;

extern ConstraintResult current_constraint;
%}

%union {
    int num;
    char *str;
}

%token <num> NUMBER
%token <str> IDENTIFIER
%token DOT DASH PLUS CARET TILDE EQUAL LESS GREATER

%%

constraint_input:
    expression
    ;

expression:
    operator version_core  
    | CARET version_core   { current_constraint.op = OP_CAR; }
    | TILDE version_core   { current_constraint.op = OP_TIL; }
    | version_core         { current_constraint.op = OP_EQ; }
    ;

operator:
    EQUAL                  { current_constraint.op = OP_EQ; }
    | LESS                 { current_constraint.op = OP_LT; }
    | GREATER              { current_constraint.op = OP_GT; }
    | LESS EQUAL           { current_constraint.op = OP_LTE; }
    | GREATER EQUAL        { current_constraint.op = OP_GTE; }
    ;

version_core:
    NUMBER DOT NUMBER DOT NUMBER {
        current_constraint.major = $1;
        current_constraint.minor = $3;
        current_constraint.patch = $5;
    }
    ;

%%

void yyerror(const char *s) {
    // Suppress verbose tracking output during array iteration loops
}
