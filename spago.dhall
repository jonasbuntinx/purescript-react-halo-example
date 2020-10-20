{ name = "purescript-react-realword"
, dependencies =
    [ "console"
    , "effect"
    , "psci-support"
    , "react-basic-dom"
    , "react-basic-hooks"
    , "react-halo"
    ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
