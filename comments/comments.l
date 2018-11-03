%{



%}

%%

\"[^\"]*\"  {printf("%s", yytext);}
\{[^/}]*\}  {}
\*\*[^\n]*  {}
\}          {printf("syntax error\n"); return -1;}
\{          {printf("syntax error\n"); return -1;}
\"          {return -1;}

%%

int main() {
    yylex();
    return 0;
}
