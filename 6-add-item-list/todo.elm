import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)

type alias Todos = {
  items : List String,
  field : String
}

initTodos : Todos
initTodos =
  {
    items = [],
    field = ""
  }

addItem : Todos -> Todos
addItem todos =
  {todos | items = (List.append todos.items [todos.field]), field = ""}

type Action = NoOp | Add | UpdateField String

view : Todos -> Html Action
view todos =
  div [] [
    h1 [] [text "Add Item"],
    div [] [
      input [
        type_ "text",
        name "list",
        value todos.field,
        placeholder "Todo",
        onInput UpdateField
      ] [],
      button [name "add", (onClick Add) ] [text "Add Todo"]
    ],
    div [] [
      ul [] (List.map todoList todos.items)
    ]
  ]

todoList : String -> Html Action
todoList item =
  li [] [text item]

update : Action -> Todos -> (Todos, Cmd Action)
update action todos =
  case action of
    NoOp -> (todos, Cmd.none)
    Add -> (addItem todos, Cmd.none)
    UpdateField str ->
      ({todos | field = str}, Cmd.none)

subscriptions : Todos -> Sub Action
subscriptions todos =
  Sub.none

init : (Todos, Cmd Action)
init =
  (initTodos, Cmd.none)

main =
  Html.program {init = init, update = update, view = view, subscriptions = subscriptions}
