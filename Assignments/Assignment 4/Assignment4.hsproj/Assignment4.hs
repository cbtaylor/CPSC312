kungPaoFactor :: Floating a => 
    a -> a -> a -> a -> a -> a -> a -> a -> a
kungPaoFactor r dm ds n c ft ff s =
    (n / 30 - ds / dm) + 
    10 * s ^ 2 * (sqrt r) /
    (c * (ft - ff + 1))
    

harmonic :: (Fractional a, Eq a) => a -> a
harmonic n
    | n == 1    = 1
    | otherwise = 1/n + harmonic (n - 1)

harmonic_tr :: (Fractional a, Eq a) => a -> a
harmonic_tr n = harmonic_tr_helper n 0

harmonic_tr_helper :: (Fractional a, Eq a) => a -> a -> a
harmonic_tr_helper n sum
    | n == 0    = sum
    | otherwise = harmonic_tr_helper (n-1) (1/n + sum)

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

mynthtail :: (Num a, Eq a) => a -> [a1] -> [a1]
mynthtail n l
    | n == 0        = l
    | null (tail l) = []
    | otherwise     = mynthtail (n-1) (tail l)
    
mynthtail_pm :: (Num a, Eq a) => a -> [t] -> [t]
mynthtail_pm 0 l  = l
mynthtail_pm _ [] = []
mynthtail_pm n l  = mynthtail_pm (n-1) (tail l)

myordered :: Ord a => [a] -> Bool
myordered l
    | null l                  = True
    | null $ tail l           = True
    | head l > head (tail l)  = False
    | otherwise               = True && myordered (tail l)

myordered_pm :: Ord a => [a] -> Bool
myordered_pm [] = True
myordered_pm [x] = True
myordered_pm (x,y:xs)
    | x > head xs = False
    | otherwise   = True && myordered_pm xs

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

change :: (Ord t, Num t) => t -> [t]
change total = head (changes total)

changes :: (Ord t, Num t) => t -> [[t]]
changes 0 = [[]]
changes total = [c:cs |
    c <- [100,50,20,10,5,2,1], total >= c,
    cs <- changes (total - c) ]






