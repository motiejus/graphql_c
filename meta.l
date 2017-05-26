%option noyywrap nodefault yylineno
%{
#include "meta.h"
#include "meta.tab.h"
%}

%%

^[ \t]*"#"[ \t]*([^ \t].*) { yylval.str = strdup(yytext); return COMMENT; }

\"(\\.|[^"])*\"  { yylval.str = strdup(yytext); return STR; }

"scalar"    { return SCALAR; }
"type"      { return TYPE; }
"directive" { return DIRECTIVE; }
"enum"      { return ENUM; }
"on"        { return ON; }

"{" |
"}" |
"(" |
")" |
"[" |
"]" |
"=" |
"!" |
"|" |
"@" |
":" { return yytext[0]; }

@[_A-Za-z][_0-9A-Za-z]* { yylval.str = strdup(yytext); return DIRNAME; }
[_A-Za-z][_0-9A-Za-z]* { yylval.str = strdup(yytext); return NAME; }

[ \t\n,]  { /* ignore whitespace, newlines and commas */ }

"LOCATION_QUERY"                  { yylval.dirloc = DIRLOC_QUERY; return DIRLOC; }
"LOCATION_MUTATION"               { yylval.dirloc = DIRLOC_MUTATION; return DIRLOC; }
"LOCATION_SUBSCRIPTION"           { yylval.dirloc = DIRLOC_SUBSCRIPTION; return DIRLOC; }
"LOCATION_FIELD"                  { yylval.dirloc = DIRLOC_FIELD; return DIRLOC; }
"LOCATION_FRAGMENT_DEFINITION"    { yylval.dirloc = DIRLOC_FRAGMENT_DEFINITION; return DIRLOC; }
"LOCATION_FRAGMENT_SPREAD"        { yylval.dirloc = DIRLOC_FRAGMENT_SPREAD; return DIRLOC; }
"LOCATION_INLINE_FRAGMENT"        { yylval.dirloc = DIRLOC_INLINE_FRAGMENT; return DIRLOC; }
"LOCATION_SCHEMA"                 { yylval.dirloc = DIRLOC_SCHEMA; return DIRLOC; }
"LOCATION_SCALAR"                 { yylval.dirloc = DIRLOC_SCALAR; return DIRLOC; }
"LOCATION_OBJECT"                 { yylval.dirloc = DIRLOC_OBJECT; return DIRLOC; }
"LOCATION_FIELD_DEFINITION"       { yylval.dirloc = DIRLOC_FIELD_DEFINITION; return DIRLOC; }
"LOCATION_ARGUMENT_DEFINITION"    { yylval.dirloc = DIRLOC_ARGUMENT_DEFINITION; return DIRLOC; }
"LOCATION_INTERFACE"              { yylval.dirloc = DIRLOC_INTERFACE; return DIRLOC; }
"LOCATION_UNION"                  { yylval.dirloc = DIRLOC_UNION; return DIRLOC; }
"LOCATION_ENUM"                   { yylval.dirloc = DIRLOC_ENUM; return DIRLOC; }
"LOCATION_ENUM_VALUE"             { yylval.dirloc = DIRLOC_ENUM_VALUE; return DIRLOC; }
"LOCATION_INPUT_OBJECT"           { yylval.dirloc = DIRLOC_INPUT_OBJECT; return DIRLOC; }
"LOCATION_INPUT_FIELD_DEFINITION" { yylval.dirloc = DIRLOC_INPUT_FIELD_DEFINITION; return DIRLOC; }

. {  yyerror("Mystery character '%c'\n", *yytext); }

%%
