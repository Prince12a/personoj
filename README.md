# [Personoj](https://github.com/Deducteam/personoj)

Copyright [Deducteam](https://deducteam.gitlabpages.inria.fr) 2021-2022

With *Personoj*, you can transpile [PVS](http://pvs.csl.sri.com) theories to
[Lambdapi](https://github.com/Deducteam/lambdapi) files.
Theoretically speaking, Personoj allows you to translate 
well-sorted types and well-typed terms from simple type theory
with prenex polymorphism and
predicate subtyping to well-typed terms of the λΠ calculus modulo theory. 

You are free to copy, modify and distribute Personoj under the terms of
the CeCILL-B license.

## Install and try

Before using Personoj, you need,

- [PVS 7.1 (SBCL)](https://pvs.csl.sri.com/downloads.html)
- (optional) [lambdapi](https://github.com/gabrielhdt/lambdapi) branch `coercions`

To setup and print the translation of the theory `booleans` of the Prelude,
```command
$ cat tools/load-personoj.lisp >> ~/.pvs.lisp
$ echo "(load-personoj #P\""$(pwd)"\")" >> ~/.pvs.lisp
$ pvs -raw -E '(pp-dk *standard-output* (get-theory "booleans") t)' -E '(sb-ext:quit)' 2> /dev/null
require open personoj.lhol personoj.logical personoj.pvs_cert
personoj.eq personoj.restrict personoj.coercions;
require personoj.telescope as TL;
require personoj.extra.arity-tools as A;
require open personoj.nat;
require open personoj.cast;
// Theory booleans
constant symbol prop: Set;

symbol prop: Set ≔ prop begin admitted;

constant symbol false: El prop begin admitted;

constant symbol true: El prop begin admitted;

constant symbol NOT: El (prop ~> prop) begin admitted;

constant symbol ¬: El (prop ~> prop) begin admitted;

constant symbol AND: El ((TL.code (TL.double! prop prop)) ~> prop) begin admitted;

constant symbol &: El ((TL.code (TL.double! prop prop)) ~> prop) begin admitted;

constant symbol ∧: El ((TL.code (TL.double! prop prop)) ~> prop) begin admitted;

constant symbol OR: El ((TL.code (TL.double! prop prop)) ~> prop) begin admitted;

constant symbol ∨: El ((TL.code (TL.double! prop prop)) ~> prop) begin admitted;

constant symbol IMPLIES: El ((TL.code (TL.double! prop prop)) ~> prop) begin admitted;

constant symbol =>: El ((TL.code (TL.double! prop prop)) ~> prop) begin admitted;

constant symbol ⇒: El ((TL.code (TL.double! prop prop)) ~> prop) begin admitted;

constant symbol WHEN: El ((TL.code (TL.double! prop prop)) ~> prop) begin admitted;

constant symbol IFF: El ((TL.code (TL.double! prop prop)) ~> prop) begin admitted;

constant symbol <=>: El ((TL.code (TL.double! prop prop)) ~> prop) begin admitted;

constant symbol ⇔: El ((TL.code (TL.double! prop prop)) ~> prop) begin admitted;

```

## Further documentation

PVS is a highly automated higher order proof environment based on Simple
Type Theory featuring predicate subtyping (also called subset types or
refinement types). Dedukti is a language with its specification as well
as one of its implementations. It is a logical framework. Personoj does
not target the implementation
[Dedukti](https://github.com/Deducteam/dedukti), but
[*lambdapi*](https://github.com/Deducteam/lambdapi).

The repository contains
- lambdapi files to encode the logic of PVS into Dedukti
- lisp files that implement a translation from PVS theories to Dedukti
  files.

## Encoding (`encoding/`)

The main modules are:

- *lhol:* Simple Type Theory,
- *pvs_cert:* predicate subtyping,
- *logical:* logical connectives,
- *telescope:* encoding of telescopes (or dependent tuples),
- *eq:* encoding of propositional equality,

Modules in *examples* provide some developments, *examples.stack* may
be the most interesting one.
Modules in *alt* provide some alternative definitions.

Encoding is checked regularly using the continuous
integration of github. The configuration file for the CI is
`.github/workflows/check_encoding.yml`.

## Transpiler code (`pvs_patches/`)

The code for the transpiler is written in [Common
Lisp](https://common-lisp.net). The code must be loaded in a PVS
process. A helper function defined in `tools/load-personoj.lisp` can be
placed in `~/.pvs.lisp` to load easily those files from PVS.

The transpiler is defined by the function `PVS::PP-DK`,

```lisp
(defun pp-dk (stream x &optional without-proofs)
  "Print PVS object X on STREAM. Proofs are not exported if WITHOUT-PROOFS
is true."
  ...)
```

## Tests (`tests`)

Tests are coded in lisp. Each subdirectory of `tests/` contains a `test.lisp`
file containing functions to run tests. These files contain a function `runall`
to launch all tests. Once in a subdirectory of `tests/`, tests can be launched with
```sh
pvs -raw -L test.lisp -E '(runall)'
```
Consult the documentation inside `test.lisp` for more information.

### Prelude translation (`tests/prelude/`)

The prelude may be translated using the lisp function `runtest` defined
in `test.lisp`.  PVS theories that do not typecheck (yet) are translated
to empty files.
All theories of prelude may be translated and typechecked at
once using the function `runall`. The `runall` function takes a
[JSON](https://www.json.org) file that specifies which theories can be
typechecked and which one cannot. The fields of that file are described
in the documentation of `theory-select`.

The translation is run without exporting proofs and the
output is type checked by the continuous integration in
`.github/workflows/pvs_prelude.yml`.
