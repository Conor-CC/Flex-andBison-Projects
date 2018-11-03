%{
#  include <stdio.h>
#  include <stdlib.h>
void yyerror(char *s);
int yylex();
int yyparse();
%}
%output "roman.tab.c"

%token I II III IV V IX X XL L XC C CD D CM M EOL
%%

calclist:  {}
 | calclist thousands fiveHuns hundred fifty ten five ones EOL { int sum = 0;
                                                                 sum += $2 + $3 + $4 + $5 + $6 + $7 + $8;
                                                                 if (sum != 0)
                                                                    printf("%d\n", sum);
                                                                }
 ;

ones: {$$ = 0;}
 | I {$$ = 1;}
 | I I {$$ = 2;}
 | I I I {$$ = 3;}
 | I V {$$ = 4;}
 | I X {$$ = 9;}
 ;

five: {$$ = 0;}
 | V {$$ = 5;}
 ;

ten: {$$ = 0;}
 | X {$$ = 10;}
 | X X {$$ = 20;}
 | X X X {$$ = 30;}
 | X L {$$ = 40;}
 | X C {$$ = 90;}
 ;

fifty: {$$ = 0;}
 | L {$$ = 50;}
 ;

hundred: {$$ = 0;}
 | C {$$ = 100;}
 | C C {$$ = 200;}
 | C C C {$$ = 300;}
 | C D {$$ = 400;}
 | C M {$$ = 900;}
 ;

fiveHuns: {$$ = 0;}
 | D {$$ = 500;}
 ;

thousands: {$$ = 0;}
 | M thousands {$$ = $2 + 1000;}
 ;

%%
void yyerror(char *s)
{
  printf("%s\n", s);
}


int main()
{
//  yydebug = 1;
        yyparse();
        return 0;
}
