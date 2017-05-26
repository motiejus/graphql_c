%{
#include <stdio.h>
#include <stdlib.h>
#include "meta.h"
int yylex();
%}

%code {
/* global `types` is used for:
 *   access types in field definitions.
 *   add types when scalars are defined.
 */
t_type types;
}

%union {
    char* str;
    t_document* document;
    t_scalar* scalar;
    t_type* type;
    t_enum* enum;
    t_directive_location dirloc;
}

%token SCALAR TYPE DIRECTIVE ENUM ON
%token <str> COMMENT
%token <str> STR
%token <str> DIRNAME
%token <dirloc> DIRLOC

%type <document> document
%type <scalar> scalar
%type <type> type
%type <enum> enum

%%

document:
    | document scalar    { $$ = addscalar($1, $2); }
    | document enum      { $$ = addenum($1, $2); }
    | document type      { $$ = addtype($1, $2); }
    | document directive { $$ = adddirective($1, $2); }
    ;

scalar:         SCALAR NAME { $$ = newscalar("", $2); }
      | COMMENT SCALAR NAME { $$ = newscalar($1, $2); }
      ;

enum:         ENUM NAME '{' enumValues '}' { $$ = newenum($2, $4, ""); }
    | COMMENT ENUM NAME '{' enumValues '}' { $$ = newenum($1, $3, $5); }
    ;

type:         TYPE NAME '{' fields '}' { $$ = newtype("", $2, $4); }
    | COMMENT TYPE NAME '{' fields '}' { $$ = newtype($1, $3, $5); }
    ;

directive:         DIRECTIVE DIRNAME '(' fields ')' ON dirlocs { $$ = newdir("", $2, $4, $7); }
         | COMMENT DIRECTIVE DIRNAME '(' fields ')' ON dirlocs { $$ = newdir($1, $3, $5, $8); }
         ;

fields:
    | fields         NAME              ':' type { $$ = newfield($1, "", $2, NULL, $4); }
    | fields COMMENT NAME              ':' type { $$ = newfield($1, $2, $3, NULL, $5); }
    | fields         NAME '(' args ')' ':' type { $$ = newfield($1, "", $2, $4, $7); }
    | fields COMMENT NAME '(' args ')' ':' type { $$ = newfield($1, $2, $3, $5, $8); }
    ;

type: NAME         { $$ = gettype($1); }
    | '[' type ']' { $$ = newlisttype($2); }
    | type '!'     { $$ = newnonnulltype($1); }

enumValues:
    | enumValues NAME         { $$ = newenumvalue($1, "", $2); }
    | enumValues COMMENT NAME { $$ = newenumvalue($1, $2, $3); }
    ;

/* directive locations */
dirlocs: DIRLOC             { $$ = newdirloc(NULL, $1); }
       | dirlocs '|' DIRLOC { $$ = newdirloc($1, $3); }
       ;
