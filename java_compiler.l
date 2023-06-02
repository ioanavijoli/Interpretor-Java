%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tree.h"
#include "y.tab.h"

int lineNumber;
%}

%option noyywrap

%%
"class"                       { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return CLASS; }
"public"                      { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return PUBLIC; }
"static"                      { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return STATIC; }
"void"                        { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return VOID; }
"main"                        { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return MAIN; }
"if"                          { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return IF; }
"else"                        { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return ELSE; }
"while"                       { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return WHILE; }
"extends"                     { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return EXTENDS; }
"int"                         { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return INTEGER; }
"boolean"                     { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return BOOLEAN; }
"String"                      { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return STRING; }
"true"                        { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return TRUE; }
"false"                       { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return FALSE; }
"this"                        { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return THIS; }
"new"                         { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return NEW; }
"System.out.println"          { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return PRINTLN; }
"length"                      { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return LENGTH; }
"return"                      { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return RETURN; }
[a-zA-Z]([a-zA-Z]|[0-9]|"_")* { 
                                char *val = (char*)malloc(strlen("IDENTIFIER: ")+strlen(yytext)+10);
                                yylval.node = tree_node(val, 0);
                                yylval.node->line = lineNumber;
                                return ID;
                              }
[1-9]([0-9])*                 { 
                                char *val = (char*)malloc(strlen("INTEGERLITERAL: ")+strlen(yytext)+10);
                                yylval.node = tree_node(val, 0); 
                                yylval.node->line = lineNumber;
                                return INTEGER_LITERAL;
                              }
"0"([0-8])*                   { 
                                char *val = (char*)malloc(strlen("INTEGERLITERAL: ")+strlen(yytext)+10);
                                yylval.node = tree_node(val, 0); 
                                yylval.node->line = lineNumber;
                                return INTEGER_LITERAL; 
                              }

"&&"  { return AND; }
"."   { return '.'; }
"="   { return '='; }
"+"   { return '+'; }
"-"   { return '-'; }
"*"   { return '*'; }
"<"   { return '<'; }
">"   { return '>'; }
"!"   { return '!'; }

"{"   { return LBRACE; }
"}"   { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return RBRACE; }
"["   { return LACCESS; }
"]"   { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return RACCESS; }
"("   { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return LBRACKET; }
")"   { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return RBRACKET; }
";"   { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return SEMICOLON; }
","   { yylval.node = tree_node(yytext, 0); yylval.node->line = lineNumber; return COMMA; }

"//".*"\n"         { lineNumber++; }
"/*"(.|"\n")*"*\\" { lineNumber++; }
" "|"\t"|"\r"      { }
"\n"               { lineNumber++; }
.                  { fprintf(stderr, "Unknown word."); }

%%
