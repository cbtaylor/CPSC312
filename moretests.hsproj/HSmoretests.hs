findmaxpoint lop = findmaxpoints lop (-1000,-1000) (-1000)

    
findmaxpoints lop pt max
    | null lop = pt
    | sumpt > max = findmaxpoints (tail lop) (head lop) sumpt
    | otherwise = findmaxpoints (tail lop) pt max
  where
    sumpt = fst (head lop) + snd (head lop)


findCentre l
    | length l == 1 = l
    | otherwise = findCentre $ take (length l - 2) (drop 1 l)


--allFibs = zipWith (+) (1:allFibs) (0:1:allFibs)

allFibs = [ a + b | a <- 1:allFibs, b <- 0:1:allFibs]

data Expr =
    Lit Integer |
    Add Expr Expr |
    Sub Expr Expr
    
eval :: Expr -> Integer
eval (Lit n) = n
eval (Add expr1 expr2) = (eval expr1) + (eval expr2)
eval (Sub expr1 expr2) = (eval expr1) - (eval expr2)

double = (* 2)