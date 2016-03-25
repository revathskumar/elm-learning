import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)

type alias User = String

type Action = NoOp | UpdateName String

view : Signal.Address Action -> User -> Html
view address user =
  div [] [
    div [] [
      span [] [text "Enter Your Name :: "],
      input [
        type' "text", 
        name "name",
        value user,
        on "input" targetValue (Signal.message address <<  UpdateName)
      ] []
    ],
    div [] [
      span [] [text ("My Name is " ++ user)]
    ]
  ]

update : Action -> User -> User
update action user =
  case action of
    NoOp -> user
    UpdateName str ->
      str

actions : Signal.Mailbox Action
actions =
    Signal.mailbox NoOp

model : Signal User
model =
    Signal.foldp update ""  actions.signal

main : Signal Html
main = 
    Signal.map (view actions.address) model

