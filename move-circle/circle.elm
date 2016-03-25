import Graphics.Element exposing (..)
import Time exposing (..)
import Keyboard

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
  let dt = fps 30
      tuples = Signal.map2 (,) dt Keyboard.arrows
  in Signal.sampleOn dt tuples

dt = 100
keys = { x = -1, y = 1}

main : Signal Element
main = Signal.map show (Signal.foldp update initBall inputSignal)

