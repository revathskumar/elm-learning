import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Html exposing (..)
import Color exposing (..)
import Mouse
{--
view : (Int, Int) -> Element
view pos =
  let (x, y) = pos
  in 
    collage 200 200 
    [ circle 20
        |> filled(rgb 0 0 0)
        |> move pos
    ]
--}

view : (Int, Int) -> Html
view pos = 
  let (x, y) = pos
  in 
    div [] [
      span [] [Html.text "Mouse Position :: "],
      span [] [Html.text ("x = " ++ (toString x) ++ " y =  " ++ (toString y))]
    ]

main = Signal.map view Mouse.position

{--import Window
import Mouse exposing (..)
import Html exposing (..)

type alias Position = (Int, Int)

type Action = NoOp | UpdatePosition (Int, Int)

initPosition : Position
initPosition = (0, 0)

update : Action -> Position -> Position
update action pos =
  case action of
    NoOp ->
      pos
    UpdatePosition pos -> 
      pos

view : Signal.Address Action -> Position -> Html
view action pos = 
  let (x, y) = pos
  in
    div [] [
      span [] [text "Mouse Position :: "],
      span [] [text ("x = " ++ x ++ " y =  " ++ y)]
    ]

actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp

model : Signal Position
model =
  Signal.foldp update initPosition actions.signal

main : Signal Html
main =
  Signal.map (view actions.address) model
--}

