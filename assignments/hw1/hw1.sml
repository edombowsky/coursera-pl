(*1*)
(* Evaluates to true if first date comes before the second date *)
fun is_older(d1:int*int*int, d2:int*int*int) =
(#1 d1 < #1 d2) orelse
((#1 d1 = #1 d2) andalso (#2 d1 < #2 d2)) orelse
((#1 d1 = #1 d2) andalso (#2 d1 = #2 d2) andalso (#3 d1 < #3 d2))
