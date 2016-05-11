%{
 #include "shellcomp.tab.h" 
 
%}
%option noyywrap
%%
"cd" { yylval.sval = strdup(yytext); return CHDIR; }
(ls|ps|touch|ifconfig|mkdir|kill|start|rmdir)  { yylval.sval = strdup(yytext); return COMANDO; } 
[a-zA-Z0-9/\.]+			{ yylval.sval = strdup(yytext); return ARGUMENTO;}
"\n" {nometerminal(); return FIM_COMANDO;} 
;
%%
