
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     T_IDENTIFIER = 258,
     T_STRINGLITERAL = 259,
     T_FUNCTION = 260,
     T_BUILTIN = 261,
     T_SC = 262,
     T_CMA = 263,
     T_LRB = 264,
     T_LCB = 265,
     T_RCB = 266,
     T_LSB = 267,
     T_RSB = 268,
     T_QU = 269,
     T_COL = 270,
     T_LOG_OR = 271,
     T_LOG_AND = 272,
     T_OR = 273,
     T_XOR = 274,
     T_AND = 275,
     T_EQUALITY_OP = 276,
     T_REL_OP = 277,
     T_SHIFT_OP = 278,
     T_MULT = 279,
     T_DIV = 280,
     T_REM = 281,
     T_TILDE = 282,
     T_NOT = 283,
     T_INCDEC = 284,
     T_ADDSUB_OP = 285,
     T_ASSIGN_OPER = 286,
     T_EQ = 287,
     T_LDPB = 288,
     T_RDPB = 289,
     T_LDSB = 290,
     T_RDSB = 291,
     T_DOTS = 292,
     T_INT_CONST = 293,
     T_FLOAT_CONST = 294,
     T_WHILE = 295,
     T_DO = 296,
     T_FOR = 297,
     T_RETURN = 298,
     T_DONE = 299,
     T_UNTIL = 300,
     T_IF = 301,
     T_FI = 302,
     T_THEN = 303,
     T_ELIF = 304,
     T_CASE = 305,
     T_ESAC = 306,
     T_IN = 307,
     T_DSC = 308,
     T_DOLLAR = 309,
     T_AT = 310,
     T_RRB = 311,
     T_ELSE = 312
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


