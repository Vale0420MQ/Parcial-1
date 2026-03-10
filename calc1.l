%{
#include <stdio.h>
#include <stdlib.h>
#include "calculadora.tab.h"
%}
/* se utiliza atof para que reconosca los numeros reales y se implementa el token de la raiz */
/* reconocer tokens para la calculadora y devolverlos */
%%
"+"    { return ADD; }
"-"    { return SUB; }
"*"    { return MUL; }
"/"    { return DIV; }
"|"    { return ABS; }
"!"    { return SQRT; }
[0-9]+(\.[0-9]+)? { yylval = atof(yytext); return NUMBER; }
\n     { return EOL; }
[ \t]  { } /* ignora espacios y tabulaciones */
.      { printf("Mystery character %s\n", yytext); }
%%
