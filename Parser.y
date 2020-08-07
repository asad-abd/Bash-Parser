%{


#include <stdio.h>
int yylex(void);


%}


%token  T_IDENTIFIER T_STRINGLITERAL T_FUNCTION T_BUILTIN
%token T_SC T_CMA T_LRB T_LCB T_RCB T_LSB T_RSB T_QU T_COL T_LOG_OR T_LOG_AND T_OR T_XOR T_AND T_EQUALITY_OP T_REL_OP T_SHIFT_OP T_MULT T_DIV T_REM T_TILDE T_NOT T_INCDEC T_ADDSUB_OP T_ASSIGN_OPER T_EQ  
%token T_LDPB T_RDPB T_LDSB T_RDSB T_DOTS
%token T_INT_CONST T_FLOAT_CONST
%token T_WHILE T_DO T_FOR T_RETURN T_DONE  T_UNTIL
%token T_IF T_FI T_THEN T_ELIF T_CASE  T_ESAC T_IN T_DSC T_DOLLAR T_AT
%nonassoc T_RRB
%nonassoc T_ELSE
			
                        

                        
%start ROOT

                        
%%

ROOT:
	        ExtDef {printf("Parse Successful\n") ; } 
		|   ExtDef error
		;

// EXTERNAL DEFINITION

ExtDef:
		ExtDeclaration 
        |       ExtDef ExtDeclaration 
		;

ExtDeclaration:
		Declaration 
        | T_FUNCTION FuncDef
		| FuncDef 
		| Statement 
		| ArrayDeclaration
		
		;

// FUNCTION DEFINITION

FuncDef:
		 T_IDENTIFIER T_LRB T_RRB CompoundStatement 
		;

ParameterList:
		
	| 	Parameter 
	|       ParameterList  Parameter 
		;

Parameter:
		 ParamDeclarator 
		;

ParamDeclarator:
		T_IDENTIFIER 
    |   Constant
		;

// Declaration

//Array Declaration 
ArrayDeclaration:
    	Declarator T_EQ T_LRB ParameterList T_RRB
	|   Declarator T_LSB Constant T_RSB T_EQ PrimaryExpression
	;

DeclarationList:
		Declaration 
	|	DeclarationList Declaration 
		;

Declaration:
	    InitDeclaratorList
		;





InitDeclaratorList:
		InitDeclarator 
	|       InitDeclaratorList T_CMA InitDeclarator 
		;

InitDeclarator:
		Declarator 
	|	Declarator T_EQ AssignmentExpression 
		;

Declarator:
		T_IDENTIFIER 
		;

//ArrayElements 
ArrayElements:
        Element
    |   ArrayElements Element

Element:
    	T_DOLLAR T_LCB quantifiers T_IDENTIFIER T_LSB T_AT T_RSB range T_RCB
    |	T_DOLLAR T_LCB quantifiers T_IDENTIFIER T_LSB T_INT_CONST T_RSB  T_RCB

quantifiers:
	|   T_NOT
range: 
    |	T_COL T_INT_CONST T_COL T_INT_CONST
// Statement

StatementList:
		Statement 
	|	StatementList Statement 
		;

Statement:
		CompoundStatement { $$ = $1; }
	|	SelectionStatement { $$ = $1; }
	|	SwitchStatement { $$ = $1; }
	|	ExpressionStatement { $$ = $1; }
	|   JumpStatement { $$ = $1; }
	|	IterationStatement { $$ = $1; }
	|   FunctionCallStatement {$$ = $1;}
		;

CompoundStatement:
		T_LCB CompoundStatement_2 { $$ = $2; }
		;

CompoundStatement_2:
		T_RCB 
	|	DeclarationList T_RCB 
	|	DeclarationList StatementList T_RCB 
	|	StatementList T_RCB 
		;
MultilineStatement:
        DeclarationList
    |	DeclarationList StatementList 
	|	StatementList 
		;
	   

