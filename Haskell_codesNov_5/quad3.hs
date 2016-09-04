betterquad1 :: Float -> Float -> Float -> (Float,Float)
betterquad1 a b c =
   betterquad2 a b c (sqrtOfDiscriminant a b c) (denominator a)


betterquad2 :: Float -> Float -> Float -> Float -> Float ->  
               (Float,Float)
betterquad2 a b c sod denom = ( (-b + sod) / denom,
                                (-b - sod) / denom )


sqrtOfDiscriminant :: Float -> Float -> Float -> Float
sqrtOfDiscriminant a b c = sqrt ((b ^ 2) - (4 * a * c))


denominator :: Float -> Float
denominator a = 2 * a
