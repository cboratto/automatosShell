%{
 #include "shellcomp.tab.h" 
%}
%option noyywrap
%%
(ls|ps)  { yylval.sval = strdup(yytext); return COMANDO; } 
[a-z]+\s+[/a-z\.]+ { yylval.sval = strdup(yytext); return ARGUMENTO; } 
"\n" ;
%%
