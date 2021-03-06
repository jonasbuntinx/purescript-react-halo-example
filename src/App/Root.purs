module App.Root where

import Prelude
import App.Component.Header (makeHeader)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks as React
import React.Halo as Halo

data Action
  = Initialize
  | HandleReply

makeRoot :: forall props. Effect (props -> React.JSX)
makeRoot = do
  render <- makeRender
  Halo.component "Root"
    { initialState
    , render
    , eval:
        Halo.makeEval
          _
            { onInitialize = \props -> Just Initialize
            , onAction = handleAction
            }
    }
  where
  initialState = { question: "", reply: Nothing }

  handleAction = case _ of
    Initialize -> Halo.modify_ _ { question = "Master Chief, mind telling me what you're doing on that ship?" }
    HandleReply -> Halo.modify_ _ { reply = Just "Sir. Finishing this fight." }

  makeRender = do
    header <- makeHeader
    pure \{ state, send } ->
      React.fragment
        [ header { text: "PureScript React Halo Example" }
        , R.div
            { children:
                [ R.text state.question
                ]
            }
        , case state.reply of
            Nothing ->
              R.button
                { onClick: handler_ $ send HandleReply
                , children:
                    [ R.text "Reply"
                    ]
                }
            Just reply -> R.div { children: [ R.text reply ] }
        ]
