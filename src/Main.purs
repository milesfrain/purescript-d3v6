module Main where

import Prelude

import Affjax (get) as AJAX
import Affjax (printError)
import Affjax.ResponseFormat as ResponseFormat
import Control.Monad.State (StateT, runStateT)
import D3.Base (Selection)
import D3.Example.Force as WrappedForce
import D3.Example.Join as WrappedJoin
import D3.Interpreter (D3State(..), initialScope, interpretSelection, interpretSimulation, interpretTickMap, interpretDrag, startSimulation)
import Data.Bifunctor (rmap)
import Data.Either (Either(..))
import Data.Int (toNumber)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import NewSyntax.Force as Force
import NewSyntax.Tree as Tree
import Web.HTML (window)
import Web.HTML.Window (innerHeight, innerWidth)

getWindowWidthHeight :: Effect (Tuple Number Number)
getWindowWidthHeight = do
  win <- window
  width <- innerWidth win
  height <- innerHeight win
  pure $ Tuple (toNumber width) (toNumber height)

forceInterpreter :: Selection Force.Model -> StateT (D3State Force.Model) Effect Unit
forceInterpreter forceChart = do
  simulation <- interpretSimulation Force.simulation Force.getNodes Force.getLinks Force.makeModel
  interpretSelection forceChart
  interpretTickMap simulation Force.myTickMap
  interpretDrag Force.myDrag
  startSimulation simulation


main :: Effect Unit
main = launchAff_ do -- Aff
  log "v3"
  pure $ WrappedJoin.chart (Tuple 500 500)
  {-
  widthHeight    <- liftEffect getWindowWidthHeight
  -- two examples so we'll give them each half the window height
  let widthHeight' = rmap (\h -> h/2.0) widthHeight
  -- first, a force layout example
  forceJSON      <- AJAX.get ResponseFormat.string "http://localhost:1234/miserables.json"
  --let forceChart = Force.chart widthHeight'

  case forceJSON of
    Right {body} -> pure $ WrappedForce.chart (Tuple 500 500) body
    Left _ -> log "json parsing error"
  -}

{-
-- Should probably be Effect / Aff unit
chart :: Tuple Int Int -> String -> Unit
chart (Tuple width height) fileContents = chartFFI "div#force" width height fileContents


  let forceChart = Force.chart widthHeight
  let fileData   = Force.readModelFromFileContents forceJSON
  let forceModel = Force.makeModel fileData.links fileData.nodes
  --_ <- liftEffect $ runStateT (forceInterpreter forceChart) (Context forceModel initialScope)
  liftEffect $ runStateT (forceInterpreter forceChart) (Context forceModel initialScope)
-}
{-
  -- then a radial tree
  treeJSON      <- AJAX.get ResponseFormat.string "http://localhost:1234/flare-2.json"
  let treeChart = Tree.chart widthHeight'
  case Tree.readModelFromFileContents widthHeight' treeJSON of
    (Left error) -> liftEffect $ log $ printError error
    (Right treeModel) -> liftEffect $
                         runStateT (interpretSelection treeChart) (Context treeModel initialScope) *> pure unit
-}
