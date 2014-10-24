(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw3provided.sml";

(* only_capitals *)
val test1 = only_capitals ["A","B","C"] = ["A","B","C"]

val test1_1 = only_capitals []              = []
val test1_2 = only_capitals ["a", "b", "c"] = []


(* longest_string1 *)
val test2 = longest_string1 ["A","bc","C"] = "bc"

val test2_1 = longest_string1 []                     = ""
val test2_2 = longest_string1 [""]                   = ""
val test2_3 = longest_string1 ["A", "bc", "C", "de"] = "bc"
val test2_4 = longest_string1 ["A", "B", "C", "D"]   = "A"


(* longest_string2 *)
val test3 = longest_string2 ["A","bc","C"] = "bc"

val test3_1 = longest_string2 []                     = ""
val test3_2 = longest_string2 [""]                   = ""
val test3_3 = longest_string2 ["A", "bc", "C", "de"] = "de"
val test3_4 = longest_string2 ["A", "B", "C", "D"]   = "D"


(* longest_string3 *)
val test4a= longest_string3 ["A","bc","C"] = "bc"

val test4a_1 = longest_string1 []                     = ""
val test4a_2 = longest_string1 [""]                   = ""
val test4a_3 = longest_string1 ["A", "bc", "C", "de"] = "bc"
val test4a_4 = longest_string1 ["A", "B", "C", "D"]   = "A"

(* longest_string4 *)
val test4b= longest_string4 ["A","B","C"] = "C"

val test4b_1 = longest_string2 []                     = ""
val test4b_2 = longest_string2 [""]                   = ""
val test4b_3 = longest_string2 ["A", "bc", "C", "de"] = "de"
val test4b_4 = longest_string2 ["A", "B", "C", "D"]   = "D"


(* longest_capitalized *)
val test5 = longest_capitalized ["A","bc","C"] = "A";

val test5_1 = longest_capitalized []                = "";
val test5_2 = longest_capitalized ["a","bc","c"]    = "";
val test5_3 = longest_capitalized ["A","bc","C"]    = "A";
val test5_4 = longest_capitalized ["AB","bc","Ab"]  = "AB"
val test5_5 = longest_capitalized ["ab","BB","Abc"] = "Abc"


(*

val test6 = rev_string "abc" = "cba";

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE

val test9a = count_wildcards Wildcard = 1

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1

val test9c = count_some_var ("x", Variable("x")) = 1;

val test10 = check_pat (Variable("x")) = true

val test11 = match (Const(1), UnitP) = NONE

val test12 = first_match Unit [UnitP] = SOME []
*)

