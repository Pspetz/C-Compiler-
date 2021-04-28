# C-Compiler-
Making a compiler with flex and bison for C language





How to run it:
1 - flex calc.l
2 - bison -d bison.y
3 - gcc bison.tab.c lex.yy.c 
4 - ./a.out input
