module Mul.Eval where

import Control.Lens

import Term
import Base.Type
import Mul.Type
import Interpret.Eval

mulRule :: (HasBase f, HasMul f) => EvalRuleK (Term f)
mulRule = toEvalK . EvalRule $ \e tm -> do
  (tm1, tm2) <- preview _Mul tm
  i1 <- preview _Lit (e tm1)
  i2 <- preview _Lit (e tm2)
  pure $ review _Lit (i1 * i2)

evalRules :: (HasBase f, HasMul f) => EvalRuleK (Term f)
evalRules = mulRule
