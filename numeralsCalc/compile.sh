bison -d roman.y
flex roman.l
gcc roman.tab.c lex.yy.c fb3-1funcs.c
