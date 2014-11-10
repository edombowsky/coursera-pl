### Notes and Tips, week 6
#### Notes on material

- Can "simulate" constructors via lists, where the first element (car) specifies the "constructor".
- Write "symbols" in Racket by starting with a quote, then characters. Eg `'foo`.
- Symbols have fast comparison via `eq?`.
- `(struct foo (bar baz) #:transparent)` creates a new "struct" `foo` with "fields" `bar` and `baz`. This adds a number of functions to the environment:
    + `(foo e1 e2)`
    + `(foo? e)`
    + `(foo-bar e)`
    + `(foo-baz e)`
- structs are not lists!
- Interpreters evaluate a program, Compilers translate it to another language
- We write language B programs by writing their abstract syntax tree directly into the meta-language using constructors/structs.
- Can assume AST is made entirely of language B constructs. But must check the type of those constructs when you evaluate subexpressions.
- Need to be evaluating in an environment, so that variables can be looked up somewhere.
- Need to properly pass an environment to subexpressions (often the same as the one you were given, but not always!)
- "Macros" are basically meta-language (Racket) functions, that take in "language B" expressions and produce "language B" expressions

#### Notes on assignment

- Don't forget to submit IN TWO PLACES! (normal, and the peer assessment)
- You can assume your programs are "legal ASTs". Make sure you understand what that means (<https://class.coursera.org/proglang-003/lecture/277>). This is very important. There are some things your code needs to check for, and other things it can assume.
- Do NOT change the `envlookup` function. But do make sure to use it!
- Two cases are already given to you. Do NOT change them, add the remaining ones.
- There is a final catchall case in the cond, do NOT change that either. Add your cases before it.
- Even though closures should not appear in user programs, so in theory your `eval-exp-env` should not need to handle them, the autograder does expect it to. So you should make sure that your `eval-exp-env` has a `closure?` case, and remember that closures are values.
- If you evaluate a pair expression, and it happens to be a "value" already (i.e. its components are values already), then you may if you wish return that pair itself instead of creating a new one (If this comment does not make sense to you, then you probably don't need to worry about it).
- The environment is just a Racket list, extend it using `cons` when you need to.
- Make sure to write a lot of tests for your proper handling of lexical scope!
- Make sure to account for the possibility of anonymous functions
- Make sure to account for shadowing of variables
- For question 3, heed the warning about not using `eval-exp` and/or closures. Your Racket functions should simply produce a MUPL expression, that *when evaluated would do the right thing*.
- You do NOT need to use `racketlist->mupllist` for `mlet*`.
- For ifeq, make sure that when your resulting MUPL expression is evaluated, the expressions e1 and e2 are evaluated exactly once each.
- The most important thing in this assignment, and hardest part to get used to, is being able to clearly identify what parts are MUPL expressions, and parts are Racket constructs, and when to evaluate or not.
    + For instance, you define "MUPL macros" by writing Racket functions whose arguments are assumed to be MUPL expressions, and whose body/result needs to also be a (unevaluated) MUPL expression that uses these arguments. If that expression were to be evaluated via `eval-exp`, it should have the effect described for the macro. But that evaluation is not part of the macro definition.
    + Similarly, to define a "MUPL function `f`", you would basically create a Racket binding `(define mupl-f e)` where `e` is a MUPL expression of the form `(fun ...)` that when evaluated would result in a MUPL function with the required properties. You would normally then use this function in a MUPL program via an assignment `(mlet "f" mupl-f ...)`. The assignment's `mupl-mapAddN` has an example of using `mupl-map` that way.
