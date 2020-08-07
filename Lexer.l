%{  
#include <string.h>
#include <stdlib.h>
#include "Parser.tab.h"
int n = 0 ;   
int token=0;
int attribute=0; 


%}  
  

%%  
"while" {n++;return T_WHILE; }
"if" {n++;return T_IF;}
"else" {n++;return T_ELSE;}
"for" {n++;return T_FOR;}
"until" {n++;return T_UNTIL;}
"do" {n++;return T_DO;}
"done" {n++;return T_DONE;}
"elif" {n++;return T_ELIF;}
"then" {n++;return T_THEN;}
"case" {n++;return T_CASE;}
"esac" {n++;return T_ESAC;}
"fi" {n++;return T_FI;}
"function" {n++;return T_FUNCTION;}
"in" {n++;return T_IN;}
"time" {n++;return T_BUILTIN;}
"select" {n++;return T_BUILTIN;}  
"alias" {n++;return T_BUILTIN;}  
"bind" {n++;return T_BUILTIN;} 
"builtin" {n++;return T_BUILTIN;} 
"caller" {n++;return T_BUILTIN;} 
"command" {n++;return T_BUILTIN;} 
"echo"  {n++;return T_BUILTIN;} 
"enable" {n++;return T_BUILTIN;} 
"help" {n++;return T_BUILTIN;} 
"local" {n++;return T_BUILTIN;} 
"logout" {n++;return T_BUILTIN;}
"mapfile" {n++;return T_BUILTIN;} 
"printf" {n++;return T_BUILTIN;} 
"read" {n++;return T_BUILTIN;} 
"readarray" {n++;return T_BUILTIN;} 
"source" {n++;return T_BUILTIN;} 
"type" {n++;return T_BUILTIN;} 
"typeset" {n++;return T_BUILTIN;} 
"ulimit" {n++;return T_BUILTIN;} 
"unalias" {n++;return T_BUILTIN;} 
"break" {n++;return T_BUILTIN;} 
"cd" {n++;return T_BUILTIN;} 
"continue" {n++;return T_BUILTIN;} 
"eval" {n++;return T_BUILTIN;} 
"exec" {n++;return T_BUILTIN;} 
"exit" {n++;return T_BUILTIN;} 
"export" {n++;return T_BUILTIN;} 
"getopts" {n++;return T_BUILTIN;} 
"hash" {n++;return T_BUILTIN;} 
"pwd" {n++;return T_BUILTIN;} 
"readonly" {n++;return T_BUILTIN;} 
"return" {n++;return T_RETURN;} 
"shift" {n++;return T_BUILTIN;} 
"test" {n++;return T_BUILTIN;} 
"times" {n++;return T_BUILTIN;} 
"trap" {n++;return T_BUILTIN;} 
"umask" {n++;return T_BUILTIN;} 
"unset" {n++;return T_BUILTIN;} 
[a-zA-Z_][a-zA-Z0-9_]*|"$"[a-zA-Z][a-zA-Z0-9_]*|"$_"[a-zA-Z0-9_]+ {n++;return T_IDENTIFIER;} 
(\"(\$\{.*\}|\\.|[^\"\\])*\")|(\'(\$\{.*\}|\\.|[^\'\\])*\') {n++; return T_STRINGLITERAL;}
[-]?[0-9]*"."[0-9]+ {n++;return T_FLOAT_CONST;}   
[-]?[0-9]+ {n++;return T_INT_CONST;}   
"="  {n++; return T_EQ;}
"++"  {n++;return T_INCDEC;}
"--"  {n++;return T_INCDEC;}
"<<"  {n++;return T_SHIFT_OP;}
">>"  {n++;return T_SHIFT_OP;}
"+"  {n++;return T_ADDSUB_OP;}
"-"  {n++;return T_ADDSUB_OP;}
"*"  {n++;return T_MULT;}
"/"  {n++;return T_DIV;}
"%"  {n++;return T_REM;}
"!"  {n++;return T_NOT;}
"&&"|"-a"  {n++;return T_LOG_AND;}
"||"|"-o"  {n++;return T_LOG_OR;}
"&"  {n++;return T_AND;}
"|"  {n++;return T_OR;}
"^"  {n++;return T_XOR;}
"(" {n++;return T_LRB;}
")" {n++;return T_RRB;}
"[" {n++;return T_LSB;}
"]" {n++;return T_RSB;}
"{" {n++;return T_LCB;}
"}" {n++;return T_RCB;}
"((" {n++;return T_LDPB;}
"))" {n++;return T_RDPB;}
"[[ " {n++;return T_LDSB;}
" ]]" {n++;return T_RDSB;}
"," {n++; return T_CMA;}
";" {n++;return T_SC;}
";;" {n++;return T_DSC;}
".." {n++;return T_DOTS;}
"$#" {n++;}
"$*" {n++;}
"$@" {n++;}
"$"[0-9]+ {n++;}
"$_" {n++;}
"$"  {n++;return T_DOLLAR;}
"@"  {n++;return T_AT;}
":"  {n++;return T_COL;}
"<="|"-le" {n++;return T_REL_OP;}
"<"|"-lt" {n++;return T_REL_OP;}
"=="|"-eq" {n++;return T_EQUALITY_OP;}
">="|"-ge" {n++;return T_REL_OP;}
"!="|"-ne" {n++;return T_EQUALITY_OP;}
">"|"-gt" {n++;return T_REL_OP;}     
(([<>][<>]|[*\/%+\-&^|])[=]|[=]) {n++;return T_ASSIGN_OPER;}                 
.    ; 
[ \t\n]   ;
#.*\n ;
%%  
   
int yywrap(){}; 

