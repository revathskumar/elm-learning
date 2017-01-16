import Element exposing (toHtml, show)
import List

fizzBuzz : Int -> String
fizzBuzz i =
  if i % 15 == 0 then "Fizz Buzz" else
    if i % 3 == 0 then "Fizz" else
      if i % 5 == 0 then "Buzz" else toString(i)

main = toHtml (show (List.map fizzBuzz (List.range 1 15)))
