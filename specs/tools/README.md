Translating to Dedukti/Lambdapi
===============================

This directory contains scripts and tools for the translation of PVS theories
to Dedukti files.

- `pvs2dk.sh`: translate a theory to a lambdapi file.
- `lambdapi.pkg`: the module file for lambdapi (required to type check files).
- `purify.pl`: trims unneeded data from theory specification files
- `lambdapi.mk`: some targets and rules to typecheck lambdapi files.
- `prelude_patches/*.diff`: patches that may be apply to the Prelude to
	translate it.