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
Correct! You have earned {current_score} points and you currently have {total_score} points. #mood:right  #role:teacher
~ current_score = 0
~ wrong_guesses = 0
#mood:neutral
-> DONE

=== wrong_guess ===
~ wrong_guesses ++

You guessed wrong.  Try again! #mood:wrong #role:teacher
#mood:neutral
->->

=== Quiz_Begin ===

= Q1 
#role:teacher
1. In what month and year did our journey begin?  
#role:student
* [July 2021] 
    -> wrong_guess ->
    -> Q1
* [June 2022]
    <- score_snippet
    -> Q2
* [July 2022]
    -> wrong_guess ->
    -> Q1
* [August 2022]
    -> wrong_guess ->
    -> Q1
    
= Q2
#role:teacher
2. What was the name of the mall where we waited for the ferry in the parking lot? 
#role:student
* [West Edmonton Mall]
    -> wrong_guess ->
    -> Q2
* [Tsawassen Mills]
    <- score_snippet
    -> Q3
* [Iron Mills Outlet Mall]
    -> wrong_guess ->
    -> Q2
* [Eaton Center]
    -> wrong_guess ->
    -> Q2

= Q3
#role:teacher
3. In which town did we camp for the first week of our trip?
#role:student
* [Victoria]
    -> wrong_guess ->
    -> Q3
* [Nanaimo]
    -> wrong_guess ->
    -> Q3
* [Parksville]
     <- score_snippet
    -> Q4
* [Lethbridge]
    -> wrong_guess ->
    -> Q3
    
=Q4
#role:teacher
4. What typical Canadian thing did you see at the beach at the Surfside RV Park? 
#role:student
* [Canadian Flag] 
     <- score_snippet
    -> Q5
* [Beaver Dam]
     -> wrong_guess ->
    -> Q4
* [Maple Tree]
     -> wrong_guess ->
    -> Q4
* [Flock of Canada Geese]
    -> wrong_guess ->
    -> Q4

= Q5
#role:teacher
5. What animals did we see on the roof in Coombs, BC?
#role:student
* [Deer ]
    -> wrong_guess ->
        -> Q5
* [Goats]
    <- score_snippet
    -> Q6
* [Moose]
    -> wrong_guess ->
        -> Q5
* [Ducks]
    -> wrong_guess ->
        -> Q5
    
= Q6
#role:teacher
6. What is the name of the attraction with the gigantic trees on Vancouver Island?
#role:student
* [Botanical Garden ]
   -> wrong_guess ->
    -> Q6
* [Tree Sanctuary]
   -> wrong_guess ->
    -> Q6
* [Mossy Meadows]
   -> wrong_guess ->
    -> Q6
* [Cathedral Grove]
    <- score_snippet
    -> Q7

= Q7
#role:teacher
7. In what town did we dip our feet first into the ocean? 
#role:student
* [Ucluelet]
   -> wrong_guess ->
    -> Q7
* [Tofino]
    <- score_snippet
    -> Q8
* [Halifax]
   -> wrong_guess ->
    -> Q7
* [Vancouver]
   -> wrong_guess ->
    -> Q7

= Q8
#role:teacher
8. What was the name of the National Park located between Ucluelet and Tofino?
#role:student
* [Atlantic Coast National Park] 
   -> wrong_guess ->
    -> Q8
* [Vancouver Island Ocean National Park]
   -> wrong_guess ->
    -> Q8
* [Lighthouse Cliffs National Park]
   -> wrong_guess ->
    -> Q8
* [Pacific Rim National Park]
    <- score_snippet
    -> Q9
    
=Q9
#role:teacher
9.  In what family favorite restaurant did we meet up with Grandpa and Rosie in Vancouver?
#role:student
* [McDonalds] 
   -> wrong_guess ->
    -> Q9
* [Red Robin's]
    <- score_snippet
    -> Q10
* [Boston Pizza]
   -> wrong_guess ->
    -> Q9
* [IHOP]
   -> wrong_guess ->
    -> Q9
    
=Q10
#role:teacher
10.  What was the name of the lake where Dad almost broke Allie's back with his crazy motorboat skills?
#role:student
* [Osoyoos Lake] 
    <- score_snippet
    -> Q11
* [Kootenay Lake]
   -> wrong_guess ->
    -> Q10
* [Sylvan Lake]
   -> wrong_guess ->
    -> Q10
* [Harrison Lake]
   -> wrong_guess ->
    -> Q10

= Q11
#role:teacher
11.  What was the theme of the museum with the old trains and rusted machinery in Rockland BC?
#role:student
* [Mining] 
    <- score_snippet
    -> Q12
* [Hydropower]
   -> wrong_guess ->
    -> Q11
* [Farming]
   -> wrong_guess ->
    -> Q11
* [Explorers]
   -> wrong_guess ->
    -> Q11

=Q12
#role:teacher
12. What was the name of the (only) city in Alberta where we spent out first night at a Walmart? 
#role:student
* [Calgary ]
   -> wrong_guess ->
    -> Q12
* [Banff]
   -> wrong_guess ->
    -> Q12
* [Medicine Hat]
   -> wrong_guess ->
    -> Q12
* [Lethbridge]
    <- score_snippet
    -> Q13
    
=Q13
#role:teacher
13. What is the name of the Natural Area in Alberta where we saw the giant red rocks cut in half lying around? 
#role:student
* [Red Boulder Park] 
   -> wrong_guess ->
    -> Q13
* [Red Rock Coulee]
    <- score_snippet
    -> Q14
* [Tomato Valley]
   -> wrong_guess ->
    -> Q13
* [Red Rock Reserve]
   -> wrong_guess ->
    -> Q13
    
= Q14
#role:teacher
14. In what city did we visit the RCMP Museum where you guys did the scavenger hunt?
#role:student
* [Calgary ]
   -> wrong_guess ->
    -> Q14
* [Saskatoon]
   -> wrong_guess ->
    -> Q14
* [Winnipeg]
   -> wrong_guess ->
    -> Q14
* [Regina]
    <- score_snippet
    -> Q15
    
=Q15
#role:teacher
15.  Where did we camp on our only night in Saskatchewan? 
#role:student
* [In a forest ]
   -> wrong_guess ->
    -> Q15
* [At a Walmart]
   -> wrong_guess ->
    -> Q15
* [On a farm]
    <- score_snippet
    -> Q16
* [Beside a river]
   -> wrong_guess ->
    -> Q15
    
=Q16
#role:teacher
16.  BONUS QUESTION: In Trail, BC, what animal did we see riding shotgun in the car next to us? 
#role:student
* [Elephant ]
   -> wrong_guess ->
    -> Q16
* [Giraffe]
   -> wrong_guess ->
    -> Q16
* [Beaver]
   -> wrong_guess ->
    -> Q16
* [Big Horn Sheep]
    <- score_snippet
    -> QuizOver

= QuizOver
#role:teacher
Thanks for taking this quiz!  You did better than I expected! #mood:neutral #mood:shout
->END


