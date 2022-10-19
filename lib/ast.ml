type number = Int of int | Float of float
type value = Number of number | String of string | Boolean of bool

type expr =
  | Constant of value
  | Variable of string
  | MethodCall of string * expr list
  | KeywordCall of string * expr list
  | BinOp of expr * string * expr

type stmt =
  | Expr of expr
  | Print of expr list
  | Printnl of expr list
  | VariableAssign of string * expr
  | FunctionDeclaration of string * (string list) *  stmt list

type program = Program of stmt list

let dump_number num =
  match num with
  | Int i -> "Int(" ^ string_of_int i ^ ")"
  | Float f -> "Float(" ^ string_of_float f ^ ")"

let dump_value value =
  match value with
  | Number num -> dump_number num
  | String str -> "Str(" ^ str ^ ")"
  | Boolean b -> "Bool(" ^ string_of_bool b ^ ")"

let rec dump_expr expr =
  match expr with
  | Constant c -> dump_value c
  | Variable var -> "Variable(" ^ var ^ ")"
  | MethodCall (name, args) -> "Call(" ^ name ^ "(" ^ String.concat ", " (List.map dump_expr args) ^ "))"
  | KeywordCall (name, args) ->  "Call(" ^ name ^ "(" ^ String.concat ", " (List.map dump_expr args) ^ "))"
  | BinOp (a, op, b) -> "BinOp(" ^ (dump_expr a) ^ op ^ (dump_expr b) ^ ")"


let rec dump_stmt stmt =
  match stmt with
  | Expr expr -> dump_expr expr
  | Print exprs -> "Print(" ^ String.concat ", " (List.map dump_expr exprs)  ^ ")"
  | Printnl exprs -> "Printnl(" ^ String.concat ", " (List.map dump_expr exprs)  ^ ")"
  | VariableAssign (name, value) -> "Let(" ^ name ^ ", " ^ dump_expr value ^ ")"
  | FunctionDeclaration (name, args, body) ->
    let body_str = (String.concat "\n" (List.map (String.cat "\t") (List.map dump_stmt body))) in
    let args_str = String.concat ", " args in
      "Function(" ^ name ^ "(" ^ args_str ^ "), body(\n\t" ^ body_str ^ ")"

let dump (Program stmt) = String.concat "\n" (List.map dump_stmt stmt)