//if elif else
SelectionStatement:
		T_IF T_LDSB Expression T_RDSB T_SC T_THEN MultilineStatement T_FI
	|   T_IF T_LSB Expression T_RSB T_SC T_THEN MultilineStatement T_FI	
	|	T_IF T_LDPB Expression T_RDPB T_SC T_THEN MultilineStatement T_FI
	| 	T_IF T_LDSB Expression T_RDSB T_SC T_THEN MultilineStatement T_ELSE MultilineStatement T_FI
	|   T_IF T_LSB Expression T_RSB T_SC T_THEN MultilineStatement T_ELSE MultilineStatement T_FI
	|	T_IF T_LDPB Expression T_RDPB T_SC T_THEN MultilineStatement T_ELSE MultilineStatement T_FI
	|	T_IF T_LDSB Expression T_RDSB T_SC T_THEN MultilineStatement ElifExpression T_FI 
	|	T_IF T_LSB Expression T_RSB T_SC T_THEN MultilineStatement ElifExpression T_FI 
	|	T_IF T_LDPB Expression T_RDPB T_SC T_THEN MultilineStatement ElifExpression T_FI
	|   T_IF T_LDSB Expression T_RDSB  T_THEN MultilineStatement T_FI
	|   T_IF T_LSB Expression T_RSB  T_THEN MultilineStatement T_FI	
	|	T_IF T_LDPB Expression T_RDPB  T_THEN MultilineStatement T_FI
	| 	T_IF T_LDSB Expression T_RDSB  T_THEN MultilineStatement T_ELSE MultilineStatement T_FI
	|   T_IF T_LSB Expression T_RSB    T_THEN MultilineStatement T_ELSE MultilineStatement T_FI
	|	T_IF T_LDPB Expression T_RDPB  T_THEN MultilineStatement T_ELSE MultilineStatement T_FI
	|	T_IF T_LDSB Expression T_RDSB  T_THEN MultilineStatement ElifExpression T_FI 
	|	T_IF T_LSB Expression T_RSB  T_THEN MultilineStatement ElifExpression T_FI
	|	T_IF T_LDPB Expression T_RDPB  T_THEN MultilineStatement ElifExpression T_FI  
	
		;

ElifExpression:
		T_ELIF T_LDSB Expression T_RDSB T_SC T_THEN MultilineStatement ElifExpression
	|	T_ELIF T_LDPB Expression T_RDPB T_SC T_THEN MultilineStatement ElifExpression
	|   T_ELIF T_LDSB Expression T_RDSB T_THEN MultilineStatement ElifExpression
	|	T_ELIF T_LDPB Expression T_RDPB T_THEN MultilineStatement ElifExpression
	|	T_ELSE MultilineStatement
;
//if elif else end

//switch case

SwitchStatement:
		T_CASE T_IDENTIFIER T_IN Cases T_ESAC
	|	T_CASE Constant T_IN Cases T_ESAC
	;

Cases:
		T_IDENTIFIER T_RRB MultilineStatement T_DSC Cases
	|	Constant T_RRB MultilineStatement T_DSC Cases
	|	T_MULT T_RRB MultilineStatement T_DSC
	;
//switch end

ExpressionStatement:
		Expression  { $$ = $1; }
		;

JumpStatement:
		T_RETURN ExpressionStatement { $$ = $2; }
		;

IterationStatement:
		T_WHILE T_LSB Expression T_RSB T_DO MultilineStatement T_DONE { $$ = $4; }
	|   T_WHILE T_LDPB Expression T_RDPB T_DO MultilineStatement T_DONE { $$ = $4; }
	|   T_UNTIL T_LSB Expression T_RSB T_DO MultilineStatement T_DONE { $$=$5; }
	|	T_FOR T_IDENTIFIER T_IN myexp T_DO MultilineStatement T_DONE { $$=$6; }
	|	T_FOR T_IDENTIFIER T_IN myexp T_COL T_DO MultilineStatement T_DONE { $$=$7; }
	|	T_FOR T_LDPB Expression T_SC Expression T_SC Expression T_RDPB T_DO MultilineStatement T_DONE { $$ = $10; }
	|   T_FOR T_IDENTIFIER T_IN T_LCB DottedStatement T_RCB T_DO MultilineStatement T_DONE  { $$=$8; }
	|   T_WHILE T_LSB Expression T_RSB T_SC T_DO MultilineStatement T_DONE { $$ = $4; }
	|   T_WHILE T_LDPB Expression T_RDPB T_SC T_DO MultilineStatement T_DONE { $$ = $4; }
	|   T_UNTIL T_LSB Expression T_RSB T_SC T_DO MultilineStatement T_DONE { $$=$5; }
	|	T_FOR T_IDENTIFIER T_IN myexp T_SC T_DO MultilineStatement T_DONE { $$=$6; }
	|	T_FOR T_LDPB Expression T_SC Expression T_SC Expression T_RDPB T_SC T_DO MultilineStatement T_DONE { $$ = $10; }
	|   T_FOR T_IDENTIFIER T_IN T_LCB DottedStatement T_RCB T_SC T_DO MultilineStatement T_DONE  { $$=$8; }
		;
myexp:
    	T_DOLLAR T_LCB T_IDENTIFIER T_LSB T_AT T_RSB T_RCB
    |   exp3
    ;
exp2:
        T_STRINGLITERAL
    |   T_IDENTIFIER
    |   T_INT_CONST
    |   T_FLOAT_CONST
    ;
exp3:
        exp2
    |   exp3 exp2
