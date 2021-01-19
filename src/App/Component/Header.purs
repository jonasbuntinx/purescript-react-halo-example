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
    pure
      $ R.header_
          [ R.h2_ [ R.text props.text ]
          ]
