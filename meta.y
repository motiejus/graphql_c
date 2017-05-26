%{
#include <stdio.h>
#include <stdlib.h>
#include "meta.h"
int yylex();
%}

%union {
    char *str;
}

%token SCALAR TYPE DIRECTIVE ENUM ON
%token <str> COMMENT
%token <str> DESC
%token <str> DEFAULT_VALUE
%token <str> DIRECTIVE_NAME

%type <scalar> scalar
%type <type> type
%type <enum> enum

%%
document:
    | document definition
    ;

definition:
    | scalar
    | type
    | enum
    ;

scalar:
    SCALAR NAME { $$ = newscalar($2); }

type: TYPE NAME '{' typeFields '}' { $$ = newtype($2, $4, ""); }
    | COMMENT TYPE NAME '{' typeFields '}' { $$ = newtype($2, $4, $1); }

/* directive */

enum: ENUM NAME '{' enumValues '}' { $$ = newenum($2, $4, ""); }
    | COMMENT ENUM NAME '{' enumValues '}' { $$ = newenum($2, $4, $1); }

typeFields: ;

enumValues:
    | enumValues NAME { $$ = newenumvalue($2, ""); }
    | enumValues COMMENT NAME { $$ = newenumvalue($2, $3); }
