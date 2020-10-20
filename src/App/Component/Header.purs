module App.Component.Header where

import Prelude

import React.Basic.DOM as R
import React.Basic.Hooks as React

type Props
  = { text :: String
    }

makeHeader :: React.Component Props
makeHeader =
  React.component "Header" \props -> React.do
    pure $ render props
  where
  render props =
    R.header_
      [ R.h1_ [ R.text props.text ]
      ]
