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

@([_A-Za-z][_0-9A-Za-z]*) { yylval.str = strdup(yytext); return DIRECTIVE_NAME; }

[_A-Za-z][_0-9A-Za-z]* { yylval.str = strdup(yytext); return NAME; }

[ \t\n,]  { /* ignore whitespace, newlines and commas */ }

. {  yyerror("Mystery character '%c'\n", *yytext); }

"LOCATION_QUERY"                  { yylval.dirloc = DIRECTIVE_LOCATION_QUERY; return DIRECTIVE_LOCATION; }
"LOCATION_MUTATION"               { yylval.dirloc = DIRECTIVE_LOCATION_MUTATION; return DIRECTIVE_LOCATION; }
"LOCATION_SUBSCRIPTION"           { yylval.dirloc = DIRECTIVE_LOCATION_SUBSCRIPTION; return DIRECTIVE_LOCATION; }
"LOCATION_FIELD"                  { yylval.dirloc = DIRECTIVE_LOCATION_FIELD; return DIRECTIVE_LOCATION; }
"LOCATION_FRAGMENT_DEFINITION"    { yylval.dirloc = DIRECTIVE_LOCATION_FRAGMENT_DEFINITION; return DIRECTIVE_LOCATION; }
"LOCATION_FRAGMENT_SPREAD"        { yylval.dirloc = DIRECTIVE_LOCATION_FRAGMENT_SPREAD; return DIRECTIVE_LOCATION; }
"LOCATION_INLINE_FRAGMENT"        { yylval.dirloc = DIRECTIVE_LOCATION_INLINE_FRAGMENT; return DIRECTIVE_LOCATION; }
"LOCATION_SCHEMA"                 { yylval.dirloc = DIRECTIVE_LOCATION_SCHEMA; return DIRECTIVE_LOCATION; }
"LOCATION_SCALAR"                 { yylval.dirloc = DIRECTIVE_LOCATION_SCALAR; return DIRECTIVE_LOCATION; }
"LOCATION_OBJECT"                 { yylval.dirloc = DIRECTIVE_LOCATION_OBJECT; return DIRECTIVE_LOCATION; }
"LOCATION_FIELD_DEFINITION"       { yylval.dirloc = DIRECTIVE_LOCATION_FIELD_DEFINITION; return DIRECTIVE_LOCATION; }
"LOCATION_ARGUMENT_DEFINITION"    { yylval.dirloc = DIRECTIVE_LOCATION_ARGUMENT_DEFINITION; return DIRECTIVE_LOCATION; }
"LOCATION_INTERFACE"              { yylval.dirloc = DIRECTIVE_LOCATION_INTERFACE; return DIRECTIVE_LOCATION; }
"LOCATION_UNION"                  { yylval.dirloc = DIRECTIVE_LOCATION_UNION; return DIRECTIVE_LOCATION; }
"LOCATION_ENUM"                   { yylval.dirloc = DIRECTIVE_LOCATION_ENUM; return DIRECTIVE_LOCATION; }
"LOCATION_ENUM_VALUE"             { yylval.dirloc = DIRECTIVE_LOCATION_ENUM_VALUE; return DIRECTIVE_LOCATION; }
"LOCATION_INPUT_OBJECT"           { yylval.dirloc = DIRECTIVE_LOCATION_INPUT_OBJECT; return DIRECTIVE_LOCATION; }
"LOCATION_INPUT_FIELD_DEFINITION" { yylval.dirloc = DIRECTIVE_LOCATION_INPUT_FIELD_DEFINITION; return DIRECTIVE_LOCATION; }

%%
