;; @p queries/bash/conceals.scm
(variable_assignment
  value: (word) @conceal
  (#set! conceal "*"))

(variable_assignment
  value: (concatenation [(word) (simple_expansion)] @conceal)
  (#set! conceal "*"))

(variable_assignment
  value: (_) @conceal
  (#set! conceal "*"))
