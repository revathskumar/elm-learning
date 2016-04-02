import Graphics.Element exposing (..)
import List

fizzBuzz : Int -> String
fizzBuzz i =
  if i % 3 == 0 then "Fizz" else
     if i % 5 == 0 then "Buzz" else toString(i)

    

main = show (List.map fizzBuzz [1..10])
