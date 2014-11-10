### Notes and Tips, week 5

#### Notes on material

- Always use `#lang racket` at the top of the file.
- Need `(provide (all-defined-out))` near the top.
- Comments start with a semicolon, go to end of line.
- Almost everything is has the form `(e1 e2 e3 ..)` where first term is operator, the rest are the arguments.
- Use `define` to define new variables.
- `lambda` similar to ML's `fn`.
- Some arithmetic operations can take any number of arguments.
- Two ways to define functions: `(define f (lambda (x) body))` or `(define (f x) body)`. Most often use the latter.
- `if-then-else is` `(if eTest eThen eElse)`
- Parentheses ALWAYS matter in Racket! (Changes the meaning if you add "extra" parentheses)
- List operations named differently: `[] -> null`, `:: -> cons`, `hd -> car`, `tl -> cdr`, `null -> null?`.
- Can also use `'()` instead of `null`. And list "convenience": `(list 4 2 1 2 ..)`.
- Hyphens allowed in variable names, conventional to use them as separators (rather than _).
- `true -> #t`, `false -> #f`.
- Can use square brackets instead of parentheses.
- In conditionals, anything other than `#f` is "truthy" (so empty lists, empty strings, 0 etc are all "true").
- Let expressions: `(let ([x1 e1] [x2 e2] [x3 e3]) body)`.
- Variety of let expressions, with different semantics `(let, let*, letrec, define)`.
- Top-level bindings can refer to later bindings, but only inside functions (so they don't actually get used until after they have been defined). But try to avoid it!
- Mutation allowed via `set!`. Very like assignment. (Should only be used when really appropriate)
- `cons` makes pairs. `car/cdr` are like `#1/#2`.
- `lists` are nested conses that end with a cdr of null.
- Use _thunks_ to delay evaluation of expressions
- Be careful not to evaluate thunks too soon when defining streams.
- Memoization: Store previous results and reuse on same input to avoid recomputation.
- Documentation for pairs and list: <http://docs.racket-lang.org/reference/pairs.html>
- `begin` used to sequentially group expressions (useful in conjuction with `set!`).

#### Notes on assignment

- Watch out for the numbering! It is hw4, in week 5. All homeworks will "lag behind" from now on.
- Some questions expect you to look up and use specific Racket library functions. Do so!
- Note: `funny-number-stream` needs to be the stream (i.e. the thunk), not a function that would return the stream. Same for `dan-then-dog`.
- In problems 9 and 10, when searching in the vector/list, you need to return the whole pair, not just the `cdr`.
- Test your functions! A lot.
- Extra parentheses are NEVER OK. Be careful to use only where needed.
- Remember that you cannot write arithmetic the "normal" way.

#### Racket forms for common tasks:

Defining a function:

``` racket
(define (f x y) body)

(define (f x y)
   body)

(define f (lambda (x y) body))

; no-argument function:
(define (f) body)
(define f (lambda () body))
```

Let expressions:

``` racket
(let ([x1 e1]
      [x2 e2]
      [f1 (lambda (x) body)])
   letBody))
```

If expressions:

``` racket
(if testExp
    thenExp
    elseExp)
```

Cond expressions:

``` racket
(cond [test1 exp1]
      [test2 exp2]
      [test3 exp3]
      [#t expDefault])
```

#### Some stuff I found while doing the assignment:

- If you see an error message of the form "expected procedure but got (some number)" then you probably accidentally used infix notation like `(i + 1)` or `(x > y)`
- cond's syntax allows `[else expDefault]` for the last expression (I find it more natural)
- Racket has a `when` keyword that acts as an `if` with no else clause (generally useless if you're not using mutation, but I found it handy for problem 10)

#### Some more tidbits:

``` racket
(thunk ...) is the same as (lambda () ...).
```

Curried lambdas:

``` racket
(define ((name creation-args) call-args) ...)
```

Is the same as:

``` racket
(define (name creation-args)
(lambda (call-args) ...))
```

- Personally, I like writing my tests inline. You can do that with `(module+ test ...tests...)` as many times as you want throughout your impl file. The run button will run your tests automatically. So will `raco test filename` or `C-c t` in racket-mode.
- Your test file starts with `(require rackunit)` and defines your tests within a `test-suite` call. It then has `(require rackunit/text-ui)` and runs the tests with `(run-tests tests)`. If you're missing that last line, nothing will happen.
- The syntax for cond is: (cond [c1 r1] [c2 r2] ... [cN rN]).  You can use a `let` in the place of a condition (or result), but it will be harder to read:

``` racket
(cond [#f 'bad] [(let ([x #t]) x) 42])
42
```
