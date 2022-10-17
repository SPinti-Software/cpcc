type atom = Int of int | String of string | Keyword of string | Optn of string
type expression = |
type program = Program of atom list

let dump_atom = function
  | Int i -> "Int(" ^ string_of_int i ^ ")"
  | String s -> "Str(" ^ s ^ ")"
  | Keyword k -> "Keyword(" ^ k ^ ")"
  | Optn o -> "Optn(" ^ o ^ ")"

let dump (Program atoms) = String.concat ", " (List.map dump_atom atoms)
