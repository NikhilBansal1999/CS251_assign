insertAt :: a -> [a] -> Integer -> [a]
insertAt a [] n = a : []
insertAt a b 1 = a : b
insertAt a b n = head(b) : ( insertAt a (tail b) (n-1))

incrrange :: [Int] -> (Int, Int) -> [Int]
incrrange a (0, n) = [(a !! x) + 1 | x <- [0..n] ] ++ [ a !! x | x <- [(n+1)..(length(a)-1)]]
incrrange a (b, c) = (head a) : (incrrange (tail a) (b-1, c-1))

strict_question a (b, c) = incrrange a (b-1, c-1)

combination :: Int -> [a] -> [[a]]
combination n [] = []
combination 1 a = [ [a !! x] | x <- [0..(length(a)-1)]]
combination n a = [ (head a) : x | x <- (combination (n-1) (tail a))] ++ (combination n (tail a))
