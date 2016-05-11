%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
void yyerror(char *); 
extern char * yytext;
%}

%union {
	char *sval;
}

%token <sval> COMANDO
%token <sval> ARGUMENTO
%token FIM_COMANDO
%start linhas


%%
linhas : 
	| linhas instrucao
 ;



instrucao: COMANDO FIM_COMANDO 			{  system($1); } 
	| COMANDO ARGUMENTO FIM_COMANDO 	{ 	char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+1));
	                						strcpy(s,$1); 
	                						strcat(s," ");
	                						strcat(s,$2);                                						
	                						system(s);
										}
	| FIM_COMANDO
 ;

%%
void nometerminal(){
	FILE *ls = popen("pwd", "r");
	char buf[256];	
	fgets(buf, sizeof(buf), ls);
	pclose(ls);
	strtok(buf, "\n");
	printf("CaioShell:%s>>",buf );
}

int main(int argc, char **argv)
{
 nometerminal();
 return yyparse();
}

/* função usada pelo bison para dar mensagens de erro */
void yyerror(char *msg)
{
 fprintf(stderr, "erro: %s \n", msg);
}
