(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw1.sml";

(* is_older *)
val test1 = is_older((1,2,3),(2,3,4)) = true

val oldest_date = (1, 1, 1);

val test1_1  = is_older(oldest_date, (2, 1, 1)) = true
val test1_2  = is_older(oldest_date, (1, 2, 1)) = true
val test1_3  = is_older(oldest_date, (1, 1, 2)) = true

val test1_4  = not(is_older((1, 1, 2), oldest_date))   = true
val test1_5  = not(is_older((1, 2, 1), oldest_date))   = true
val test1_6  = not(is_older((2, 1, 1), oldest_date))   = true
val test1_7  = not(is_older(oldest_date, oldest_date)) = true

val test1_8  = is_older((2000,01,01),(1998,10,01)) = false
val test_9  = is_older((2000,01,01),(2000,02,01)) = true
val test1_10 = is_older((2000,01,01),(2000,01,02)) = true
val test1_11 = is_older((2000,01,01),(2000,01,01)) = false

val test1_12 = is_older((2013,03,02),(2012,03,03)) = false  (* date1 year later to date2 year val test_1 = false : bool *)
val test1_13 = is_older((2012,03,02),(2013,03,03)) = true   (* date1 year before date2 year val test_1 = true : bool *)
val test1_14 = is_older((2012,02,02),(2012,02,02)) = false  (* date1 year before date2 year val test_1 = false : bool *)
val test1_15 = is_older((2012,03,02),(2012,02,02)) = false  (* date1 year before date2 year val test_1 = false : bool *)
val test1_16 = is_older((2012,02,02),(2012,03,02)) = true   (* date1 year before date2 year val test_1 = true : bool *)
val test1_17 = is_older((2012,02,03),(2012,02,02)) = false  (* date1 year before date2 year val test_1 = false : bool *)
val test1_18 = is_older((2012,02,02),(2012,02,04)) = true   (* date1 year before date2 year val test_1 = true : bool *)

(* number_in_month *)
val test2 = number_in_month([(2012,2,28),(2013,12,1)],2) = 1

val test2_1 = number_in_month([(2012,01,01),(2012,02,01),(2012,01,13),(2012,01,05),(2012,06,01)], 1) = 3
val test2_2 = number_in_month([], 1) = 0
val test2_3 = number_in_month([(2012,01,01),(2012,02,01),(2012,01,13),(2012,01,05),(2012,06,01)], 0) = 0
val test2_4 = number_in_month([(2012,01,01),(2012,02,01),(2012,01,13),(2012,01,05),(2012,06,01)], 5) = 0

val test2_5 = number_in_month([(2013,09,10),(2013,09,41),(2013,09,51)], 1)               = 0  (* val num1 = 0 : int *)
val test2_6 = number_in_month([(2013,09,10),(2013,09,41),(2013,09,51),(2013,09,20)], 9)  = 4  (* val num1 = 4 : int *)
val test2_7 = number_in_month([(2013,02,31),(2013,09,41),(2013,09,51),(2013,09,20)], 02) = 1  (* val num1 = 1 : int *)

(* number_in_months *)
val test3 = number_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3

val test3_1 = number_in_months([], [2]) = 0
val test3_2 = number_in_months([(2012,2,28)],[]) = 0
val test3_3 = number_in_months([(2012,2,28)],[1,3]) = 0

(* dates_in_month *)
val test4 = dates_in_month([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]

val test4_1 = dates_in_month([(2012,2,28), (2013,12,1)], 3) = []
val test4_2 = dates_in_month([], 3) = []

(* dates_in_months *)
val test5 = dates_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]    (* test case given *)

val test5_1 = dates_in_months([], []) = []
val test5_2 = dates_in_months([(2014,10,10)], []) = []
val test5_3 = dates_in_months([], [1,2]) = []

(* get_nth *)
val test6 = get_nth(["hi", "there", "how", "are", "you"], 2) = "there"


(* date_to_string *)
val test7 = date_to_string((2013, 6, 1)) = "June 1, 2013"

(*

(* number_before_reaching_sum *)
val test8 = number_before_reaching_sum(10, [1,2,3,4,5]) = 3

(* what_month *)
val test9 = what_month(70) = 3

(* month_range *)
val test10 = month_range(31, 34) = [1,2,2,2]

(* oldest *)
val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
*)
