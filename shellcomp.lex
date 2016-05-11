%{
 #include "shellcomp.tab.h" 
 
%}
%option noyywrap
%%
(ls|ps|touch|ifconfig|mkdir)  { yylval.sval = strdup(yytext); return COMANDO; } 
[a-zA-Z0-9/\.]+			{ yylval.sval = strdup(yytext); return ARGUMENTO;}
"\n" {nometerminal(); return FIM_COMANDO;} 
;
%%
