%option noyywrap nodefault yylineno
%{
#include "meta.h"
#include "meta.tab.h"
%}

%%

^[ \t]*"#"[ \t]*([^ \t].*) { yylval.comment = yytext; return COMMENT; }

\"(\\.|[^"])*\"  { yylval.str = yytext; return STR; }

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

[_A-Za-z][_0-9A-Za-z]* { yylval.name = yytext; return NAME; }

[ \t\n,]  { /* ignore whitespace, newlines and commas */ }

. {  yyerror("Mystery character '%c'\n", *yytext); }

%%
