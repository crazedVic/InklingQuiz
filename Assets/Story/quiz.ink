VAR current_score = 0
VAR total_score = 0
VAR wrong_guesses = 0

-> Quiz_Begin

=== score_snippet ===
{ wrong_guesses == 0:
	~ current_score = 5
- else:
	~ current_score = 5 - wrong_guesses - 1
}
~ total_score = total_score + current_score
Correct! #shout #right
You have earned {current_score} points. #right
You currently have {total_score} points\.#right
blank #blank
~ current_score = 0
~ wrong_guesses = 0
-> DONE

=== wrong_guess ===
~ wrong_guesses ++

You guessed wrong.  Try again! #wrong
blank #blank
->->

=== Quiz_Begin ===

= Q1 
1. In what month and year did our journey begin? #question
* July 2021
    -> wrong_guess ->
    -> Q1
* June 2022
    <- score_snippet
    -> Q2
* July 2022
    -> wrong_guess ->
    -> Q1
* August 2022
    -> wrong_guess ->
    -> Q1
    
= Q2


2. What was the name of the mall where we waited for the ferry in the parking lot?
* West Edmonton Mall
    -> wrong_guess ->
    -> Q2
* Tsawassen Mills
    <- score_snippet
    -> Q3
* Iron Mills Outlet Mall
    -> wrong_guess ->
    -> Q2
* Eaton Center
    -> wrong_guess ->
    -> Q2

= Q3
3. In which town did we camp for the first week of our trip?
* Victoria
    -> wrong_guess ->
    -> Q3
* Nanaimo
    -> wrong_guess ->
    -> Q3
* Parksville
     <- score_snippet
    -> Q4
* Lethbridge
    -> wrong_guess ->
    -> Q3
    
=Q4
4. What typical Canadian thing did you see at the beach at the Surfside RV Park?
* Canadian Flag
     <- score_snippet
    -> Q5
* Beaver Dam
     -> wrong_guess ->
    -> Q4
* Maple Tree
     -> wrong_guess ->
    -> Q4
* Flock of Canada Geese
    -> wrong_guess ->
    -> Q4

= Q5
5. What animals did we see on the roof in Coombs, BC?
* Deer
    -> wrong_guess ->
        -> Q5
* Goats
    <- score_snippet
    -> Q6
* Moose
    -> wrong_guess ->
        -> Q5
* Ducks
    -> wrong_guess ->
        -> Q5
    
= Q6
6. What is the name of the attraction with the gigantic trees on Vancouver Island?
* Botanical Garden
   -> wrong_guess ->
    -> Q6
* Tree Sanctuary
   -> wrong_guess ->
    -> Q6
* Mossy Meadows
   -> wrong_guess ->
    -> Q6
* Cathedral Grove
    <- score_snippet
    -> Q6

= Q7
7. In what town did we dip our feet first into the ocean?
* Ucluelet
   -> wrong_guess ->
    -> Q7
* Tofino
    <- score_snippet
    -> Q8
* Halifax
   -> wrong_guess ->
    -> Q7
* Vancouver
   -> wrong_guess ->
    -> Q7

= Q8
8. What was the name of the National Park located between Ucluelet and Tofino?
* Atlantic Coast National Park
   -> wrong_guess ->
    -> Q8
* Vancouver Island Ocean National Park
   -> wrong_guess ->
    -> Q8
* Lighthouse Cliffs National Park
   -> wrong_guess ->
    -> Q8
* Pacific Rim National Park
    <- score_snippet
    -> Q9
    
=Q9
9.  In what family favorite restaurant did we meet up with Grandpa and Rosie in Vancouver?
* McDonalds
   -> wrong_guess ->
    -> Q9
* Red Robin's
    <- score_snippet
    -> Q10
* Boston Pizza
   -> wrong_guess ->
    -> Q9
* IHOP
   -> wrong_guess ->
    -> Q9
    
=Q10
10.  What was the name of the lake where Dad almost broke Allie's back with his crazy motorboat skills?
* Osoyoos Lake
    <- score_snippet
    -> Q11
* Kootenay Lake
   -> wrong_guess ->
    -> Q10
* Sylvan Lake
   -> wrong_guess ->
    -> Q10
* Harrison Lake
   -> wrong_guess ->
    -> Q10

= Q11
11.  What was the theme of the museum with the old trains and rusted machinery in Rockland BC?
* Mining
    <- score_snippet
    -> Q12
* Hydropower
   -> wrong_guess ->
    -> Q11
* Farming
   -> wrong_guess ->
    -> Q11
* Explorers
   -> wrong_guess ->
    -> Q11

=Q12
12. What was the name of the (only) city in Alberta where we spent out first night at a Walmart?
* Calgary
   -> wrong_guess ->
    -> Q12
* Banff
   -> wrong_guess ->
    -> Q12
* Medicine Hat
   -> wrong_guess ->
    -> Q12
* Lethbridge
    <- score_snippet
    -> Q13
    
=Q13 
13. What is the name of the Natural Area in Alberta where we saw the giant red rocks cut in half lying around?
* Red Boulder Park
   -> wrong_guess ->
    -> Q13
* Red Rock Coulee
    <- score_snippet
    -> Q14
* Tomato Valley
   -> wrong_guess ->
    -> Q13
*Red Rock Reserve
   -> wrong_guess ->
    -> Q13
    
= Q14
14. In what city did we visit the RCMP Museum where you guys did the scavenger hunt?
* Calgary
   -> wrong_guess ->
    -> Q14
* Saskatoon
   -> wrong_guess ->
    -> Q14
* Winnipeg
   -> wrong_guess ->
    -> Q14
* Regina
    <- score_snippet
    -> Q15
    
=Q15
15.  Where did we camp on our only night in Saskatchewan?
* In a forest
   -> wrong_guess ->
    -> Q15
* At a Walmart
   -> wrong_guess ->
    -> Q15
* On a farm
    <- score_snippet
    -> Q16
* Beside a river
   -> wrong_guess ->
    -> Q15
    
=Q16
16.  BONUS QUESTION: In Trail, BC, what animal did we see riding shotgun in the car next to us?
* Elephant
   -> wrong_guess ->
    -> Q16
* Giraffe
   -> wrong_guess ->
    -> Q16
* Beaver
   -> wrong_guess ->
    -> Q16
* Big Horn Sheep
    <- score_snippet
    -> QuizOver

= QuizOver
Thanks for taking this quiz!  You did better than I expected! #neutral #shout
->END


