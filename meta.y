%{
#include <stdio.h>
#include <stdlib.h>
#include "meta.h"
int yylex();
%}

%parse-param{t_document* doc}

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
    | document type      { /* types are added to the doc via global variable below */ }
    | document directive { $$ = adddirective($1, $2); }
    ;

scalar:         SCALAR NAME { $$ = newscalar(doc, "", $2); }
      | COMMENT SCALAR NAME { $$ = newscalar(doc, $1, $2); }
      ;

enum:         ENUM NAME '{' enumValues '}' { $$ = newenum(doc, $2, $4, ""); }
    | COMMENT ENUM NAME '{' enumValues '}' { $$ = newenum(doc, $1, $3, $5); }
    ;

type:         TYPE NAME '{' fields '}' { $$ = newtype(doc, "", $2, $4); }
    | COMMENT TYPE NAME '{' fields '}' { $$ = newtype(doc, $1, $3, $5); }
    ;

directive:         DIRECTIVE DIRNAME '(' fields ')' ON dirlocs { $$ = newdir("", $2, $4, $7); }
         | COMMENT DIRECTIVE DIRNAME '(' fields ')' ON dirlocs { $$ = newdir($1, $3, $5, $8); }
         ;

fields:
    | fields         NAME              ':' fieldType { $$ = newfield($1, "", $2, NULL, $4); }
    | fields COMMENT NAME              ':' fieldType { $$ = newfield($1, $2, $3, NULL, $5); }
    | fields         NAME '(' args ')' ':' fieldType { $$ = newfield($1, "", $2, $4, $7); }
    | fields COMMENT NAME '(' args ')' ':' fieldType { $$ = newfield($1, $2, $3, $5, $8); }
    ;

fieldType: NAME              { $$ = gettype(doc, $1); }
         | '[' fieldType ']' { $$ = list($2); }
         | fieldType '!'     { $$ = nonnull($1); }

enumValues:
    | enumValues NAME         { $$ = newenumvalue($1, "", $2); }
    | enumValues COMMENT NAME { $$ = newenumvalue($1, $2, $3); }
    ;

/* directive locations */
dirlocs: DIRLOC             { $$ = newdirloc(NULL, $1); }
       | dirlocs '|' DIRLOC { $$ = newdirloc($1, $3); }
       ;
