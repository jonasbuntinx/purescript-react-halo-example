module App.Root where

import Prelude

import Data.Maybe (Maybe(..))
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks as React
import React.Halo as Halo

data Action
  = Reply

makeRoot :: React.Component Unit
makeRoot = do
  Halo.component "Root"
      { init
      , render
      , eval: Halo.makeEval $ Halo.defaultEval { onAction = handleAction }
      }
  where
  init = { reply: Nothing }

  handleAction = case _  of
    Reply -> Halo.modify_ _ { reply = Just "Sir. Finishing this fight." }

  render { state, send } =
    React.fragment
      [ R.div
        { children:
          [ R.text "Master Chief, mind telling me what you're doing on that ship?"
          ]
        }
      , case state.reply of
          Nothing ->
            R.button
              { onClick: handler_ $ send Reply
              , children:
                [ R.text "Reply"
                ]
              }
          Just reply -> R.div { children: [ R.text reply ] }
      ]
