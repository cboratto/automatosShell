%{
 #include "shellcomp.tab.h"
%}
%option noyywrap
%%
ls yylval = atoi(yytext); return COMANDO;

[ \t] ; /* ignora espaços e tabs (\t) */
 "\n" return FIM_LINHA;
%%