let parse s =
  let lexbuf = Lexing.from_string s in
  try Parser.program Scanner.tokenize lexbuf with
  | Scanner.SyntaxError msg -> raise (Failure msg)
  | Parser.Error -> raise (Failure "Error")

let read_file file =
  let ch = open_in file in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s

let compile file = Ast.dump (parse (read_file file))
