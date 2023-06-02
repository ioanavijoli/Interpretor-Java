/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    CLASS = 258,
    PUBLIC = 259,
    STATIC = 260,
    VOID = 261,
    MAIN = 262,
    IF = 263,
    ELSE = 264,
    WHILE = 265,
    EXTENDS = 266,
    INTEGER = 267,
    BOOLEAN = 268,
    STRING = 269,
    TRUE = 270,
    FALSE = 271,
    ID = 272,
    INTEGER_LITERAL = 273,
    AND = 274,
    THIS = 275,
    NEW = 276,
    PRINTLN = 277,
    LENGTH = 278,
    RETURN = 279,
    RBRACE = 280,
    RACCESS = 281,
    LBRACKET = 282,
    RBRACKET = 283,
    SEMICOLON = 284,
    COMMA = 285,
    LACCESS = 286,
    LBRACE = 287
  };
#endif
/* Tokens.  */
#define CLASS 258
#define PUBLIC 259
#define STATIC 260
#define VOID 261
#define MAIN 262
#define IF 263
#define ELSE 264
#define WHILE 265
#define EXTENDS 266
#define INTEGER 267
#define BOOLEAN 268
#define STRING 269
#define TRUE 270
#define FALSE 271
#define ID 272
#define INTEGER_LITERAL 273
#define AND 274
#define THIS 275
#define NEW 276
#define PRINTLN 277
#define LENGTH 278
#define RETURN 279
#define RBRACE 280
#define RACCESS 281
#define LBRACKET 282
#define RBRACKET 283
#define SEMICOLON 284
#define COMMA 285
#define LACCESS 286
#define LBRACE 287

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 11 "java_compiler.y"

    struct Node* node;
    double d;

#line 126 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
