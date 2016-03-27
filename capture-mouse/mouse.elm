import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Html exposing (..)
import Color exposing (..)
import Mouse
import Window

view : (Int, Int) -> (Int, Int) -> Html
view (w, h) (x, y) =
  div [] [
    span [] [Html.text "Mouse Position :: "],
    span [] [Html.text ("x = " ++ (toString x) ++ " y =  " ++ (toString y))],
    div [] [
      fromElement (collage w h 
        [ circle 20
            |> filled(rgb 0 0 0)
            |> move ((toFloat x) - ((toFloat w) / 2), ((toFloat h) / 2) - (toFloat y))
        ])
    ]
  ]

main = Signal.map2 view Window.dimensions Mouse.position

