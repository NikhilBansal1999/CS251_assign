import Data.Char
import Data.List.Split
import Data.List

string2int :: [Char] -> Int
temp1 :: [Char] -> Int -> Int -> Int
temp1 (x:xs) a s =
  if xs == []
    then ((a*10)+(s * (ord x - 48)))
  else if x == '-'
  then temp1 (tail xs) ((-1) * (ord (head xs) - 48)) (-1)
    else temp1 xs ((a*10)+(s * (ord x - 48))) s
string2int xs = temp1 xs 0 1

mymap :: (a -> b) -> [a] -> [b]
mymap f xs = foldl (\list x -> list ++ [(f x)]) [] xs

myfilter :: (a -> Bool) -> [a] -> [a]
myfilter f xs = foldr (\x list -> if f x then x : list else list) [] xs

single_digit = ["","One ","Two ","Three ","Four ","Five ","Six ","Seven ","Eight ","Nine "]
double_digit = ["","","Twenty ","Thirty ","Forty ","Fifty ","Sixty ","Seventy ","Eighty ","Ninty "]
double_special = ["Ten ","Eleven ","Twelve ","Thirteen ","Fourteen ","Fifteen ","Sixteen ","Seventeen ","Eighteen ","Nineteen "]
triples = ["","Thousand","Million","Billion","Trillion","Quadrillion"]

word2string :: Int -> [Char]
word2string num
  | num == 0                         = "Zero"
  | (length (show num)) `mod` 3 == 0 = convert2string 0 (show num)
  | (length (show num)) `mod` 3 == 2 = convert2string 0 ("0" ++ (show num))
  | otherwise                        = convert2string 0 ("00" ++ (show num))

three2string :: [Char] -> [Char]
three2string num = (single_digit !! (string2int [(num !! ((length num) - 3))])) ++ (if (string2int [(num !! ((length num) - 3))]) == 0 then "" else "hundred ") ++ (if (string2int ([last num] ++ [(last.init) num])) == 0 || (num !! ((length num) - 3)) == '0' then "" else "and ") ++ (if (string2int [(num !! ((length num) - 2))]) == 1 then (double_special !! (string2int [(num !! ((length num) - 1))])) else ((double_digit !! (string2int [(num !! ((length num) - 2))])) ++ (single_digit !! (string2int [(num !! ((length num) - 1))])) ))

convert2string :: Int -> [Char] -> [Char]
convert2string index "" = ""
convert2string index num = (if (length num) > 3 then (convert2string (index+1) ((init.init.init) num)) ++ (if (string2int num) `mod` 1000 /= 0 then ", " else "") else "") ++ (three2string num) ++ (if index > 0 && (string2int num) `mod` 1000 /= 0 then (triples !! index) else "")

lowercase_converter :: [Char] -> [Char]
lowercase_converter message_input = [toLower x | x <- message_input]

string2word :: [Char] -> Int
string2word "" = error "Empty String"
string2word str = process_list (splitOn "," (lowercase_converter str))

process_list :: [[Char]] -> Int
process_list [] = 0
process_list lst = (process_it (head lst) * (multiplier (words (head lst)))) + (process_list (tail lst))

multiplier :: [[Char]] -> Int
multiplier lst
  | "quadrillion" `elem` lst = 1000000000000000
  | "trillion" `elem` lst    = 1000000000000
  | "billion" `elem` lst     = 1000000000
  | "million" `elem` lst     = 1000000
  | "thousand" `elem` lst    = 1000
  | otherwise                = 1

process_it :: [Char] -> Int
process_it lst = foldl apply_func 0 (words lst)

apply_func :: Int -> [Char] -> Int
apply_func acc lst
  | lst == "hundred"    = acc * 100
  | lst == ""           = acc
  | otherwise           = acc + (return_digits lst)

return_digits :: [Char] -> Int
return_digits str
  | str == "one"       = 1
  | str == "two"       = 2
  | str == "three"     = 3
  | str == "four"      = 4
  | str == "five"      = 5
  | str == "zero"      = 0
  | str == "six"       = 6
  | str == "seven"     = 7
  | str == "eight"     = 8
  | str == "nine"      = 9
  | str == "ten"       = 10
  | str == "eleven"    = 11
  | str == "twelve"    = 12
  | str == "thirteen"  = 13
  | str == "fourteen"  = 14
  | str == "fifteen"   = 15
  | str == "sixteen"   = 16
  | str == "seventeen" = 17
  | str == "eighteen"  = 18
  | str == "nineteen"  = 19
  | str == "twenty"    = 20
  | str == "thirty"    = 30
  | str == "forty"     = 40
  | str == "fifty"     = 50
  | str == "sixty"     = 60
  | str == "seventy"   = 70
  | str == "eighty"    = 80
  | str == "ninety"    = 90
  | otherwise          = 0
