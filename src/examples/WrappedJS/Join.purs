module D3.Example.Join where

import Prelude

import Data.Tuple (Tuple(..))

foreign import chartFFI :: String -> Int -> Int -> Unit

chart :: Tuple Int Int -> Unit
chart (Tuple width height) = chartFFI "div#join" width height