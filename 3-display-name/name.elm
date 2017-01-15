import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String

main = Html.beginnerProgram { model = "", update = update, view = view}

type Msg = Content String

update (Content content) oldContent =
  content

view content =
  div [] [
    div [] [
      span [] [text "Enter Your Name :: "],
      input [
        type_ "text",
        name "name",
        value content,
        onInput Content
      ] []
    ],
    div [] [
      span [] [text ("My Name is " ++ content)]
    ]
  ]
