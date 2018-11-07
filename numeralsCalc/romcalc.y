/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/fb1-5.y,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */

/* simplest version of calculator */

%{
#include <stdio.h>
#include <string.h>
int yylex();
void yyerror(char *s);
%}

/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL OPEN CLOSE
%token I V X L C D M
%%



calclist: /* nothing */
 | calclist exp EOL
  {
    if ($2 == 0) {
        printf("Z\n");
    }
    else {
        int check = 0;
        if ($2 < 0) {
            $2 = 0 - $2;
            check = 1;
        }
        int num = $2;
        int decimal[] = {1000,900,500,400,100,90,50,40,10,9,5,4,1}; //base values
        char *symbol[] = {"M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"};  //roman symbols
        int i = 0;
        if (check == 1)
            printf("-");
        while(num){ //repeat process until num is not 0
            while(num/decimal[i]){  //first base value that divides num is largest base value
                printf("%s", symbol[i]);    //print roman symbol equivalent to largest base value
                num -= decimal[i];  //subtract largest base value from num
            }
            i++;    //move to next base value to divide num
        }
        printf("\n");
      }
  }
 ;

exp: factor
 | exp ADD factor  { $$ = $1 + $3; }
 | exp SUB factor  { $$ = $1 - $3; }
 ;

factor: brackets
 | factor MUL brackets { $$ = $1 * $3; }
 | factor DIV brackets { $$ = $1 / $3; }
 ;


brackets: romanCalcList
 | OPEN exp CLOSE { $$ = $2; }
 ;


romanCalcList: thousands fiveHuns hundred fifty ten five ones  { $$ = $1 + $2 + $3 + $4 + $5 + $6 + $7; }
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

int main()
{
  yyparse();
  return 0;
}

void yyerror(char *s)
{
  fprintf(stderr, "%s\n", s);
}
