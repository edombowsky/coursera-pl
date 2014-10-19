(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(*---------------------------------------*)
(* put your solutions for problem 1 here *)
(*---------------------------------------*)

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

(*---------------------------------------*)
(* put your solutions for problem 2 here *)
(*---------------------------------------*)

(*
 * This problem involves a solitaire card game invented just for this question.
 * You will write a program that tracks the progress of a game; writing a game
 * player is a challenge problem. You can do parts (a)–(e) before understanding
 * the game if you wish.
 *
 * A game is played with a card-list and a goal. The player has a list of
 * held-cards, initially empty. The player makes a move by either drawing,
 * which means removing the first card in the card-list from the card-list and
 * adding it to the held-cards, or discarding, which means choosing one of the
 * held-cards to remove. The game ends either when the player chooses to make
 * no more moves or when the sum of the values of the held-cards is greater than
 * the goal.
 *
 * The objective is to end the game with a low score (0 is best). Scoring works
 * as follows: Let sum be the sum of the values of the held-cards. If sum is
 * greater than goal, the preliminary score is three times (sum−goal), else the
 * preliminary score is (goal − sum). The score is the preliminary score unless
 * all the held-cards are the same color, in which case the score is the
 * preliminary score divided by 2 (and rounded down as usual with integer
 * division; use ML’s div operator).
*)

(*
 * (a) Write a function card_color, which takes a card and returns its color
 * (spades and clubs are black, diamonds and hearts are red). Note: One
 * case-expression is enough.
 *)
fun card_color(a_card) =
   case a_card of
      (Spades, _)  => Black
   | (Clubs, _)    => Black
   | (Hearts, _)   => Red
   | (Diamonds, _) => Red

(*
 * (b) Write a function card_value, which takes a card and returns its value
 * (numbered cards have their number as the value, aces are 11, everything else
 * is 10). Note: One case-expression is enough.
 *)
fun card_value(a_card) =
   case a_card of
      (_, Num num) => num
   | (_, Ace) => 11
   | (_, _) => 10

(*
 * (c) Write a function remove_card, which takes a list of cards cs, a card c,
 * and an exception e. It returns a list that has all the elements of cs except
 * c. If c is in the list more than once, remove only the first one. If c is not
 * in the list, raise the exception e. You can compare cards with =.
 *)
fun remove_card(cards: card list, a_card: card, exp: exn) =
   case cards of
      [] => raise exp
   | x :: xs => if a_card = x then xs
                else x :: remove_card(xs, a_card, exp)

(*
 * (d) Write a function all_same_color, which takes a list of cards and returns
 * true if all the cards in the list are the same color. Hint: An elegant
 * solution is very similar to one of the functions using nested pattern-matching
 * in the lectures.
 *)
fun all_same_color(cards) =
   case cards of
      [] => true
   | first :: [] => true
   | first :: second :: rest => if card_color(first) = card_color(second) then all_same_color(second :: rest)
                                else false

(*
 * (e) Write a function sum_cards, which takes a list of cards and returns the
 * sum of their values. Use a locally defined helper function that is tail
 * recursive. (Take “calls use a constant amount of stack space” as a
 * requirement for this problem.)
*)
fun sum_cards(cards) =
   let
      fun accumulate(reamaining, sum) =
         case reamaining of
            [] => sum
         | x :: xs => accumulate(xs, sum + card_value(x))
   in
      accumulate(cards, 0)
   end


(*
 * (f) Write a function score, which takes a card list (the held-cards) and an
 * int (the goal) and computes the score as described above.
 *)

(*
 * (g) Write a function officiate, which “runs a game.” It takes a card list
 * (the card-list) a move list (what the player “does” at each point), and an
 * int (the goal) and returns the score at the end of the game after processing
 * (some or all of) the moves in the move list in order. Use a locally defined
 * recursive helper function that takes several arguments that together 
 * represent the current state of the game. As described above:
 *     - The game starts with the held-cards being the empty list.
 *     - The game ends if there are no more moves. (The player chose to stop
 *       since the move list is empty.)
 *     - If the player discards some card c, play continues (i.e., make a
 *       recursive call) with the held-cards not having c and the card-list
 *       unchanged. If c is not in the held-cards, raise the IllegalMove
 *       exception.
 *     - If the player draws and the card-list is (already) empty, the game is
 *       over. Else if drawing causes the sum of the held-cards to exceed the
 *       goal, the game is over (after drawing). Else play continues with a
 *       larger held-cards and a smaller card-list.
 *
 * Sample solution for (g) is under 20 lines.
 *)
