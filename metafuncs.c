#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "meta.h"

int yyparse();

void yyerror(char *s, ...) {
    va_list ap;
    va_start(ap, s);

    fprintf(stderr, "%d: error: ", yylineno);
    vfprintf(stderr, s, ap);
    fprintf(stderr, "\n");
}

int main() {
    return yyparse();
}
