%{
#include <stdio.h>
#include <stdlib.h>
#include "meta.h"
int yylex();
%}

%union {
    char *str;
    t_document *document;
    t_scalar *scalar;
    t_type *type;
    t_enum *enum;
    t_directive_location dirloc;
}

%token SCALAR TYPE DIRECTIVE ENUM ON
%token <str> COMMENT
%token <str> DESC
%token <str> DEFAULT_VALUE
%token <str> DIRECTIVE_NAME
%token <dirloc> DIRECTIVE_LOCATION

%type <document> document
%type <scalar> scalar
%type <type> type
%type <enum> enum

%%
document:
    | document scalar { $$ = addscalar($1, $2); }
    | document type   { $$ = addtype($1, $2); }
    | document enum   { $$ = addenum($1, $2); }
    ;

scalar: SCALAR NAME { $$ = newscalar($2, ""); }
      | COMMENT SCALAR NAME { $$ = newscalar($2, $1); }

type: TYPE NAME '{' args '}' { $$ = newtype($2, $4, ""); }
    | COMMENT TYPE NAME '{' args '}' { $$ = newtype($2, $4, $1); }

directive:
         DIRECTIVE DIRECTIVE_NAME '(' args ')' ON directive_locations
         COMMENT DIRECTIVE DIRECTIVE_NAME '(' args ')' ON directive_locations

enum: ENUM NAME '{' enumValues '}' { $$ = newenum($2, $4, ""); }
    | COMMENT ENUM NAME '{' enumValues '}' { $$ = newenum($2, $4, $1); }

directive_locations:
    | directive_locations DIRECTIVE_LOCATION { ... }

args: ;

enumValues:
    | enumValues NAME { $$ = newenumvalue($2, ""); }
    | enumValues COMMENT NAME { $$ = newenumvalue($2, $3); }
