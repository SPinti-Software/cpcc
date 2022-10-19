{
	open Parser

    exception SyntaxError of string

    let keyword_tbl = Hashtbl.create 5

    let _ = List.iter (fun (name, keyword) ->
        Hashtbl.add keyword_tbl name keyword) [
            "call/", CALL;
            "case/", CASE;
            "def/", DEF;
            "elif/", ELIF;
            "else/", ELSE;
            "end/", END;
            "for/", FOR;
            "if/", IF;
            "let/", LET;
            "switch/", SWITCH;
            "txt/", TXT;
            "while/", WHILE;
        ]
}

let digit = ['0' - '9']
let alpha = ['a' - 'z' 'A' - 'Z']
let sign = ['-' '+']

let integer = sign? digit+
let float = sign? integer '.' digit+

let identifier = (alpha | '_') (alpha | digit | '_')*
let keyword = identifier '/'
let optn = "/#" identifier

let whitespace = [' ' '\r' '\n' '\t']+

rule tokenize = parse
    | '\'' { comment lexbuf }
    | '"' { str (Buffer.create 1024) lexbuf }
    | '+' { OP_PLUS (Lexing.lexeme lexbuf) }
    | '=' { EQUAL }
    | '(' { LPAREN }
    | ')' { RPAREN }
    | ',' { COMMA }
    | keyword as k {
            let normalized = String.lowercase_ascii k in
            try Hashtbl.find keyword_tbl normalized
            with Not_found -> KEYWORD k
        }
    | optn { OPTN (Lexing.lexeme lexbuf) }
	| integer { INT (int_of_string (Lexing.lexeme lexbuf))}
    | float { FLOAT (float_of_string (Lexing.lexeme lexbuf ))}
	| identifier { INDENT (Lexing.lexeme lexbuf)}
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
