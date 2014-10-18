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
   let
      fun remove_from_list (str_to_remove, remaining_list) =
         case remaining_list of
            [] => []
         | x :: xs => if same_string(x, str_to_remove) then xs
                      else x :: remove_from_list(str_to_remove, xs)

         val filtered_list = remove_from_list(str, string_list)
      in
         if filtered_list = string_list then NONE else SOME filtered_list
      end

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
 * substitutions. Example:
 *
 *   get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff")
 *   (* answer: ["Jeffrey","Geoff","Jeffrey"] *)
 *
 * Use part (a) and ML's list-append (@) but no other helper functions. Sample
 * solution is around 6 lines.
 *)
fun get_substitutions1 ([ ], _) = [ ]
   | get_substitutions1 (x :: xs, str) = case all_except_option (str, x) of
                                             NONE => get_substitutions1 (xs, str)
                                         | SOME y => y @ get_substitutions1 (xs, str)

(*
 * Write a function get_substitutions2, which is like get_substitutions1
 * except it uses a tail-recursive local helper function.         
 *)
fun get_substitutions2 (lst, str) =
   let
      fun iter ([ ], acc) = acc
         | iter (x :: xs, acc) = case all_except_option (str, x) of
                                    NONE => iter (xs, acc)
                                 | SOME y => iter (xs, y @ acc)
   in
      iter(lst, [ ])
   end

(*
 * Write a function similar_names, which takes a string list list of 
 * substitutions (as in parts (b) and (c)) and a full name of 
 * type{first:string,middle:string,last:string} and returns a list of full
 * names (type{first:string,middle:string,last:string} list). The result is
 * all the full names you can produce by substituting for the first name (and
 * only the first name) using substitutions and parts (b) or (c). The answer
 * should begin with the original name (then have 0 or more other names). 
 * 
 * Example:
 *
 * similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
 *                {first="Fred", middle="W", last="Smith"})
 * (* answer: [{first="Fred", last="Smith", middle="W"},
 *             {first="Fredrick", last="Smith", middle="W"},
 *             {first="Freddie", last="Smith", middle="W"},
 *             {first="F", last="Smith", middle="W"}] *)
 *
 * Do not eliminate duplicates from the answer. Hint: Use a local helper
 * function. Sample solution is around 10 lines.
 *)
fun similar_names(substitutions: string list list, {first=first, middle=middle, last=last}) =
   let 
      val first_names = first :: get_substitutions2(substitutions, first);
      fun helper (first_name_list : string list) =
         case first_name_list of
            [] => []
         | x::x' => {first=x, middle=middle, last=last} :: helper(x')
   in
      helper(first_names)
   end


(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
