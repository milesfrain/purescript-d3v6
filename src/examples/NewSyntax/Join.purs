module NewSyntax.Join where

import D3.Base

import Affjax (Error)
import Data.Either (Either(..))
import Data.String.CodeUnits (toCharArray)
import Data.Tuple (Tuple(..))
import Debug.Trace (spy)
import Math (pi)
import Prelude (const, identity, negate, show, ($), (*), (-), (/), (<), (<>), (==), (>=), (>>>))
import Unsafe.Coerce (unsafeCoerce)

-- we give the chart our Model type but behind the scenes it is mutated by D3 and additionally
-- which projection of the "Model" is active in each Join varies so we can't have both strong
-- static type representations AND lightweight syntax with JS compatible lambdas

-- previously called D3TreeNode
{-
d3MyLetter :: Datum -> D3MyLetter
d3MyLetter = unsafeCoerce
-}

foreign import unused :: Number

dataToModel :: Datum -> Model
dataToModel = unsafeCoerce

modelToSubModel :: Model -> SubModel
modelToSubModel = toCharArray >>> unsafeCoerce

-- Model is just a String
type Model = String

initialModel :: String
initialModel = "abcd"

chart :: Tuple Number Number -> Selection Model
chart (Tuple width height) =
  -- ignoring height
  initialSelect "div#join" "someLetters" noAttrs $
    [
      appendNamed "svg" Svg [ viewBox 0.0 (-20.0) width 33.0 ]
        [ join Text modelToSubModel
          (append Text
            [ NumberAttr "x" (const 5.0) --todo_i16
            , TextAttr (const "F") --identity
            ]
            noChildren
          )
          noUpdate noExit
        ]
    ]