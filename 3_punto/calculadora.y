
%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
int yylex(void);
void yyerror(char *s);

double sqrt_newton(double n)
{
    double x = n;
    double y = 1;
    double e = 0.000001;

    while (x - y > e) {
        x = (x + y) / 2;
        y = n / x;
    }

    return x;
}
%}

%define api.value.type {double}

%token ADD SUB MUL DIV ABS NUMBER SQRT EOL

%%

calclist: /* nothing */
        | calclist exp EOL { printf("= %f\n", $2); }
        ;

exp: factor { $$ = $1; }
    | exp ADD factor { $$ = $1 + $3; }
    | exp SUB factor { $$ = $1 - $3; }
    ;

factor: term { $$ = $1; }
      | factor MUL term { $$ = $1 * $3; }
      | factor DIV term { $$ = $1 / $3; }
      ;


term: NUMBER { $$ = $1; }
    | ABS term { $$ = ($2 < 0) ? -$2 : $2; }
    | SQRT term { $$ = sqrt_newton($2); }
    ;


%%

extern FILE *yyin;

int main(int argc, char **argv)
{
    if (argc > 1)
        yyin = fopen(argv[1], "r");

    yyparse();
}


yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
}
