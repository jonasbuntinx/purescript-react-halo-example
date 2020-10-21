module Main where

import Prelude

import App.Root as Root
import Control.Monad.Reader (runReaderT)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import React.Basic.DOM (render)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

main :: Effect Unit
main = do
  container <- getElementById "app" =<< (map toNonElementParentNode $ document =<< window)
  case container of
    Nothing -> throw "App container element not found."
    Just c -> do
      root <- runReaderT Root.makeRoot { nat: identity }
      render ( root unit ) c
