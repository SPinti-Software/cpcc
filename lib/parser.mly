%{
	open Ast
%}

%token <int> INT
%token <string> STRING KEYWORD OPTN
%token EOF

%start <Ast.program> program

%%

program:
	| atom* EOF { Program $1 }
	;

atom:
	| i=INT { Int i }
	| s=STRING { String s }
    | k=KEYWORD { Keyword k }
    | o=OPTN { Optn o }
	;