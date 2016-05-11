%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include <unistd.h>
void yyerror(char *); 
extern char * yytext;

void changedir(char *);

%}

%union {
	char *sval;
}

%token <sval> COMANDO
%token <sval> ARGUMENTO
%token <sval> CHDIR
%token FIM_COMANDO
%token QUIT
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
	| CHDIR ARGUMENTO FIM_COMANDO {
            						changedir($2);
								 }
	| QUIT FIM_COMANDO { printf("\n"); exit(EXIT_SUCCESS);  }
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

void changedir(char *id) {
  char currentDir[1024];
  char result[2048];
  if (getcwd(currentDir, sizeof(currentDir)) == NULL) {
    perror("Error in cd() getcwd()");
  }
  sprintf(result, "%s/%s", currentDir, id);
  if(chdir(result) != 0) {
    fprintf(stderr, "Error in cd() chdir()\n");
  }
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
