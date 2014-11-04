### Notes for week 3
_<https://class.coursera.org/proglang-003/forum/thread?thread_id=693>_

- Functions are **values**, they can be stored in pairs, in lists, passed as arguments to functions, returned as values from functions.
- Anonymous function syntax very useful for passing functions or returning functions.
- In the absense of recursion issues, `fun f x = e` is almost the same as `val f = fn x => e` (but the former is prefered style)
- Avoid 'unnecessary function wrapping'. (Prefer `val g = f` rather than `fun g x = f x`, and `fun f x = g` rather than `fun f x y = g y)`
- Make sure to clearly understand the type signature of the functions `map` and `filter`.
- Study and understand the mechanics of `Lexical Scope`. It is important.
- Very important to understand the difference between functions and closures.
- Think about why lexical scope is so important when dealing with "higher-order-functions".
- Always look at the type signatures of your functions, and think about how they make sense.
- A type signature like `'a -> 'b -> 'c` should be read as `'a -> ('b -> 'c)`.
- Functions come with closures. Those can be used to avoid recomputation of expressions that don't change with each call.
- Study and understand the type of `fold`.
- `fold` allows separating recursive traversal from the data processing.
- We can create our own `infix` operators.
- Currying allows for function that "apply their arguments one at a time"
- Study the `curry` and `uncurry` methods.
- SML's foldl method has slightly different form than the one presented in class.
- Some times `val f1 = f2` leads to "value-restriction" errors. Turning it into a `fun` form usually fixes this.

### Notes on assignment 3

- It would be a great idea, while they are fresh in your mind, to review hw1 and hw2 and find ways to use higher order functions to simplify them. `map/filter/fold` can turn a lot of the previous problems into 1-liners:
 + `number_in_month` can be done via a `fold` or via `filter` together with `length`.
 + `number_in_months` can be done via a `fold` on the months list.
 + `dates_in_month` can be done via `filter`.
 + `dates_in_months` can be done via `fold`.
 + `month_range` can be done by creating a list of the days, followed by a `map` of `what_month` on that list.
 + `oldest` can be done via `fold`.
 + `get_substitutions` can be done via `fold`.
 + `similar_names` can be done via `map`.
 + `all_same_color` can be done via `fold`, but takes a bit of thinking, and requires treating the empty list separately.
 + `sum_cards` can be done via `fold`.
 + `officiate` can probably be modeled around a `fold`, where the list is the moves and the "accumulator" is a tuple describing the state of the system.
- You are required to use certain library functions. Do NOT create your own instead.
- Some questions ask that you use certain functions. Make sure you do!
- Use pattern matching. Avoid `#` and `hd`.
- Start with the provided file, you need what is in there. Add your code to it.
- Almost all answers in the first part are very short, many are a simple `val` binding.
- Study the relevant library documentation
- Don't forget about the function composition operator `o`: If you find yourself doing `fun f x = h (g x)`, this can be written as `val f = h o g`.
- It is often easier to first start with writing the function in the full `fun f x y = ...` form, then seeing if some of the arguments can be removed (see "unnecessary function wrapping").
- Take the time to write down the types of the functions you want to combine in a piece of paper, before trying to code. You can avoid a lot of typechecking errors by thinking about what makes sense.
- For problem 9, make sure to understand what the provided function `g` does. Its goal is to traverse a pattern structure, applying the functions `f1` and `f2` that you give it at key parts. Make sure to understand the types of those two functions. The solutions to this problem will all be very short, mostly partial applications of `g`.
- Typing `f`; in the REPL is a great way to find out about the type of a function `f`.
- For `longest_string1` note that if multiple strings have the same length, you need to return the earlier one. The opposite for `longest_string2`.
- Make sure you understand what `longest_string_helper` does. Its first argument is a function that compares two integers (for instance `<` or `>` are such functions, though see the next point for more on this). It then takes in curried form a second argument of a string list. Finally it returns a single string. Your code should be such, that when you use `>` as the first argument you get behavior identical to `longest_string1`. This helper will in effect be carrying out the common parts of `longest_string1` and `longest_string2`.
- Infix operators like `>`, `<>` etc cannot be used just like that as functions wherever you would have used say an `f`. However, you can obtain the "function" corresponding to an infix operator via op, like so: `(op <>)` is the `function f(x,y) = x <> y`.
- `longest_string3` and `longest_string4` are both extremely short and defined via val bindings. They should be just a partial application of `longest_string_helper`.
- For `first_answer` and `all_answers`, make sure you do some cases manually to get a feel for them.
- A nested pattern match for the function match is probably a good idea.
- Note that the arguments to `first_match` are curried.
- To help you think of the pattern matching problem, here's some patterns in "normal SML speak" and their equivalents in the assignment's setting.
 + `(_, 5)` ------> `TupleP [Wildcard, ConstP 5]`
 + `SOME (x, 3)` ------> `ConstructorP ("SOME", TupleP [Variable "x", ConstP 3])`
 + `(s, (t, _))` ------> `TupleP [Variable "s", TupleP [Variable "t", Wildcard]]`
- For the purposes of the assignment, an empty `Tuple` is different from `Unit`, and a `Tuple` with one element is different from that element by itself. So for example the pattern `UnitP` should not match the value `Tuple []`.


### Annotations About Challenge Exercise
_<https://class.coursera.org/proglang-003/forum/thread?thread_id=693#post-2634>_

My understanding of the challenge exercise is as follows:

Let's imagine that we have a case expression with different patterns, like

``` sml
case x of p1 | p2 | ... | pn
```

Where `x` is of certain `type t` that we could infer out of the patterns p1, p2, ..., pn.

In summary the objective of the challenge exercise is to create an algorithm that (alike the SML compiler), is capable of inferring what is the type t of x based on the patterns `p1`, `p2`, ..., `pn`.

These patterns are provided as the second argument of the challenge exercise function and they represent every one of the branches in a case expression.

If all the patterns in the case expression are compatible with some type `t` then the answer is `SOME t`, otherwise `NONE`.

### About the Type List

We would not need the first argument of the challenge exercise if it weren't because constructor patterns do not tell us of what type they are. For instance, consider a case expression like

``` sml
case c of Red => ... | Green => ... | _ => ...
```

We cannot tell what is the type of `Red` or `Green `here. Likewise, in the challenge exercise if we found a constructor like

``` sml
Constructor("Red",UnitP)
```

How could we possibly infer the type of this constructor unless we had some metadata?.

And so this explains why we need a first argument of the challenge function containing a type list. It is nothing but our definition of datatypes.

``` sml
datatype color = Red | Green | Blue
```

Would become somewhat like:

``` sml
[
    ("Red", "color", UnitT),
    ("Green", "color", UnitT),
    ("Blue", "color", UnitT)
]
```

### Type Inference Examples

#### Example 1:

Supposing we had this function

``` sml
fun b(x) = 
   case x of
       (10) => 1
      | a => 3
```

The compiler would determine that x is an integer. How? Easy, one of the patterns is a integer constant. Thus, the other pattern named a must be an integer as well. And there you have it, we just inferred the type of `x`.

In our challenge exercise this pattern would be expressed as

``` sml
[ConstP 10, Variable "a"]
```

And our algorithm should say that the answer is `SOME IntT` which corresponds with the type the compiler would infer.

#### Example 2:

A piece of code like the following would not even compile, because we cannot infer a common type for all patterns. The types in the different patterns are conflicting. We cannot tell if `x` is an integer or an option.

``` sml
fun b(x) = 
   case x of
      (10) => 1
      | SOME x => 3
      | a => 3
```

Thus, consider the following pattern, corresponding with the code above:

``` sml
[ConstP 10, Variable "a", ConstructorP("SOME",Variable “x”)]
```

This cannot produce a common type and the answer our algorithm yields should be `NONE`, equivalent with the compiler throwing an error due to incapacity to determine a common type.

#### Example 3:

Let's do a more complicated example now:

``` sml
fun c(x) = 
    case x of
      (a,10,_) => 1
      | (b,_,11) => 2
      | _ => 3
```

What is the type of `x`?

Well, we can easily infer it's a tuple of three elements. Based on the patterns we know the second and third elements of this tuple are integers. The first one, on the other hand, can be "anything".

This would correspond with:

``` sml
[TupleP[Variable "a", ConstP 10, Wildcard], TupleP[Variable "b", Wildcard, ConstP 11], Wildcard]
```

And the answer given by our algorithm should be: `SOME TupleT[Anything,IntT,IntT]`.

#### Example 4:

Let's use a datatype now.

``` sml
datatype color = Red | Green | Blue
```

Then we need to define the first (metadata) argument of our challenge function as:

``` sml
[("Red","color",UnitT),("Green","color",UnitT),("Blue","color",UnitT)]
```

Let's say now that we have a function like this:

``` sml
fun f(x) = 
   case x of
     Red => 0
     | _ => 1
```

Corresponding with something like:

``` sml
[ConstructorP("Red", UnitP), Wildcard]
```

Our algorithm should go over the patterns and say this is of type:

``` sml
SOME (Datatype "color")
```

#### Example 5:

Let's use now a more complex datatype

``` sml
datatype auto =  Sedan of color
               | Truck of int * color
               | SUV
```

This would correspond to a metadata argument as follows:

``` sml
[("Sedan","auto", Datatype "color"),("Truck","auto",TupleT[IntT, Datatype "color"),("SUV","auto",UnitT)]
```

Let's say now that we had a function like this:

``` sml
fun g(x) = 
   case x of
      Sedan(a) => 1
      | Truck(b,_) => 2
      | _ => 3
```

What is the type of `x`? Well, we can easily infer they are all of type auto.

So, the following argument:

``` sml
[ConstructorP("Sedan", Variable "a"), ConstructorP("Truck", TupleP[Variable "b", Wildcard]), Wildcard]
```

Should yield S`OME (Datatype "auto")`.

#### Example 6:

Let's now define a polymorphic type to make this interesting

``` sml
datatype 'a list = Empty | List of 'a * 'a list
```

So, we must first define our metadata argument:

``` sml
[("Empty","list",UnitT),("List","list",TupleT[Anything, Datatype "list"])]
```

The trick is to notice that the polymorphic type 'a corresponds to anything here, and so the type inference becomes a bit trickier later on.

Now if we had this function

``` sml
fun j(x) = 
   case x of
       Empty => 0
     | List(10,Empty) => 1 
     | _ => 3
```

Evidently the patterns are of type `list`, but not just that, but a list of integers.

So, the following argument corresponding to the patterns in the function:

``` sml
[ConstructorP("Empty",UnitP),ConstructorP("List",TupleP[ConstP 10, ConstructorP("Empty",UnitP)]), Wildcard]
```
Should yield: `SOME (Datatype "list")`.

This case is tricky, because `ConstP(10)` needs to correspond with `Anything` in the constructors metadata as you can see above.

#### Example 7:

Let's consider this variation of the previous case

``` sml
fun h(x) = 
   case x of
      Empty => 0
    | List(k,_) => 1
```

In this case k could be anything. So, we represent these branches as:

``` sml
[ConstructorP("Empty",UnitP),ConstructorP("List",TupleP[Variable "k", Wildcard])]
```

And the answer should be `Datatype "list"`.

And once more, notice how `Variable "k"` needs to correspond with `Anything` in the constructor metadata.

So, in the previous example `ConstP(10)` and now `Variable "x"` can be considered "compatible with" `Anything`.

#### Example 8:

Just another example

``` sml
fun g(x) = 
   case x of
      Empty => 0
    | List(Sedan(c),_) => 1
```

Corresponding with:

``` sml
[ConstructorP("Empty",UnitP),ConstructorP("List",TupleP[ConstructorP("Sedan", Variable "c"), Wildcard])]
```

Should evidently yield `SOME (Datatype "list")`.

#### Example 9:

What I could not fully understand was the part of the "most lenient" pattern. In the assignment we get two examples, not at all clear for me.

The first one suggest that we have two patterns of the form:

``` sml
TupleP[Variable “x”, Variable “y”] 
TupleP[Wildcard, Wildcard].
```

This would correspond to something like

``` sml
fun m(w) = 
    case w of
          (x,y) => 0
        | (_,_) => 1
```

Interestingly this would not compile, since the patterns are redundant, namely, we would alway go out throught the first branch. My conclusion was that this statement was simply used with illustration purposes.

We can infer that `w` is a tuple with two elements that can be of anything. So the answer to this type of patterns should be:

``` sml
TupleT[Anything, Anything].
```

Maybe a TA can help me understand better this part.

### Example 10:

The second example of the "most lenient" requirement is likewise rather ambiguous for me. The example given would not compile either because once more the patterns are redundant.

The second example suggest a list of patterns like this:

``` sml
TupleP[Wildcard, Wildcard]
TupleP[Wildcard, TupleP[Wildcard,Wildcard]]
```

Which would correspond with

``` sml
fun m(w) = 
    case w of
      (_,(_,_)) => 0
    | (_,_) => 1
```

We can infer that `w` is a tuple of two elements, the first one can be anything, the second one is evidently a tuple of other two elements, which in turn can be anything.

So, if we had to infer this we had to say the type of this is

``` sml
TupleT[Anything, TupleT[Anything, Anything]]
```

Which is the expected answer by the challenge exercise. But yet again, the compiler would not handle this type of expression without errors.

Somebody with a broader understanding of the so called "most lenient" requirement please enlighten me.
