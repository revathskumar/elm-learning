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

view : Fruits -> Html Action
view fruits =
  div [] [
    div [] [text "Filter the list"],
    div [] [
      label [for "filter"] [text "Filter names"],
      input [
        type_ "text",
        id "filter",
        onInput UpdateField
      ] []
    ],
    div [] [
      ul [] (List.map listItem (List.filter (filterItem fruits.field) fruits.items))
    ]
  ]

filterItem : String -> String -> Bool
filterItem str item =
  String.startsWith str item

listItem : String -> Html msg
listItem item =
  li [] [text item]

-- Update
update : Action -> Fruits -> (Fruits, Cmd Action)
update action fruits  =
  case action of
    NoOp -> (fruits, Cmd.none)
    UpdateField str ->
      ({fruits | field = str}, Cmd.none)


init : (Fruits, Cmd Action)
init =
  (initFruits, Cmd.none)

subscriptions : Fruits -> Sub Action
subscriptions fruits =
  Sub.none

main =
  Html.program {init = init, update = update, view = view, subscriptions = subscriptions}
