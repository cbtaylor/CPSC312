-- CPSC 312
-- Assignment 4
-- Thursday, November 19, 2015
-- Brian Taylor
-- 52311859
-- z2b0b

-- Question 1
-- kungPaoFactor determies your current Kung Pao Factor
--
-- The parameters are:
--  r: the number of seconds taken for your voice to be recognized
-- dm: monthly food budget, in dollars
-- ds: food budget already used, in dollars
--  n: today's day of the month
--  c: blood cholesterol level
-- ft: number of significant food items in your fridge
-- ff: number of ft (above) that are furry
--  s: stress level, from 1 to 10
-- 
-- There did not seem to be any obvious way to use
-- abstraction to simplify this function as every
-- parameter is used only once and there is no
-- obvious meaning to any part of the formula.

kungPaoFactor
  :: Floating a => a -> a -> a -> a -> a -> a -> a -> a -> a
kungPaoFactor r dm ds n c ft ff s =
    (n / 30 - ds / dm) + 
    10 * s ^ 2 * (sqrt r) /
    (c * (ft - ff + 1))

-- Question 2
-- harmonic and harmonic_tr both determine the sum of the first
-- n terms of the harmonic sequence.
--
-- The parameter is:
-- n: the number of terms to sum

harmonic :: (Fractional a, Eq a) => a -> a
harmonic n
    | n == 1    = 1
    | otherwise = 1/n + harmonic (n - 1)

-- harmonic_tr_helper is a helper function that determines
-- the sum of the first n terms of the harmonic sequence
-- plus whatever the value of the parameter sum is
--
-- The parameters are:
-- n: the number of terms to sum
-- sum: in the initial call this is zero, but in subsequent
--      recursive calls this is a partial sum of the terms

harmonic_tr :: (Fractional a, Eq a) => a -> a
harmonic_tr n = harmonic_tr_helper n 0

harmonic_tr_helper :: (Fractional a, Eq a) => a -> a -> a
harmonic_tr_helper n sum
    | n == 0    = sum
    | otherwise = harmonic_tr_helper (n-1) (1/n + sum)

-- Question 3.1
-- myremoveduplicates and myremoveduplicates_pm both remove
-- any duplicate elements of a list.
--
-- The parameter is:
-- l: the list to be operated on

myremoveduplicates :: Eq t => [t] -> [t]
myremoveduplicates l
    | null l = []
    | elem (head l) (tail l) = myremoveduplicates (tail l)
    | otherwise = (head l):myremoveduplicates (tail l)

myremoveduplicates_pm :: Eq t => [t] -> [t]
myremoveduplicates_pm [] = []
myremoveduplicates_pm (x:xs)
    | elem x xs = myremoveduplicates_pm xs
    | otherwise = x:(myremoveduplicates_pm xs)

-- Question 3.2
--
-- mynthtail and mynthtail_pm both return the tail of a
-- given list with the first n elements of the list removed.
-- I made the decision that the functions would return an
-- empty list if the first parameter was greater than the
-- length of the list.
--
-- The parameters are:
-- n: the number of elements to remove from the start of the list
-- l: the list to be operated on

mynthtail :: (Num a, Eq a) => a -> [a1] -> [a1]
mynthtail n l
    | n == 0        = l
    | null (tail l) = []
    | otherwise     = mynthtail (n-1) (tail l)
    
mynthtail_pm :: (Num a, Eq a) => a -> [t] -> [t]
mynthtail_pm 0 l  = l
mynthtail_pm _ [] = []
mynthtail_pm n l  = mynthtail_pm (n-1) (tail l)

-- Question 3.3
--
-- myordered and myordered_pm both return True if the list
-- they are given is fully ordered and False otherwise.
--
-- The parameter is:
-- l: the list to be operated on

myordered :: Ord a => [a] -> Bool
myordered l
    | null l                  = True
    | null $ tail l           = True
    | head l > head (tail l)  = False
    | otherwise               = True && myordered (tail l)

myordered_pm :: Ord a => [a] -> Bool   
myordered_pm [] = True
myordered_pm [x] = True
myordered_pm (x:xs)
    | x > head xs = False
    | otherwise   = True && myordered_pm xs

-- Question 3.4
--
-- myreplaceall and myreplaceall_pm both replace all occurences of
-- one parameter with another parameter in a given list.
--
-- The parameters are:
-- a: the element to be inserted
-- b: the element to be replaced
-- l: the list to be operated on

myreplaceall :: Eq t => t -> t -> [t] -> [t]
myreplaceall a b l
    | null l      = []
    | head l == b = a:myreplaceall a b (tail l)
    | otherwise   = head l:myreplaceall a b (tail l)

myreplaceall_pm :: Eq t => t -> t -> [t] -> [t]   
myreplaceall_pm a b [] = []
myreplaceall_pm a b (x:xs)
    | x == b    = a:(myreplaceall_pm a b xs)
    | otherwise = x:(myreplaceall_pm a b xs)

-- Question 4
-- change determines the optimal set of coins that
-- can make change for a given amount
--
-- The parameter is:
-- total: the amount for which we want change
-- 
-- The possible values of coins were given and are
-- hard-coded into the function.
--
-- changes is a helper function that generates
-- a list of all possible sets of coins that can
-- make change for a given amount.
-- change simply takes the first set in this list.
-- Since changes creates the lists starting with the
-- largest coins the first list in the list of lists
-- is the one with the smallest number of coins.

change :: (Ord t, Num t) => t -> [t]
change total = head (changes total)

changes :: (Ord t, Num t) => t -> [[t]]
changes 0 = [[]]
changes total = [c:cs |
    c <- [100,50,20,10,5,2,1], total >= c,
    cs <- changes (total - c) ]


