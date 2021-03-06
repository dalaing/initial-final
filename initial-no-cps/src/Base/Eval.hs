module Base.Eval where

import Control.Lens

import Term
import Base.Type
import Interpret.Eval

addRule :: HasBaseF f => EvalRule (Term f)
addRule = EvalRule $ \e tm -> do
  (tm1, tm2) <- preview _Add tm
  i1 <- preview _Lit (e tm1)
  i2 <- preview _Lit (e tm2)
  pure $ review _Lit (i1 + i2)

evalRules :: HasBaseF f => [EvalRule (Term f)]
evalRules = pure addRule
