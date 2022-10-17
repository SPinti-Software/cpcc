(lang dune 3.4)

(name cpcc)

(cram enable)

(generate_opam_files true)

(source
 (github SPinti-Software/cpcc))

(authors "d0p1")
(maintainers "d0p1")

(license "BSD-3-Clause")

;(documentation https://url/to/documentation)

(using menhir 2.0)

(package
 (name cpcc)
 (synopsis "CpcdosC+ Compiler")
 (description "CpcdosC+ reference compiler")
 (depends
  ocaml
  dune
  cmdliner
  menhir
  (alcotest :with-test)
  (bisect_ppx :with-test))
 (tags
  (topics compiler cpcdos)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
