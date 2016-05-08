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
%start linhas


%%
linhas : linha | linhas linha 
 ;

linha : instrucao 
 ;

instrucao: COMANDO  { system($1); } | COMANDO ARGUMENTO { printf("passei aqui 2\n"); 
														char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+1));
                                						strcpy(s,$1); 
                                						strcat(s," ");
                                						strcat(s,$2);
                                						printf(">>>COMANDO %s\n",s);
                                						system(s);
														}
 ;

%%
int main(int argc, char **argv)
{
 return yyparse();
}

/* função usada pelo bison para dar mensagens de erro */
void yyerror(char *msg)
{
 fprintf(stderr, "erro: %s \n", msg);
}

void nometerminal(){
	FILE *ls = popen("pwd", "r");
	char buf[256];	
	fgets(buf, sizeof(buf), ls);
	pclose(ls);
	strtok(buf, "\n");
	printf("CaioShell:%s>>",buf );
}