%{
 #include <stdio.h>
 #include <string.h>
 void yyerror(char *);
%}
%token COMANDO
%token FIM_LINHA
%token ARGUMENTO
%start linha
%%
linha: instrucao FIM_LINHA { system($1); }
 ;
instrucao: COMANDO FIM_LINHA { $$ = $1; }
		 | COMANDO ARGUMENTO FIM_LINHA { $$ = strcat($1, $2); }
 ;
%%
int main(int argc, char **argv)
{
 return yyparse();
}

/* função usada pelo bison para dar mensagens de erro */
void yyerror(char *msg)
{
 fprintf(stderr, "erro: %s\n", msg);
}