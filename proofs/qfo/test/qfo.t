  $ psnj-qfo qfo.json < false.lp
  Loaded package file from "$TESTCASE_ROOT"
  symbol false: @∀ prop (λ p: El prop, p);
  symbol true: @∀ prop (λ p: El prop, imp p p);

  $ echo 'symbol tt: ∀ {prop} (λ p: El prop, p ∧ (λ _, p));' | psnj-qfo qfo.json
  Loaded package file from "$TESTCASE_ROOT"
  symbol tt: @∀ prop (λ p: El prop, conj p p);

  $ psnj-qfo -e 'require open qfo.spec.withsymb;' qfo.json < withsymb_thms.lp
  Loaded package file from "$TESTCASE_ROOT"
  symbol trivial: imp qfo.spec.withsymb.P qfo.spec.withsymb.P;
