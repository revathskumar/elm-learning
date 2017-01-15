{-
type alias Model = Int

type Action = Increment | Decrement

update : Action -> Model -> Model
update action model =
  case action of
    Increment -> model + 1
    Decrement -> model - 1

main =

-}

import Html exposing (..)
import Html.Attributes exposing (..)

main : Html msg
main =
  div [id "main"] [
    div [class "welcome"] [text "Hello World!!"],
    div [] [text "Another Message with external js"]
  ]
