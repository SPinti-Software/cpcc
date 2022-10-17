{
	open Parser
}

let digit = ['0' - '9']
let alpha = ['a' - 'z' 'A' - 'Z']
let sign = ['-' '+']

let number = sign? digit+
let hexnumer = "0x" digit+
let identifier = (alpha | '_') (alpha | digit | '_')*
let keyword = identifier '/'
let whitespace = [' ' '\n' '\r' '\t']+
let tmp = ('(' | ')' | '{' | '}' | '[' | ']' | '*' | '/' | '#' )

rule tokenize = parse
    | '\'' { comment lexbuf }
    | '"' { str (Buffer.create 1024) lexbuf }
    | keyword { KEYWORD (Lexing.lexeme lexbuf) }
	| number { INT (int_of_string (Lexing.lexeme lexbuf))}
	| identifier { STRING (Lexing.lexeme lexbuf)}
	| tmp { tokenize lexbuf }
	| whitespace { tokenize lexbuf }
	| eof { EOF }
	| _ { raise (Failure ("???: '" ^ Lexing.lexeme lexbuf ^ "'")) }

and comment = parse
    | '\n' { tokenize lexbuf }
    | _ { comment lexbuf }

and str buff = parse
    | '"' { STRING(Buffer.contents buff) }
    | _ as c { Buffer.add_char buff c; str buff lexbuf }