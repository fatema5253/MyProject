%{
#include<stdio.h>
#include "y.tab.h"
void yyerror(char *);
%}
DIGIT    [0-9]
%%
{DIGIT}+|{DIGIT}+"."{DIGIT}*|"."{DIGIT}*|"-"{DIGIT}+|"-"{DIGIT}*"."{DIGIT}*|"+"{DIGIT}+|"+"{DIGIT}+"."{DIGIT}+ {
	yylval.real=(float)atof(yytext);
	return NUM;
}
[a] {yylval.real=1.0; return M;}
[b] {yylval.real=1.0; return CM;}
[c] {yylval.real=1.0; return FEET;}
[d] {yylval.real=1.0; return IN;}
[e] {yylval.real=1.0; return KM;}
from {return from;}
to {return to;}
[\n] return *yytext;
[\t] ;
. yyerror("Invalid Character");

    
%%
int yywrap() {return 1;}
