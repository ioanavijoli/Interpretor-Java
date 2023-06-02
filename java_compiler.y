%{
#include <stdio.h>
#include "tree.h"

extern int lineNumber;

int yylex();
void yyerror(char *s);
%}

%union {
    struct Node* node;
    double d;
}

%token <node> CLASS PUBLIC STATIC VOID MAIN IF ELSE WHILE EXTENDS
%token <node> INTEGER BOOLEAN STRING TRUE FALSE ID INTEGER_LITERAL
%token <node> AND THIS NEW PRINTLN LENGTH RETURN 
%token <node> RBRACE RACCESS LBRACKET RBRACKET
%token <node> SEMICOLON COMMA
%type <node> GOAL MAINCLASS EXTEND_OPERATION IDENTIFIER TYPE
%type <node> CLASS_DECLARATIONS CLASS_DECLARATION_LIST CLASS_DECLARATION
%type <node> VAR_DECLARATIONS VAR_DECLARATION
%type <node> METHOD_DECLARATIONS METHOD_DECLARATION_LIST METHOD_DECLARATION
%type <node> TYPE_IDENTIFIERS TYPE_IDENTIFIER_LIST TYPE_IDENTIFIER
%type <node> STATEMENTS STATEMENT_LIST STATEMENT
%type <node> EXPRESSIONS EXPRESSION_LIST EXPRESSION

%left LACCESS LBRACE
%right '='
%left '.'
%left '*'
%left '+' '-'
%left AND '<' '>'
%right '!'

%start GOAL

%%
GOAL:
    MAINCLASS CLASS_DECLARATIONS 
    {
        $$ = tree_node("GOAL", 2, $1, $2);
        $$->line = lineNumber;
        printf("Syntax tree:\n");
        pretty_print($$, 0);
        
    }
    ;

MAINCLASS:
    CLASS IDENTIFIER LBRACE PUBLIC STATIC VOID MAIN LBRACKET STRING LACCESS RACCESS IDENTIFIER RBRACKET LBRACE STATEMENT RBRACE RBRACE
    {
        $$ = tree_node("MAINCLASS", 17, $1, $2, tree_node("{", 0), $4, $5,
                                       $6, $7, $8, $9, tree_node("[", 0), $11,
                                       $12, $13, tree_node("{", 0), $15, $16,
                                       $17);
        $$->line = lineNumber;
    }
    ;

CLASS_DECLARATION_LIST:
    CLASS_DECLARATION 
    {
        $$ = tree_node("CLASS_DECLARATION_LIST", 1, $1);
        $$->line = lineNumber;
    }
|   CLASS_DECLARATION_LIST CLASS_DECLARATION
    {
        $$ = tree_node("CLASS_DECLARATION_LIST", 2, $1, $2);
        $$->line = lineNumber;
    }
    ;

CLASS_DECLARATIONS:
    {
        $$ = NULL;
    }
|   CLASS_DECLARATION_LIST
    {
        $$ = tree_node("CLASS_DECLARATIONS", 1, $1);
        $$->line = lineNumber;
    }
    ;

CLASS_DECLARATION:
    CLASS IDENTIFIER EXTEND_OPERATION LBRACE VAR_DECLARATIONS METHOD_DECLARATIONS RBRACE
    {
        $$ = tree_node("CLASS_DECLARATION", 7, $1, $2, $3, tree_node("{", 0),
                                             $5, $6, $7);
        $$->line = lineNumber;
    }
    ;

EXTEND_OPERATION:
    {
        $$ = NULL;
    }
|   EXTENDS IDENTIFIER
    {
        $$ = tree_node("EXTEND_OPERATION", 2, $1, $2);
        $$->line = lineNumber;
    }
    ;

VAR_DECLARATIONS:
    {
        $$ = NULL;
    }
|   VAR_DECLARATIONS VAR_DECLARATION
    {
        $$ = tree_node("VAR_DECLARATIONS", 1, $1);
        $$->line = lineNumber;
    }
    ;

VAR_DECLARATION:
    TYPE IDENTIFIER SEMICOLON
    {
        $$ = tree_node("VAR_DECLARATION", 3, $1, $2, $3);
        $$->line = lineNumber;
    }
    ;

METHOD_DECLARATIONS:
    {
        $$ = NULL;
    }
|   METHOD_DECLARATION_LIST
    {
        $$ = tree_node("METHOD_DECLARATIONS", 1, $1);
        $$->line = lineNumber;
    }
    ;

