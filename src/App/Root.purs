module App.Root where

import Prelude
import App.Component.Header (makeHeader)
import Control.Monad.Reader (ReaderT, ask)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Aff)
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks as React
import React.Halo as Halo

data Action
  = Initialize
  | HandleReply

makeRoot :: forall props. ReaderT { nat :: Aff ~> Aff } Effect (props -> React.JSX)
makeRoot = do
  { nat: nat :: Aff ~> Aff } <- ask
  Halo.liftEffect do
    render <- makeRender
    Halo.component "Root"
      { initialState
      , render
      , eval:
          Halo.hoist nat
            <<< Halo.makeEval
                Halo.defaultEval
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
