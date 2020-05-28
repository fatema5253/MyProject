%{
#include<stdio.h>
#include<math.h>
int yylex(void);
void yyerror(char *);
%}

%union{
int integer;
float real;
}

%token <real> NUM M CM FEET IN KM 
%token from D to
%type <real> S F1 F2 F3 F4 F5 T 
%%
S : from T NUM {$$=$2*$3;printf(" Answer is : %f",$$);};
T:
	M to F1{$$=$1*$3;}
	|CM to F2{$$=$1*$3;} 
	|FEET to F3{$$=$1*$3;}
	|IN to F4{$$=$1*$3;}
	|KM to F5{$$=$1*$3;}
	;
F1:
	CM{$$=$1*100;}
	|FEET{$$=$1*3.281;}
	|IN{$$=($1/2.54)*100;}
	|KM{$$=$1*1000;}
	|M{$$=$1*1;}
	;

F2:
	M{$$=$1/100;}
	|CM{$$=$1*1;}
	|FEET{$$=$1/30.48;}
	|IN{$$=$1/2.54;}
	|KM{$$=$1/0.00001;}
	;


F3:
	M{$$=$1/3.281;}
	|CM{$$=$1*30.48;}
	|FEET{$$=$1*1;}
	|IN{$$=$1*12;}
	|KM{$$=$1/3281;}
	;

F4:
	M{$$=($1*2.54)/100;}
	|CM{$$=$1*2.54;}
	|FEET{$$=$1/12;}
	|IN{$$=$1*1;}
	|KM{$$=$1/39370;}
	;


F5:
	M{$$=$1*1000;}
	|CM{$$=$1*100000;}
	|FEET{$$=$1*3281;}
	|IN{$$=$1*39370;}
	|KM{$$=$1*1;}
	;
%% 
void yyerror(char *s)
{
	fprintf(stderr,"%s\n",s);
	return;
}
int main(int argc,char *argv[])
{
printf("UNIT CONVERTOR (LENGTH)\n");
printf("OPTION AVAILABLE\n a)METERS\n b)CENTIMETERS \n c)FEET\n d)INCHES\n e)KILOMETERS\n");
printf("Write <<from option(a-e) to option(a-e) your length to be converted>>\n");
printf("for example for converting meters to feet you have to write 'from a to c 50' \n"); 

int m=0;
printf("Enter number of times you want to use this Unit Converter\n");
scanf("%d\n",&m);
for(int i=0;i<m*2;i++){
yyparse();
}
return 0;
}

