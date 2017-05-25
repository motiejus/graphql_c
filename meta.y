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

%type <str> comment
%type <str> desc
%type <str> default_value

%%
document:
    | document definition
    ;

definition:
    | scalar
    | type
    | enum

scalar:
    SCALAR NAME { $$ = newscalar($2); }

type: TYPE NAME typedefn { $$ = newtype($2, $3); }

/* directive */

enum: ENUM NAME enumdefn { $$ = newenum($2, $3); }

typedefn: ;
enumdefn:
    '{' enumValues'}' ;

enumValues:
     | name name
     | comment name name
