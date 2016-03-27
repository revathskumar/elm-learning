import Html exposing (..)
import Html.Events exposing (onClick)

type alias Model = Int
type Action = NoOp | Inc | Dec

update : Action -> Model -> Model
update action model =
  case action of
    NoOp -> model
    Inc -> model + 1
    Dec -> model - 1

view : Signal.Address Action -> Model -> Html
view address model = 
  div [] [
    div [] [text "Counter"],
    div [] [text ("From model :: " ++ (toString model))],
    div [] [
      button [onClick address Dec] [text "-"],
      span [] [text (toString model)],
      button [onClick address Inc] [text "+"]
    ]
  ]

actions : Signal.Mailbox Action 
actions = 
  Signal.mailbox NoOp

model : Signal Model
model =
  Signal.foldp update 0 actions.signal

main : Signal Html
main = Signal.map (view actions.address) model
