.PHONY: meta
meta: meta.l meta.y metafuncs.c
	bison -d meta.y
	flex -o meta.lex.c meta.l
	cc -o $@ -g meta.tab.c meta.lex.c metafuncs.c -ll

