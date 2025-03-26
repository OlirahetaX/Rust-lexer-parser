%{
    #include "parser.tab.h"
    extern int linea;
%}

%%

"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MULTP; }
"/" { return DIV; }
"&&" { return AND; }
"||" { return OR; }
"!" { return NOT; }
"if" { return IF; }
"else" { return ELSE; }
"true" { return TRUE; }
"false" { return FALSE; }
"(" { return LPAREN; }
")" { return RPAREN; }
"{" { return LBRACE; }
"}" { return RBRACE; }
";" { return SEMICOLON; }
"=" { return ASSIGN; }
"==" { return EQ; }
"!=" { return NEQ; }
"<" { return LT; }
">" { return GT; }
"<=" { return LTE; }
">=" { return GTE; }
"let" { return LET; }
\n { linea++; return EOL; }
[ \t\r]+ ;
"//".* ;
[0-9]+ { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return IDENT; }
. { printf("Caracter no reconocido: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