METHOD_DECLARATION_LIST:
    METHOD_DECLARATION
    {
        $$ = tree_node("METHOD_DECLARATION_LIST", 1, $1);
        $$->line = lineNumber;
    }
|   METHOD_DECLARATION_LIST METHOD_DECLARATION
    {
        $$ = tree_node("METHOD_DECLARATION_LIST", 2, $1, $2);
        $$->line = lineNumber;
    }
    ;

METHOD_DECLARATION:
    PUBLIC TYPE IDENTIFIER LBRACKET TYPE_IDENTIFIERS RBRACKET LBRACE VAR_DECLARATIONS STATEMENTS RETURN EXPRESSION SEMICOLON RBRACE
    {
        $$ = tree_node("METHOD_DECLARATION", 13, $1, $2, $3, $4,
                                               $5, $6, tree_node("{", 0),
                                               $8, $9, $10, $11,
                                               $12, $13);
        $$->line = lineNumber;
    }
    ;

TYPE_IDENTIFIERS:
    {
        $$ = NULL;
    }
|   TYPE_IDENTIFIER_LIST
    {
        $$ = tree_node("TYPE_IDENTIFIERS", 1, $1);
        $$->line = lineNumber;
    }
    ;

TYPE_IDENTIFIER_LIST:
    TYPE_IDENTIFIER
    {
        $$ = tree_node("TYPE_IDENTIFIER_LIST", 1, $1);
        $$->line = lineNumber;
    }
|   TYPE_IDENTIFIER_LIST COMMA TYPE_IDENTIFIER
    {
        $$ = tree_node("TYPE_IDENTIFIER_LIST", 3, $1, $2, $3);
        $$->line = lineNumber;
    }
    ;

TYPE_IDENTIFIER:
    TYPE IDENTIFIER
    {
        $$ = tree_node("TypeIdentifer", 2, $1, $2);
        $$->line = lineNumber;
    }
    ;

STATEMENTS:
    {
        $$ = NULL;
    }
|   STATEMENT_LIST
    {
        $$ = tree_node("STATEMENTS", 1, $1);
        $$->line = lineNumber;
    }
    ;

STATEMENT_LIST:
    STATEMENT
    {
        $$ = tree_node("STATEMENT_LIST", 1, $1);
        $$->line = lineNumber;
    }
|   STATEMENT_LIST STATEMENT
    {
        $$ = tree_node("STATEMENT_LIST", 2, $1, $2);
        $$->line = lineNumber;
    }
    ;

TYPE:
    INTEGER
    {
        $$ = tree_node("TYPE", 1, $1);
        $$->line = lineNumber;
    }
|   INTEGER LACCESS RACCESS
    {
        $$ = tree_node("TYPE", 3, $1, tree_node("[", 0), $3);
        $$->line = lineNumber;
    }
|   BOOLEAN
    {
        $$ = tree_node("TYPE", 1, $1);
        $$->line = lineNumber;
    }
|   STRING
    {
        $$ = tree_node("TYPE", 1, $1);
        $$->line = lineNumber;
    }
    
|   IDENTIFIER
    {
        $$ = tree_node("TYPE", 1, $1);
        $$->line = lineNumber;
    }
    ;

STATEMENT:
    LBRACE STATEMENTS RBRACE
    {
        $$ = tree_node("STATEMENT", 3, tree_node("{", 0), $2, $3);
        $$->line = lineNumber;
    }
|   IF LBRACKET EXPRESSION RBRACKET STATEMENT ELSE STATEMENT
    {
        $$ = tree_node("STATEMENT", 7, $1, $2, $3, $4,
                                      $5, $6, $7);
        $$->line = lineNumber;
    }
|   WHILE LBRACKET EXPRESSION RBRACKET STATEMENT
    {
        $$ = tree_node("STATEMENT", 5, $1, $2, $3, $4,
                                      $5);
        $$->line = lineNumber;
    }
|   PRINTLN LBRACKET EXPRESSION RBRACKET SEMICOLON
    {
        $$ = tree_node("STATEMENT", 5, $1, $2, $3, $4,
                                      $5);
        $$->line = lineNumber;
    }
|   IDENTIFIER '=' EXPRESSION SEMICOLON
    {
        $$ = tree_node("STATEMENT", 4, $1, tree_node("=", 0), $3, $4);
        $$->line = lineNumber;
    }
