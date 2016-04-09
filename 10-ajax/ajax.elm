import Html exposing (..)
import Graphics.Element exposing (..)
import Task exposing (Task, succeed)
import Time exposing (Time, second)

printTask : Signal (Task x Float) 
printTask = 
  Debug.log "printTask"
  Signal.map Task.succeed (Time.every second)

port runnur : Signal (Task x Float)
port runnur = 
  printTask

main : Signal Element
main = Signal.map show printTask
