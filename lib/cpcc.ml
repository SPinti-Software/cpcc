let parse f s =
  let lexbuf = Lexing.from_string s in
  try f Scanner.tokenize lexbuf with Parser.Error -> raise (Failure "Error")

let read_file file =
  let ch = open_in file in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s

let compile file =
    Ast.dump (parse Parser.program (read_file file))