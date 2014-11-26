(* University of Washington, Programming Languages, Homework 7
   hw7testsprovided.sml *)
(* Will not compile until you implement preprocess and eval_prog *)

(* These tests do NOT cover all the various cases, especially for intersection *)

use "hw7.sml";

(* Must implement preprocess_prog and Shift before running these tests *)

fun real_equal(x,y) = Real.compare(x,y) = General.EQUAL;

(*---------------------------------PREPROCESS--------------------------*)
let
    val Point(a,b) = preprocess_prog(LineSegment(3.2,4.1,3.2,4.1))
    val Point(c,d) = Point(3.2,4.1)
in
    if real_equal(a,c) andalso real_equal(b,d)
    then (print "preprocess converts a LineSegment to a Point successfully\n")
    else (print "preprocess does not convert a LineSegment to a Point succesfully\n")
end;

let
    val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,4.1,~3.2,~4.1))
    val LineSegment(e,f,g,h) = LineSegment(~3.2,~4.1,3.2,4.1)
in
    if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
    then (print "preprocess flips an improper LineSegment successfully\n")
    else (print "preprocess does not flip an improper LineSegment successfully\n")
end;

let
    val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,4.1,3.2,~4.1))
    val LineSegment(e,f,g,h) = LineSegment(3.2,~4.1,3.2,4.1)
in
    if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
    then (print "preprocess flips an improper LineSegment successfully\n")
    else (print "preprocess does not flip an improper LineSegment successfully\n")
end;

let
    val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,4.1,3.2,6.1))
    val LineSegment(e,f,g,h) = LineSegment(3.2,4.1,3.2,6.1)
in
    if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
    then (print "preprocess flips an improper LineSegment successfully\n")
    else (print "preprocess does not flip an improper LineSegment successfully\n")
end;


let
    val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(1.2,4.1,3.2,6.1))
    val LineSegment(e,f,g,h) = LineSegment(1.2,4.1,3.2,6.1)
in
    if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
    then (print "preprocess flips an improper LineSegment successfully\n")
    else (print "preprocess does not flip an improper LineSegment successfully\n")
end;


let
    val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(6.2,4.1,3.2,6.1))
    val LineSegment(e,f,g,h) = LineSegment(3.2,6.1,6.2,4.1)
in
    if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
    then (print "preprocess flips an improper LineSegment successfully\n")
    else (print "preprocess does not flip an improper LineSegment successfully\n")
end;
(*---------------------------------PREPROCESS--------------------------*)


(*---------------------------------eval_prog--------------------------*)
(* eval_prog tests with Shift*)
(* Using a NoPoints *)
let
    val a = (case (eval_prog (preprocess_prog (Shift(3.0, 4.0, NoPoints)), [])) of
            NoPoints => true
          | _ => false)
in
    if a
    then (print "eval_prog with NoPoints worked\n")
    else (print "eval_prog with NoPoints is not working properly\n")
end;

(* Using a Point *)
let
    val Point(a,b) = (eval_prog (preprocess_prog (Shift(3.0, 4.0, Point(4.0,4.0))), []))
    val Point(c,d) = Point(7.0,8.0)
in
    if real_equal(a,c) andalso real_equal(b,d)
    then (print "eval_prog with empty environment worked\n")
    else (print "eval_prog with empty environment is not working properly\n")
end;

(* Using a Var *)
let
    val Point(a,b) = (eval_prog (Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0))]))
    val Point(c,d) = Point(7.0,8.0)
in
    if real_equal(a,c) andalso real_equal(b,d)
    then (print "eval_prog with 'a' in environment is working properly\n")
    else (print "eval_prog with 'a' in environment is not working properly\n")
end;

(* Using a Line *)
let
    val Line(a,b) = (eval_prog (Shift(3.0,4.0, Line(1.0, 5.0)), []))
    val Line(c,d) = Line(1.0,6.0)
in
    if real_equal(a,c) andalso real_equal(b,d)
    then (print "eval_prog with Line is working properly\n")
    else (print "eval_prog with Line is not working properly\n")
end;

(* Using a LineSegment *)
let
    val LineSegment(a,b,x1,y1) = (eval_prog (Shift(3.0,4.0, LineSegment(1.0, 2.0, 3.0, 4.0)), []))
    val LineSegment(c,d,x2,y2) = LineSegment(4.0, 6.0, 6.0, 8.0)
in
    if real_equal(a,c) andalso real_equal(b,d) andalso real_equal(x1,x2) andalso real_equal(y1,y2)
    then (print "eval_prog with LineSegment is working properly\n")
    else (print "eval_prog with LineSegment is not working properly\n")
end;

(* With Variable Shadowing *)
let
    val Point(a,b) = (eval_prog (Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0)),("a",Point(1.0,1.0))]))
    val Point(c,d) = Point(7.0,8.0)
in
    if real_equal(a,c) andalso real_equal(b,d)
    then (print "eval_prog with shadowing 'a' in environment is working properly\n")
    else (print "eval_prog with shadowing 'a' in environment is not working properly\n")
end;

