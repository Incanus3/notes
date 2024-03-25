===== core =====
* templates
```lisp
(defclass template () (name slots))
(defgeneric exil-equal-p (obj1 obj2))
(defun make-template (name slots))
(defmacro doslots ((name default template &optional retval) &body body))
```

* base-objects
```lisp
(defgeneric copy-object (object))
(defgeneric object-slot (object slot-spec))
(defgeneric (setf object-slot) (val object slot-spec))
(defgeneric atom-position (object atom))
(defgeneric description (object))
```

* patterns
```lisp
(defclass pattern () (negated match-variable))
(defclass simple-pattern (pattern simple-object) (specifier))
(defun make-simple-pattern (pattern-spec &key negated match-var))
(defclass template-pattern (pattern template-object) ())
(defgeneric make-template-pattern (template slot-spec &key negated match-var))
(defun variable-p (expr))
(defun constant-test (desired-value real-value))
(defun var-or-equal-p (atom1 atom2))
```

* facts
```lisp
(defclass fact () ())
(defclass simple-fact (fact simple-object) (specifier))
(defun make-simple-fact (fact-spec))
(defclass template-fact (fact template-object) ())
(defgeneric make-template-fact (template slot-spec))
```

* rules
```lisp
(defclass rule () (name conditions activations))
(defgeneric rule-equal-p (rule1 rule2))
(defun make-rule (name conditions activations)
```


===== rete =====
```lisp
(defgeneric token-equal-p (token1 token2))
(defun token->list (token))
```

```lisp
(defun make-rete (environment))
(defgeneric add-wme (rete wme))
(defgeneric rem-wme (rete wme))
(defgeneric new-production (rete production))
(defgeneric remove-production (rete production))
```

===== environment =====
```lisp
(defclass environment () (watchers templates facts fact-groups strategies current-strategy-name rules rete actNMNMivations))
;; constructor:
(defun make-environment ())
;; watchers:
(defgeneric set-watcher (env watcher))
(defgeneric unset-watcher (env watcher))
;; templates:
(defgeneric add-template (env template))
(defgeneric find-template (env name))
;; facts:
(defgeneric find-fact (env fact))
(defgeneric add-fact (env fact))
(defgeneric rem-fact (env fact))
;; fact groups:
(defgeneric find-fact-group (env group-name))
(defgeneric add-fact-group (env group-name facts))
(defgeneric rem-fact-group (env group-name))
;; strategies:
(defgeneric add-strategy (env strat-name function))
(defgeneric set-strategy (env &optional strat-name))
;; rules:
(defgeneric add-rule (env rule))
(defgeneric rem-rule (env rule-name))
(defgeneric find-rule (env rule-name))
(defgeneric activate-rule (activation))
;; activations:
(defgeneric add-match (env production token)) ; used by rete
(defgeneric remove-match (env production token)) ; used by rete
(defgeneric select-activation (env))
;; environment clean-up:
(defgeneric clear-env (env))
(defgeneric reset-env (env))
(defgeneric completely-reset-env (env))
```


===== parser =====
```lisp
;; used by front-end:deftemplate
(defgeneric parse-template (name slots)
  (:documentation "create template from external representation"))
;; used by front-end:assert, retract and modify
(defgeneric parse-fact (env fact-spec)
  (:documentation "create fact from external representation"))
;; used by front-end:modify
(defgeneric modify-fact (fact mod-list)
  (:documentation "create new fact from fact and mod-list"))
;; used by parse-rule for creating patterns from rule's conditions
(defgeneric parse-pattern (env pattern-spec &key match-var)
  (:documentation "create pattern from external representation"))
;; used by front-end:deffacts
(defgeneric parse-fact-group (env fact-specs)
  (:documentation "create fact group from external representation"))
;; used by front-end:defrule
(defgeneric parse-rule (env name body)
  (:documentation "create rule from external representation"))
```


===== front-end =====
```lisp
;; multiple environments:
(defmacro defenv (name &key redefine))
(defmacro setenv (name))
;; watchers:
(defmacro watch (watcher))
(defmacro unwatch (watcher))
;; templates:
(defmacro deftemplate (name &body slots))
;; facts:
(defun facts (&optional start-index end-index at-most))
(defmacro assert (&rest fact-specs))
(defmacro retract (&rest fact-specs))
(defun retract-all ())
(defmacro modify (fact-spec &rest mod-list))
;; fact groups:
(defmacro deffacts (name &body descriptions))
(defmacro undeffacts (name))
;; strategies:
(defmacro defstrategy (name function))
(defmacro setstrategy (name))
;; rules:
(defmacro defrule (name &body rule))
(defmacro undefrule (name))
(defmacro ppdefrule (name))
;; execution:
(defun reset ())
(defun step ())
(defun halt ())
(defun run ())
;; environment cleanup:
(defun clear ())
(defun complete-reset ())
```
