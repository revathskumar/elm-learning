import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Time exposing (..)
import Color exposing (..)
import Keyboard
import Window

type alias Ball = 
  { position : Float
  , velocity : Float  
  }

initBall : Ball
initBall = 
  { position = 0
  , velocity = 0
  }

applyPhysics : Float -> Ball -> Ball
applyPhysics dt ball =
  { ball | position = ball.position + ball.velocity * dt }

updateVelocity : Float -> Ball -> Ball
updateVelocity newVelocity ball = 
  { ball | velocity = newVelocity }

type alias Keys = {x : Int, y: Int}

update : (Float, Keys) -> Ball -> Ball
update (dt, keys) ball =
  let newVel = toFloat keys.x
  in updateVelocity newVel (applyPhysics dt ball)

inputSignal : Signal (Float, Keys)
inputSignal = 
  Signal.map2 (,) (fps 30) Keyboard.arrows

view : (Int, Int) -> Ball -> Element
view (w, h) ball =
  collage w h 
    [ circle 20 
        |> filled (rgb 0 0 0) 
        |> move (ball.position, 0)
    ]

dt = 100
keys = { x = -1, y = 1}

main : Signal Element
main = Signal.map2 view Window.dimensions (Signal.foldp update initBall inputSignal)

