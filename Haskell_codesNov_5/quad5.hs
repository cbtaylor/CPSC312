betterquad3 :: Float -> Float -> Float -> (Float,Float)
betterquad3 a b c = ( (-b + sod) / denom, (-b - sod) / denom )
   where
    sod = sqrtOfDiscriminant a b c  
    denom = 2 * a                          


sqrtOfDiscriminant :: Float -> Float -> Float -> Float
sqrtOfDiscriminant a b c = sqrt ((b ^ 2) - (4 * a * c))


