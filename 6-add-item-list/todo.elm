import Graphics.Element exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, on, targetValue)
import Signal exposing (Signal, Address)

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

view : Address Action -> Todos -> Html
view address todos = 
  div [] [
    h1 [] [text "Add Item"],
    div [] [
      input [
        type' "text", 
        name "list",
        value todos.field,
        placeholder "Todo", 
        on "input" targetValue (Signal.message address << UpdateField) 
      ] [],
      button [name "add", onClick address Add ] [text "Add Todo"]
    ],
    div [] [
      ul [] (List.map todoList todos.items)
    ]
  ]

todoList : String -> Html
todoList item =
  li [] [text item]

update : Action -> Todos -> Todos
update action todos =
  case action of 
    NoOp -> todos
    Add -> addItem todos
    UpdateField str -> 
      {todos | field = str}

actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp

model : Signal Todos
model =
  Signal.foldp update initTodos  actions.signal

main : Signal Html
main = 
  Signal.map (view actions.address) model
