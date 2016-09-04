betterquad3 :: Float -> Float -> Float -> (Float,Float)
betterquad3 a b c =
   let sod = sqrtOfDiscriminant a b c 
   	   denom = 2 * a in
                              ( (-b + sod) / denom,
                                (-b - sod) / denom )


sqrtOfDiscriminant :: Float -> Float -> Float -> Float
sqrtOfDiscriminant a b c = sqrt ((b ^ 2) - (4 * a * c))


