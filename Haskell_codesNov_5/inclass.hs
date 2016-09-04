
-- simple functon that calculates the square of a given number
square :: Int -> Int
square n = n ^ 2

-- function that determines the maximum from among three values
max3 :: Int -> Int -> Int -> Int
max3 x y z
   | x >= y && x >= z    = x
   | y >= z              = y

-- try querying with: max3 1 2 3 
-- and see the result
-- need to add the third case in order to fix

-- function that computes the integer square root of a function (see lecture slides from nov 3rd)
int_sqrt:: Int -> Int
int_sqrt n 
 | n == 0  = 0
 | (p + 1)^2 <= n  = p +1
 | otherwise  = p
 where
  p = int_sqrt (n-1)

-- remember to put the parantheses around n-1 in the last line. 
-- Function application always takes precedent over everything else
-- without the parentheses the expresssion will be taken as (int_sqrt n)-1
-- and this will be a loop that never terminates.

-- same function and implementation but with a syntactic variation
-- using let instead of where 
-- and if-then-else instead of guards
int_sqrt1:: Int -> Int
int_sqrt1 1 = 1
int_sqrt1 n =
  let p = int_sqrt1 (n-1)
  in if (p + 1)^2 <= n then p +1 else p

  

-- here's also my version of tail recursive implementation of the same function
-- you can write other/better versions for yourself
int_sqrt_tr :: Int -> Int
int_sqrt_tr n = int_sqrt_tr_helper n 0

int_sqrt_tr_helper :: Int -> Int -> Int
int_sqrt_tr_helper n result
  | n < (result+1)^2  = result
  | otherwise  = int_sqrt_tr_helper n (result+1)


-- fibonacci function with multiple recursion
fibonacci :: Int -> Int
fibonacci n
  | n == 0  = 0
  | n == 1  = 1
  | otherwise  = fibonacci (n - 1) + fibonacci (n - 2)
-- this will be very slow for larger values of n. 
-- see the faster version in Nov 3rd slides.

-- function that adds up the result of the application of any function given as input
-- to numbers from 0 to n
sumFunction :: Integer -> (Integer -> Integer) -> Integer
sumFunction n f
  | n==0  = f 0
  | otherwise  = f n + sumFunction (n-1) f

-- sample function to be used with sumFunction
f :: Integer -> Integer
f n = 2 * n


