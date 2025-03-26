%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <stdbool.h>

    int yylex();
    void yyerror(const char* s);
    bool error = false;
    int linea = 0;

    void print_result() {
        // printf("Código exitoso\n");
    }
%}

%union {
    int num;
    char* str;
}

%token EOL
%token<str> IDENT
%token<num> NUMBER
%token TRUE FALSE
%token IF ELSE AND OR NOT LPAREN RPAREN LBRACE RBRACE SEMICOLON LET
%token EQ NEQ LT GT LTE GTE ASSIGN

%left AND OR
%left PLUS MINUS
%left MULTP DIV
%right NOT

%type<num> exp condition
%type<str> variable

%%

input:
    | line input
    | EOL input
    ;


variable:
    IDENT { $$ = strdup($1); }
    ;

line:
    variable ASSIGN exp SEMICOLON EOL { free($1); }
    | exp SEMICOLON EOL { print_result(); }
    | if_statement EOL { print_result(); }
    | let_declaration EOL { print_result(); }
    ;

if_statement:
    IF LPAREN condition RPAREN block
    | IF condition block
    | IF LPAREN condition RPAREN block ELSE block
    | IF condition block ELSE block
    ;

block:
    LBRACE exp SEMICOLON RBRACE
    | LBRACE input RBRACE
    ;

let_declaration: 
    LET IDENT ASSIGN exp SEMICOLON 
    ;

condition:
    condition AND condition { $$ = $1 && $3; }
    | condition OR condition { $$ = $1 || $3; }
    | NOT condition { $$ = !$2; }
    | TRUE { $$ = 1; }
    | FALSE { $$ = 0; }
    | exp EQ exp { $$ = $1 == $3; }
    | exp NEQ exp { $$ = $1 != $3; }
    | exp LT exp { $$ = $1 < $3; }
    | exp GT exp { $$ = $1 > $3; }
    | exp LTE exp { $$ = $1 <= $3; }
    | exp GTE exp { $$ = $1 >= $3; }
    | exp { $$ = $1; }
    ;

exp:
    NUMBER { $$ = $1; }
    | exp PLUS exp { $$ = $1 + $3; }
    | exp MINUS exp { $$ = $1 - $3; }
    | exp MULTP exp { $$ = $1 * $3; }
    | exp DIV exp { $$ = $1 / $3; }
    | LPAREN exp RPAREN { $$ = $2; }
    | IDENT { free($1); $$ = 0; }
    | IDENT ASSIGN exp { free($1); }
    ;

%%

int main() {
    yyparse();
    if(!error) {
        printf("Código exitoso\n");
    }
    printf("Líneas: %d\n", linea);
    return 0;
}

void yyerror(const char* s) {
    error = true;
    printf("ERROR en la línea: %d\n", linea);
}
