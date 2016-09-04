quadratic :: Float -> Float -> Float -> (Float,Float)
quadratic a b c = (largerRoot a b c, smallerRoot a b c)

largerRoot :: Float -> Float -> Float -> Float
largerRoot a b c = (largerNumerator a b c) / denominator a

smallerRoot :: Float -> Float -> Float -> Float
smallerRoot a b c = (smallerNumerator a b c) / denominator a

largerNumerator :: Float -> Float -> Float -> Float
largerNumerator a b c = -b + sqrtOfDiscriminant a b c

smallerNumerator :: Float -> Float -> Float -> Float
smallerNumerator a b c = -b - sqrtOfDiscriminant a b c

sqrtOfDiscriminant :: Float -> Float -> Float -> Float
sqrtOfDiscriminant a b c = sqrt ((b ^ 2) - (4 * a * c))

denominator :: Float -> Float
denominator a = 2 * a

