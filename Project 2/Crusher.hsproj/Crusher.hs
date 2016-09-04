
numSides :: Floating a => a -> a
numSides n = (3 + sqrt(12 * n - 3)) / 6


prettyPrint l = putStr "  W W W\n - W W -\n- - - - -\n - B B -\n  B B B"
    
addNewLines s
    | null s = []
    | otherwise = (take rn s) ++ "\n" ++ addNewLines (drop rn s)
    where
      l = length s
      n = numSides (fromIntegral l)
      rn = round n
      
insertNewLine n l = take 3 l ++ "\n" ++ drop 3 l


addSpace xs = if length xs <= 1
              then xs
              else take 1 xs ++ " " ++ addSpace (tail xs)
