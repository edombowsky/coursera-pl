(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw2provided.sml";

(*------------------*)
(* QUESTION 1 TESTS *)
(*------------------*)

val str_list1 = ["strings", "are", "fun"]
val str_list2 = ["fun", "are", "strings"]
val str_list3 = ["fun", "are"]
val str_list4 = ["strings", "are", "fun", "strings"]

val names1 = [["Fred", "Fredrick"], ["Elizabeth", "Betty"], ["Freddie", "Fred", "F"]]
val names2 = [["Fred", "Fredrick"], ["Jeff", "Jeffrey"], ["Geoff", "Jeff", "Jeffrey"]]

val sub2_result1 = [{first = "Fred", last = "Smith", middle = "W"},
                    {first = "Fredrick", last = "Smith", middle = "W"},
                    {first = "F", last = "Smith", middle = "W"},
                    {first = "Freddie", last = "Smith", middle = "W"}]
val sub2_result2 = [{first = "Jeff", last = "Smith", middle = "W"},
                    {first = "Geoff", last = "Smith", middle = "W"},
                    {first = "Jeffrey", last = "Smith", middle = "W"},
                    {first = "Jeffrey", last = "Smith", middle = "W"}]
val sub2_result3 = [{first = "Jeff", middle = "W", last = "Smith"}]

(* all_except_one *)
val test1 = all_except_option("string", ["string"]) = SOME []

val test1_1 = all_except_option("strings", str_list1) = SOME ["are", "fun"]
val test1_2 = all_except_option("strings", str_list2) = SOME ["fun", "are"]
val test1_3 = all_except_option("strings", str_list3) = NONE
val test1_5 = all_except_option("strings", str_list4) = SOME (["are", "fun", "strings"])


(* get_substitutions1 *)
val test2 = get_substitutions1([["foo"],["there"]], "foo") = []

val test2_1 = get_substitutions1(names1, "Fred") = ["Fredrick", "Freddie", "F"]
val test2_2 = get_substitutions1(names2, "Jeff") = ["Jeffrey", "Geoff", "Jeffrey"]
val test2_3 = get_substitutions2(names2, "Maris") = []


(* get_substitutions2 *)
val test3 = get_substitutions2([["foo"],["there"]], "foo") = []

val test3_1 = get_substitutions2(names1, "Fred") = ["Freddie", "F", "Fredrick"]
val test3_2 = get_substitutions2(names2, "Jeff") = ["Geoff", "Jeffrey", "Jeffrey"]
val test3_3 = get_substitutions2(names2, "Maris") = []


(* similar_names *)
(* 
 * This reports false but it does acually meet the requirements. That is,
 * "The answer should begin with the original name (then have 0 or more other names)"
 *)
val test4 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
       [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
        {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]


val test4_1 = similar_names(names2, {first = "Jeff", middle = "W", last = "Smith"}) = sub2_result2
val test4_2 = similar_names(names1, {first = "Jeff", middle = "W", last = "Smith"}) = sub2_result3

(*------------------*)
(* QUESTION 2 TESTS *)
(*------------------*)

val cards1 = [(Clubs, Jack), (Spades, Num 8)]
val cards2 = [(Clubs, Ace), (Spades, Ace), (Clubs, Ace), (Spades, Ace)]
val cards3 = [(Clubs, Ace), (Diamonds, King)]

(* card_color *)
val test5 = card_color((Clubs, Num 2)) = Black

val test5_1 = card_color((Spades,   Num 2)) = Black
val test5_2 = card_color((Diamonds, Num 2)) = Red
val test5_3 = card_color((Hearts,   Num 2)) = Red

(* card_value *)
val test6 = card_value((Clubs, Num 2)) = 2

val test6_1 = card_value((Clubs, Ace))   = 11
val test6_2 = card_value((Clubs, King))  = 10
val test6_3 = card_value((Clubs, Queen)) = 10
val test6_4 = card_value((Clubs, Jack))  = 10

(* remove_card *)
val test7 = remove_card([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []

val test7_1 = remove_card(cards1, (Clubs, Jack),   IllegalMove) = [(Spades, Num 8)]
val test7_2 = remove_card(cards2, (Spades, Ace),   IllegalMove) = [(Clubs, Ace), (Clubs, Ace), (Spades, Ace)]
val test7_3 = remove_card(cards2, (Clubs, Ace),    IllegalMove) = [(Spades, Ace), (Clubs, Ace), (Spades, Ace)]
val test7_4 = remove_card(cards1, (Spades, Num 8), IllegalMove) = [(Clubs, Jack)]
val test7_5 = (remove_card(cards2, (Spades, Num 8), IllegalMove) handle IllegalMove => [ ]) = [ ]

(* all_same_color *)
val test8 = all_same_color([(Hearts, Ace), (Hearts, Ace)]) = true

val test8_1 = all_same_color([(Hearts, Ace), (Spades, Ace)]) = false
val test8_2 = all_same_color([]) = true
val test8_3 = all_same_color([(Hearts, Ace)]) = true

(* sum_cards *)
val test9 = sum_cards([(Clubs, Num 2),(Clubs, Num 2)]) = 4

val test9_1 = sum_cards([]) = 0
val test9_2 = sum_cards([(Clubs, Queen), (Spades, Ace)]) = 21

(* score *)
val test10 = score([(Hearts, Num 2),(Clubs, Num 4)],10) = 4

val test10_1 = score(cards2, 44) = 0
val test10_2 = score(cards2, 48) = 2
val test10_3 = score(cards2, 40) = 6

(* officiate *)
val test11 = officiate([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6
val test12 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                       [Draw,Draw,Draw,Draw,Draw],
                       42)
             = 3
val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)


(*-----------------------------*)
(* CHALLENGE QUESTIONS TESTING *)
(*-----------------------------*)
val test3a_1 =
   let
      val c1 = (Hearts,Ace)
      val c2 = (Spades,Ace)
   in [
        score_challenge([c1, c2, c2, c2, c2, c2, c2, c2, c2], 99) = 0,
        score_challenge([c1, c2, c2, c2, c2, c2, c2, c2, c2], 89) = 0,
        score_challenge([c1, c2, c2, c2, c2, c2, c2, c2, c2], 53) = 4,
        score_challenge([c1, c2, c2, c2, c2, c2, c2, c2, c2], 52) = 3,
        score_challenge([c1, c2, c2, c2, c2, c2, c2, c2, c2], 51) = 2,
        score_challenge([c1, c2, c2, c2, c2, c2, c2, c2, c2], 50) = 1,
        score_challenge([c1, c2, c2, c2, c2, c2, c2, c2, c2], 49) = 0,
        score_challenge([c1, c2, c2, c2, c2, c2, c2, c2, c2], 48) = 3,
        score_challenge([c1, c2, c2, c2, c2, c2, c2, c2, c2], 47) = 6,
        score_challenge([c1, c2, c2, c2, c2, c2, c2, c2, c2], 46) = 7
      ]
   end

val test3a_2 = 
   let
      val cards = [(Clubs, Ace), (Spades, Ace), (Clubs, Ace), (Hearts, Ace)]
      val moves1 = [Draw, Draw, Draw, Draw, Draw]
   in [
        officiate_challenge(cards, moves1, 44) = 0,
        officiate_challenge(cards, moves1, 43) = 3,
        officiate_challenge(cards, moves1, 42) = 6,
        officiate_challenge(cards, moves1, 41) = 7,
        officiate_challenge(cards, moves1, 40) = 6
      ]
   end

val test3b = 
   let
      val cards1 = [(Spades, Num 7), (Hearts, King), (Clubs, Ace), (Diamonds, Num 2)]
      val cards2 = [(Spades, Num 8), (Hearts, King), (Clubs, Ace), (Diamonds, Num 2)]
      val cards3 = [(Spades, Ace), (Hearts, Queen), (Spades, Num 7)]
      val cards4 = [(Spades, Num 7), (Hearts, King), (Clubs, Ace), (Diamonds, Num 2)]
      val cards5 = [(Clubs, Ace), (Spades, Ace), (Diamonds, Ace), (Hearts, Ace), (Clubs, Num 10), (Spades, Num 10)]
      val cards6 = [(Spades, Num 7)]
   in
      [
       careful_player(cards1, 18),
       careful_player(cards1, 8),
       careful_player(cards2, 8),
       careful_player(cards2, 18),
       careful_player(cards2, 20),
       careful_player(cards2, 21),
       careful_player(cards3, 21),
       careful_player(cards4, 18),
       careful_player(cards4, 17),
       careful_player(cards5, 42),
       careful_player(cards6, 8)
      ]
   end
