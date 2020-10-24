{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "my-project"
, dependencies =
  [ "affjax"
  , "arrays"
  , "console"
  , "debug"
  , "effect"
  , "exists"
  , "foldable-traversable"
  , "indexed-monad"
  , "lists"
  , "nullable"
  , "psci-support"
  , "quickcheck"
  , "web-events"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
