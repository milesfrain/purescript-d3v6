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

-- Placeholder in case we need FFI later
foreign import unused :: Number

-- Model is just a String
type Model = String

dataToModel :: Datum -> Model
dataToModel = unsafeCoerce

-- If I want indicies in my Datum, do I need to pass
-- those to SubModel, or are they added automatically later?
modelToSubModel :: Model -> SubModel
modelToSubModel = toCharArray >>> unsafeCoerce

datumToChar :: Datum -> String
datumToChar = unsafeCoerce

chart :: Tuple Number Number -> Selection Model
chart (Tuple width height) =
  -- ignoring height
  initialSelect "div#join" "someLetters" noAttrs $
    [
      appendNamed "svg" Svg [ viewBox 0.0 (-20.0) width 33.0 ]
        [ join Text modelToSubModel
          (append Text
            [ NumberAttrI "x" (\_ i -> i * 16.0)
            , TextAttr datumToChar
            ]
            noChildren
          )
          noUpdate noExit
        ]
    ]