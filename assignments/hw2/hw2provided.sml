(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(*
 * You will write 11 SML functions (not counting local helper functions), 4
 * related to \name substitutions" and 7 related to a made-up solitaire card
 * game.
 *
 * Your solutions must use pattern-matching. You may not use the functions null,
 * hd, tl, isSome, or valOf, nor may you use anything containing a # character
 * or features not used in class (such as mutation). Note that list order does
 * not matter unless specifically stated in the problem.
 *
 * Download hw2provided.sml from the course website. The provided code defnes
 * several types for you. You will not need to add any additional datatype
 * bindings or type synonyms.
 *
 * The sample solution, not including challenge problems, is roughly 130 lines,
 * including the provided code.
 *
 * Do not miss the "Important Caveat" and "Assessment" after the "Type Summary."
 *
 * Section #1
 * -----------
 * This problem involves using first-name substitutions to come up with alternate
 * names. For example, Fredrick William Smith could also be Fred William Smith
 * or Freddie William Smith. Only part (d) is specifcally about this, but the
 * other problems are helpful.
 *)

(*
 * (a) Write a function all_except_option, which takes a string and a string
 * list. Return NONE if the string is not in the list, else return SOME lst
 * where lst is identical to the argument list except the string is not in it.
 * You may assume the string is in the list at most once. Use same_string,
 * provided to you, to compare strings. Sample solution is around 8 lines.
 *)
fun all_except_option(str: string, string_list: string list) =
   SOME ["fun", "are"]

(*
 * (b) Write a function get_substitutions1, which takes a string list list (a
 * list of list of strings, the substitutions) and a string s and returns a
 * string list. The result has all the strings that are in some list in
 * substitutions that also has s, but s itself should not be in the result.
 * Example:
 *
 *   get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred")
 *   (* answer: ["Fredrick","Freddie","F"] *)
 *
 * Assume each list in substitutions has no repeats. The result will have
 * repeats if s and another string are both in more than one list in
 *  substitutions. Example:
 *
 *   get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff")
 *   (* answer: ["Jeffrey","Geoff","Jeffrey"] *)
 *
 * Use part (a) and ML's list-append (@) but no other helper functions. Sample
 * solution is around 6 lines.
 *)



(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
