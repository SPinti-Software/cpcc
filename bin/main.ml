open Cmdliner

let version = "%%VERSION%%"

(*
let output =
  let doc = "Place the output into <file>." in
  Arg.(value & opt string "a.out" & info [ "o" ] ~docv:"<file>" ~doc)

let target =
  let doc = "Generate code for the given target" in
  Arg.(value & opt (some string) None & info [ "target" ] ~docv:"<value>" ~doc)
*)

let cpcc files =
  print_endline (String.concat ", " (List.map Cpcc.compile files))

let files = Arg.(non_empty & pos_all file [] & info [] ~docv:"FILE")

let cmd =
  let doc = "CpcdosC+ reference compiler" in
  let sdocs = Manpage.s_common_options in
  let info = Cmd.info "cpcc" ~version ~doc ~sdocs in
  Cmd.v info Term.(const cpcc $ files)

let () = exit (Cmd.eval cmd)
