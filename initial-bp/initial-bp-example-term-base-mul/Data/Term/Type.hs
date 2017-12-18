{-# LANGUAGE TemplateHaskell #-}
module Data.Term.Type where

import Control.Lens

data Term =
    Lit Int
  | Add Term Term
  | Mul Term Term
  deriving (Eq, Ord, Show)

makePrisms ''Term