|   IDENTIFIER LACCESS EXPRESSION RACCESS '=' EXPRESSION SEMICOLON
    {
        $$ = tree_node("STATEMENT", 7, $1, tree_node("[", 0), $3, $4,
                                      tree_node("=", 0), $6, $7);
        $$->line = lineNumber;
    }
    ;

EXPRESSIONS:
    
    {
        $$ = NULL;
    }
|   EXPRESSION_LIST
    {
        $$ = tree_node("EXPRESSIONS", 1, $1);
        $$->line = lineNumber;
    }
    ;

EXPRESSION_LIST:
    EXPRESSION
    {
        $$ = tree_node("EXPRESSION_LIST", 1, $1);
        $$->line = lineNumber;
    }
|   EXPRESSION_LIST COMMA EXPRESSION
    {
        $$ = tree_node("EXPRESSION_LIST", 3, $1, $2, $3);
        $$->line = lineNumber;
    }
    ;

EXPRESSION:
    EXPRESSION AND EXPRESSION
    {
        $$ = tree_node("EXPRESSION", 3, $1, tree_node("$$", 0), $3);
        $$->line = lineNumber;
    }
|   EXPRESSION '<' EXPRESSION
    {
        $$ = tree_node("EXPRESSION", 3, $1, tree_node("<", 0), $3);
        $$->line = lineNumber;
    }
|   EXPRESSION '>' EXPRESSION
    {
        $$ = tree_node("EXPRESSION", 3, $1, tree_node(">", 0), $3);
        $$->line = lineNumber;
    }    
|   EXPRESSION '+' EXPRESSION
    {
        $$ = tree_node("EXPRESSION", 3, $1, tree_node("+", 0), $3);
        $$->line = lineNumber;
    }
|   EXPRESSION '-' EXPRESSION
    {
        $$ = tree_node("EXPRESSION", 3, $1, tree_node("-", 0), $3);
        $$->line = lineNumber;
    }
|   EXPRESSION '*' EXPRESSION
    {
        $$ = tree_node("EXPRESSION", 3, $1, tree_node("*", 0), $3);
        $$->line = lineNumber;
    }
|   EXPRESSION LACCESS EXPRESSION RACCESS
    {
        $$ = tree_node("EXPRESSION", 4, $1, tree_node("[", 0), $3, $4);
        $$->line = lineNumber;
    }
|   EXPRESSION '.' LENGTH
    {
        $$ = tree_node("EXPRESSION", 3, $1, tree_node(".", 0), $3);
        $$->line = lineNumber;
    }
|   EXPRESSION '.' IDENTIFIER LBRACKET EXPRESSIONS RBRACKET
    {
        $$ = tree_node("EXPRESSION", 6, $1, tree_node(".", 0), $3,
                                       $4, $5, $6);
        $$->line = lineNumber;
    }
|   TRUE
    {
        $$ = tree_node("EXPRESSION", 1, $1);
        $$->line = lineNumber;
    }
|   FALSE
    {
        $$ = tree_node("EXPRESSION", 1, $1);
        $$->line = lineNumber;
    }
|   IDENTIFIER
    {
        $$ = tree_node("EXPRESSION", 1, $1);
        $$->line = lineNumber;
    }
|   THIS
    {
        $$ = tree_node("EXPRESSION", 1, $1);
        $$->line = lineNumber;
    }
|   NEW INTEGER LACCESS EXPRESSION RACCESS
    {
        $$ = tree_node("EXPRESSION", 5, $1, $2, tree_node("[", 0), $4, $5);
        $$->line = lineNumber;
    }
|   NEW IDENTIFIER LBRACKET RBRACKET
    {
        $$ = tree_node("EXPRESSION", 4, $1, $2, $3, $4);
        $$->line = lineNumber;
    }
|   '!' EXPRESSION
    {
        $$ = tree_node("EXPRESSION", 2, tree_node("!", 0), $2);
        $$->line = lineNumber;
    }
|   LBRACKET EXPRESSION RBRACKET
    {
        $$ = tree_node("EXPRESSION", 3, $1, $2, $3);
        $$->line = lineNumber;
    }
|   INTEGER_LITERAL
    {
        $$ = tree_node("INTEGER_LITERAL", 1, $1);
        $$->line = lineNumber;
    }
    ;

IDENTIFIER:
    ID
    {
        $$ = tree_node("EXPRESSION", 1, $1);
        $$->line = lineNumber;
    }
    ;

%%
void yyerror(char *s) {
    fprintf(stderr, "line %d: %s \n", lineNumber, s);
}

int main(void) {
    yyparse();
    return 0;
}
