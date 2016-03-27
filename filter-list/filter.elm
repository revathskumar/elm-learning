import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String

type alias Fruits = {
    items : List String,
    field : String
  }

initFruits : Fruits
initFruits =
  {
    items = ["Apple", "Banana", "Orange", "Anar", "Grapes"],
    field = ""
  }

-- Action

type Action = NoOp | UpdateField String


-- View

view : Signal.Address Action -> Fruits -> Html
view address fruits = 
  div [] [
    div [] [text "Filter the list"],
    div [] [
      label [for "filter"] [text "Filter names"],
      input [
        type' "text", 
        id "filter",
        on "input" targetValue (Signal.message address << UpdateField)
      ] []
    ],
    div [] [
      ul [] (List.map listItem (List.filter (filterItem fruits.field) fruits.items))
    ]
  ]

filterItem : String -> String -> Bool
filterItem str item =
  String.startsWith str item

listItem : String -> Html
listItem item = 
  li [] [text item]

-- Update
update : Action -> Fruits -> Fruits
update action fruits  = 
  case action of
    NoOp -> fruits
    UpdateField str ->
      {fruits | field = str}


actions : Signal.Mailbox Action
actions = 
  Signal.mailbox NoOp

model : Signal Fruits
model = 
  Signal.foldp update initFruits actions.signal

main : Signal Html
main = Signal.map (view actions.address) model 
