betterquad :: Float -> Float -> Float -> (Float,Float)
betterquad a b c = 
           ( (-b + sqrtOfDiscriminant a b c) / denominator a,
             (-b - sqrtOfDiscriminant a b c) / denominator a  )


sqrtOfDiscriminant :: Float -> Float -> Float -> Float
sqrtOfDiscriminant a b c = sqrt ((b ^ 2) - (4 * a * c))


denominator :: Float -> Float
denominator a = 2 * a