DottedStatement:
        T_INT_CONST T_DOTS T_INT_CONST {;}
    |   T_INT_CONST T_DOTS T_INT_CONST T_DOTS T_INT_CONST {;}
        ;
	
FunctionCallStatement:
        T_IDENTIFIER ParameterList {$$=$1;}
	|   T_BUILTIN ParamDeclarator {$$=$1;}
	|   T_BUILTIN ArrayElements
	|   T_BUILTIN
	;
// Expressions

Expression:
		AssignmentExpression { $$ = $1; }
		;

AssignmentExpression:
		ConditionalExpression { $$ = $1; }
	|	UnaryExpression ASSIGN_OPER AssignmentExpression { $$ = $1; }
		;

ASSIGN_OPER:
		T_ASSIGN_OPER { ; }
	|	T_EQ { ; }
	;

ConditionalExpression:
		LogicalOrExpression { $$ = $1; }
	|	LogicalOrExpression T_QU Expression T_COL ConditionalExpression { $$ = $1; }
		;

LogicalOrExpression:
		LogicalAndExpression { $$ = $1; }
	|	LogicalOrExpression T_LOG_OR LogicalAndExpression { $$ = $3; }
		;

LogicalAndExpression:
		InclusiveOrExpression { $$ = $1; }
	|	LogicalAndExpression T_LOG_AND InclusiveOrExpression { $$ = $3; }
		;

InclusiveOrExpression:
		ExclusiveOrExpression { $$ = $1; }
	|	InclusiveOrExpression T_OR ExclusiveOrExpression { $$ = $3; }
		;

ExclusiveOrExpression:
		AndExpression { $$ = $1; }
	|	ExclusiveOrExpression T_XOR AndExpression { $$ = $3; }
		;

AndExpression:
		EqualityExpression { $$ = $1; }
	|	AndExpression T_AND EqualityExpression { $$ = $3; }
		;

EqualityExpression:
	        RelationalExpression { $$ = $1; }
	|	EqualityExpression T_EQUALITY_OP RelationalExpression { $$ = $3; }
		;

RelationalExpression:
		ShiftExpression { $$ = $1; }
	|       RelationalExpression T_REL_OP ShiftExpression { $$ = $3; }
		;

ShiftExpression:
		AdditiveExpression { $$ = $1; }
	|	ShiftExpression T_SHIFT_OP AdditiveExpression { $$ = $3; }
		;

AdditiveExpression:
		MultiplicativeExpression { $$ = $1; }
	|	AdditiveExpression T_ADDSUB_OP MultiplicativeExpression { $$ = $3; }
		;

MultiplicativeExpression:
		CastExpression { $$ = $1; }
	|	MultiplicativeExpression MultDivRemOP CastExpression { $$ = $3; }
		;

MultDivRemOP:
		T_MULT { $$ = $1; }
	|	T_DIV { $$ = $1; }
	|	T_REM { $$ = $1; }
		;

CastExpression:
		UnaryExpression { $$ = $1; }
		;

UnaryExpression:
		PostfixExpression { $$ = $1; }
	|	T_INCDEC UnaryExpression { $$ = $2; }
	|	UnaryOperator CastExpression { $$ = $2; }
		;

UnaryOperator:
		T_AND { $$ = $1; }
	|	T_ADDSUB_OP { $$ = $1; }
	|	T_MULT { $$ = $1; }
	|	T_TILDE { $$ = $1; }
	|	T_NOT { $$ = $1; }
		;

PostfixExpression:
		PrimaryExpression { $$ = $1; }
	|	PostfixExpression T_LSB Expression T_RSB { $$ = $3; }
	|	PostfixExpression T_LRB PostfixExpression2 { $$ = $3; }
	|	PostfixExpression T_INCDEC 		;

PostfixExpression2:
		T_RRB 
	|	ArgumentExpressionList T_RRB { $$ = $1; }
		;

ArgumentExpressionList:
		AssignmentExpression { $$ = $1; }
	|	ArgumentExpressionList T_CMA AssignmentExpression { $$ = $3; }
		;

PrimaryExpression:
		T_IDENTIFIER 
	|    Constant 
	|	T_LRB Expression T_RRB { $$ = $2; }
		;

Constant:
		T_INT_CONST { $$ = $1; }
	|   T_FLOAT_CONST {$$ = $1;}
	|   T_STRINGLITERAL { $$=$1 ;}
		;

// Expressions END

//Conditionals

//Conditionals END
%%
int main(int argc,char* argv[]) {
  extern FILE *yyin, *yyout; 
  if(argc<2){ 
    yyin = fopen("correct", "r");
    }else{
     yyin = fopen(argv[1],"r");
    }
  yyparse();
  return 0;
}

void yyerror(char *s) {
  fprintf(stderr,"error:%s\n",s);
}