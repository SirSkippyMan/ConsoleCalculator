/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
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
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_CALC_TAB_H_INCLUDED
# define YY_YY_CALC_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    NUM = 258,                     /* NUM  */
    PLUS = 259,                    /* PLUS  */
    MINUS = 260,                   /* MINUS  */
    TIMES = 261,                   /* TIMES  */
    DIV = 262,                     /* DIV  */
    EXP = 263,                     /* EXP  */
    LBRACKET = 264,                /* LBRACKET  */
    RBRACKET = 265,                /* RBRACKET  */
    NEWLINE = 266,                 /* NEWLINE  */
    EXITCMD = 267,                 /* EXITCMD  */
    HELPCMD = 268,                 /* HELPCMD  */
    SQRT = 269,                    /* SQRT  */
    SIN = 270,                     /* SIN  */
    COS = 271,                     /* COS  */
    TAN = 272,                     /* TAN  */
    CSC = 273,                     /* CSC  */
    SEC = 274,                     /* SEC  */
    COT = 275,                     /* COT  */
    ASIN = 276,                    /* ASIN  */
    ACOS = 277,                    /* ACOS  */
    ATAN = 278,                    /* ATAN  */
    ACSC = 279,                    /* ACSC  */
    ASEC = 280,                    /* ASEC  */
    ACOT = 281,                    /* ACOT  */
    RAD = 282,                     /* RAD  */
    DEG = 283,                     /* DEG  */
    MOD = 284,                     /* MOD  */
    ROUND = 285,                   /* ROUND  */
    FLOOR = 286,                   /* FLOOR  */
    CEIL = 287,                    /* CEIL  */
    FACT = 288,                    /* FACT  */
    ABS = 289,                     /* ABS  */
    LOG = 290,                     /* LOG  */
    LN = 291,                      /* LN  */
    COMMA = 292,                   /* COMMA  */
    MIN = 293,                     /* MIN  */
    MAX = 294,                     /* MAX  */
    RAND = 295,                    /* RAND  */
    RANDINT = 296,                 /* RANDINT  */
    ROOT = 297,                    /* ROOT  */
    UMINUS = 298                   /* UMINUS  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 41 "calc.y"

    double val;

#line 111 "calc.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_CALC_TAB_H_INCLUDED  */
