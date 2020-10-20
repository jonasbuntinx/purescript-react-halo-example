module App.Root where

import Prelude

import React.Basic.DOM as R
import React.Basic.Hooks as React
import React.Halo as Halo

makeRoot :: React.Component Unit
makeRoot = do
  Halo.component "Root" { init, render, eval: Halo.makeEval Halo.defaultEval }
  where
  init = { greeting: "Before this is over, promise me you'll figure out which one of us is the machine." }

  render { state } =
    R.div
      { children:
        [ R.text state.greeting ]
      }
