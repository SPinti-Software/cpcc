%{
	open Ast
%}

%token <int> INT
%token <float> FLOAT
%token <string> STRING KEYWORD OPTN INDENT
%token CALL CASE DEF ELIF ELSE END FOR IF LET SWITCH TXT WHILE
%token <string> OP_PLUS OP_EQ OP_NE OP_LT OP_LE OP_GT OP_GE OP_AND OP_OR
%token EOF EQUAL LPAREN RPAREN COMMA

%start <Ast.program> program

%%

program: stmts EOF { Program $1 }
	;

stmts: stmt { [$1] }
	| stmts stmt { $1@[$2] }
	;

stmt: variable_assign { $1 }
	| function_decl { $1 }
	| expr { Expr($1) }
	| TXT keyword_args { Printnl($2) }
	| TXT OPTN keyword_args { Print($3) }
	;

block: stmts END { $1 }
	| END { [] }
	;

variable_assign: LET INDENT EQUAL expr { VariableAssign($2, $4) }
	;

function_decl: DEF INDENT LPAREN function_params RPAREN block { FunctionDeclaration($2, $4, $6) }
	;

function_params: { [] }
	| INDENT { [$1] }
	| function_params COMMA INDENT { $1@[$3] }
	;

expr: constant { Constant $1 }
	| INDENT { Variable($1) }
	| LPAREN expr RPAREN { $2 }
	| expr operator expr { BinOp($1, $2, $3) }
	;

keyword_args: { [] }
    | expr { [$1] }
    | keyword_args COMMA expr { $1@[$3] }
    ;

constant: STRING { String($1) }
	| number { Number($1) }
	;

number: INT { Int($1) }
	| FLOAT { Float($1) }
	;

operator: OP_EQ { $1 }
	| OP_NE { $1 }
	| OP_LT { $1 }
	| OP_LE { $1 }
	| OP_GT { $1 }
	| OP_GE { $1 }
	| OP_AND { $1 }
	| OP_OR { $1 }
	| OP_PLUS { $1 }
	;

%%
