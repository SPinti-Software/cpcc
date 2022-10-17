(lang dune 3.4)

(name cpcc)

(generate_opam_files true)

(source
 (github SPinti-Software/cpcc))

(authors "d0p1")

(maintainers "d0p1")

(license LICENSE)

;(documentation https://url/to/documentation)

(using menhir 2.0)

(package
 (name cpcc)
 (synopsis "CpcdosC+ Compiler")
 (description "CpcdosC+ reference compiler")
 (depends ocaml dune cmdliner)
 (tags
  (topics compiler cpcdos)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
