{
	open Parser

    exception SyntaxError of string
}

let digit = ['0' - '9']
let alpha = ['a' - 'z' 'A' - 'Z']
let sign = ['-' '+']

let number = sign? digit+

let identifier = (alpha | '_') (alpha | digit | '_')*
let keyword = identifier '/'
let optn = "/#" identifier

let whitespace = [' ' '\n' '\r' '\t']+

rule tokenize = parse
    | '\'' { comment lexbuf }
    | '"' { str (Buffer.create 1024) lexbuf }
    | keyword { KEYWORD (Lexing.lexeme lexbuf) }
    | optn { OPTN (Lexing.lexeme lexbuf) }
	| number { INT (int_of_string (Lexing.lexeme lexbuf))}
	| identifier { STRING (Lexing.lexeme lexbuf)}
	| whitespace { tokenize lexbuf }
	| eof { EOF }
	| _ { raise (SyntaxError ("???: '" ^ Lexing.lexeme lexbuf ^ "'")) }

and comment = parse
    | '\n' { tokenize lexbuf }
    | _ { comment lexbuf }

and str buff = parse
    | '"' { STRING(Buffer.contents buff) }
    | '\\' '\\' { Buffer.add_char buff '\\'; str buff lexbuf }
    | _ as c { Buffer.add_char buff c; str buff lexbuf }
    | eof { raise (SyntaxError "Unexpected EOF") }
