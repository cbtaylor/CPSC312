module Loan_Payment where
-- module name is uppercase

monthlyPayment :: Float -> Float -> Int -> Float
monthlyPayment p l n = (f1 * f2 * l) / (f2-1)
 where
  f1 = p/1200
  f2 = (1+p/1200)^n


-- better to use spaces than tabs to indent; 
-- tabs have different sizes in different editor environments
-- so it can create inconsistencies and lack of portability
-- also, tabs are seen as one character by the compiler, 
-- therefore, the indentation you see on the screen
-- is not the same as what the compiler understands
