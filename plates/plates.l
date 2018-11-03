YEAR_87to99         [8|9][0-9]
YEAR_00to12         [0][0-9]|[1][0-2]
YEAR_13             [1][3][1|2]
YEAR_14to18         [1][4-8][1|2]
COUNTY_14to18       C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|W|WH|WX|WW
COUNTY_87to13       C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LK|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|WD|WH|WX|WW
NUM                 [1-9][0-9]{0,5}

%{

  #include <stdio.h>

%}


%%
[\r\n\t\" "]+                               {}
{YEAR_87to99}\-{COUNTY_87to13}\-{NUM}     {char c[2] = {yytext[0], yytext[1]}; int x = atoi(c); printf("%d\n", (2018 - (1900 + x))); }
{YEAR_00to12}\-{COUNTY_87to13}\-{NUM}     {char c[2] = {yytext[0], yytext[1]}; int x = atoi(c); printf("%d\n", (2018 - (2000 + x))); }
{YEAR_13}\-{COUNTY_14to18}\-{NUM}         {char c[2] = {yytext[0], yytext[1]}; int x = atoi(c); printf("%d\n", (2018 - (2000 + x))); }
{YEAR_14to18}\-{COUNTY_14to18}\-{NUM}     {char c[2] = {yytext[0], yytext[1]}; int x = atoi(c); printf("%d\n", (2018 - (2000 + x))); }
[^\r^\n^\t^" "]+                                        {printf("INVALID\n");}

%%

int main(int argc, char const *argv[]) {
  yylex();
  return 0;
}
