count_zero :: [Char] -> Int
count_zero num = foldl (\acc x -> if x == '0' then (acc + 1) else acc) 0 num

count_one  :: [Char] -> Int
count_one num = foldl (\acc x -> if x == '1' then (acc + 1) else acc) 0 num

adder_one_bit :: Char -> Char -> Char -> (Char, Char)               -- returns (sum,cout)
adder_one_bit x y cin
  | x == '0' && y == '0' && cin == '0'     = ('0','0')
  | x == '0' && y == '0' && cin == '1'     = ('1','0')
  | x == '0' && y == '1' && cin == '0'     = ('1','0')
  | x == '0' && y == '1' && cin == '1'     = ('0','1')
  | x == '1' && y == '0' && cin == '0'     = ('1','0')
  | x == '1' && y == '0' && cin == '1'     = ('0','1')
  | x == '1' && y == '1' && cin == '0'     = ('0','1')
  | x == '1' && y == '1' && cin == '1'     = ('1','1')
  | otherwise                = error "Wrong Input!"

adder_unchecked :: [Char] -> [Char] -> Char -> Maybe [Char]
adder_unchecked x y cin
  | (length x) == 1                                                 = Just [fst tmp]
  | x == "" && y == ""                                              = Just [cin]
  | x == ""                                                         = adder_unchecked y [cin] '0'
  | y == ""                                                         = adder_unchecked x [cin] '0'
  | tmp_adder == Nothing                                            = Nothing
  | otherwise                                                       = case tmp_adder of Just y ->  Just (y ++ [fst tmp])
  where
    tmp = adder_one_bit (last x) (last y) cin
    tmp_adder = adder_unchecked (init x) (init y) (snd tmp)

adder :: [Char] -> [Char] -> Char -> Maybe [Char]
adder x y cin
  | (length x) == 1                                                 = Just [fst tmp]
  | ((count_one x) == (count_zero x)) && ((count_one x) /= 0)       = Nothing
  | ((count_one y) == (count_zero y)) && ((count_one y) /= 0)       = Nothing
  | tmp_adder == Nothing                                            = Nothing
  | x == "" && y == ""                                              = Just [cin]
  | x == ""                                                         = Just y
  | y == ""                                                         = Just x
  | otherwise                                                       = case tmp_adder of Just y ->  Just (y ++ [fst tmp])
  where
    tmp = adder_one_bit (last x) (last y) cin
    tmp_adder = adder_unchecked (init x) (init y) (snd tmp)

invert :: [Char] -> [Char]
invert x
  | x == ""                = ""
  | x == "1"               = "0"
  | x == "0"               = "1"
  | otherwise              = (invert [head x]) ++ (invert (tail x))

extend :: Char -> Int -> [Char]
extend x n = [x | y <- [1..n]]

get_twos_complement :: [Char] -> Int -> [Char]
get_twos_complement x len
  | x == ""                = ""
  | (length x) == len      = case tmp of Just y -> y
  | otherwise              = get_twos_complement ((extend (head x) (len - (length x))) ++ x) len
  where
    tmp = adder_unchecked (invert x) ((extend '0' (len-1)) ++ "1") '0'

shifter :: [Char] -> [Char]
shifter x
  | x == ""             = ""
  | otherwise           = init ([(head x)] ++ x)

processor :: [Char] -> (Maybe [Char],[Char],Char) -> Int -> (Maybe [Char],[Char],Char)
processor multiplicand (partial,multiplier,last_bit) index
  | partial == Nothing                          = (Nothing, multiplier, last_bit)
  | ((count_one checker) == (count_zero checker)) && ((count_one checker) /= 0) = (Nothing, multiplier, last_bit)
  | ((count_one part_added) == (count_zero part_added)) && ((count_one part_added) /= 0) = (Nothing, multiplier, last_bit)
  | last multiplier == last_bit                 = (Just (take (length multiplier) shift_normal), drop (length multiplier) shift_normal, last multiplier)
  | last multiplier == '0' && last_bit == '1'   = (Just (take (length multiplier) shift_added), drop (length multiplier) shift_added, last multiplier)
  | last multiplier == '1' && last_bit == '0'   = (Just (take (length multiplier) shift_subtracted), drop (length multiplier) shift_subtracted, last multiplier)
  where
    part_added = case partial of Just y -> y
    added_value = adder part_added multiplicand '0'
    twos_complement = get_twos_complement multiplicand (length multiplicand)
    checker = if (last multiplier == '0' && last_bit == '1') then multiplicand else twos_complement
    subtracted_value = adder part_added twos_complement '0'
    added_val = case added_value of Just y -> y
    subtracted_val = case subtracted_value of Just y -> y
    shift_added = shifter (added_val ++ multiplier)
    shift_subtracted = shifter (subtracted_val ++ multiplier)
    shift_normal = shifter (part_added ++ multiplier)

get_first_element :: (a,b,c) -> a
get_first_element (a,_,_) = a

get_second_element :: (a,b,c) -> b
get_second_element (_,b,_) = b

get_third_element :: (a,b,c) -> c
get_third_element (_,_,c) = c

error_print :: IO ()
error_print = do
  putStrLn "Adder Fault!"
  main

invalid_print :: IO ()
invalid_print = do
  putStrLn "Invalid Input"
  main

main = do
  putStrLn "Enter The number of bits"
  temp1 <- getLine
  let num_bits = (read temp1 :: Int)
  putStrLn "Enter The two numbers:"
  multiplicand <- getLine
  multiplier <- getLine
  if ((length multiplier) /= num_bits) || ((length multiplicand) /= num_bits) || ((count_one multiplier) + (count_zero multiplier) /= num_bits) || ((count_one multiplicand) + (count_zero multiplicand) /= num_bits) || (num_bits < 1) then
    invalid_print
  else do
    let final_result = scanl (processor multiplicand) (Just (extend '0' num_bits),multiplier,'0') [0..(num_bits-1)]
    let partial_products = [get_first_element x | x <- final_result]
    let multiplier_reg = [get_second_element x | x <- final_result]
    let last_bit = [get_third_element x | x <- final_result]
    if (Nothing `elem` partial_products) then
      error_print
    else do
      putStrLn "Part_Products_Register Multipler_Register Last_bit State_Counter"
      let part_prods_pure = [case x of Just y -> y | x <- partial_products]
      let states = [show x | x <- (reverse ([0..num_bits]))]
      let print_result = [ (part_prods_pure !! x) ++ " " ++ (multiplier_reg !! x) ++ " " ++ [last_bit !! x] ++ " " ++ (states !! x)  | x <- [0..((length part_prods_pure)-1)]]
      mapM_ putStrLn print_result
