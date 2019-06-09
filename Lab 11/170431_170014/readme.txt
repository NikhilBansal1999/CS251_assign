                                           README
-- A function count_zero is defined which uses foldl to scan through the input string and count the number of zeroes
-- Similarly count_one counts the number of ones present in the string
-- Next a adder_one_bit function is defined takes 3 chars (bits, two input and a carry) and gives the result and carry out
-- Then the adder function is defined which  takes two numbers ans input (as string). This function returns Nothing if the number
   of zeroes is equal to the number of ones in either of the input. Otherwise it adds the last bits of the input and recursively
   calls itself to add the remaining bits.
-- The invert function, inverts each bit of the bit string. It is used to generate the twos complement of a number.
-- extend function takes a character and an integer (say n) as input and repeats the character n times.
-- Then get_twos_complement is defined. The function first inverts all the bits of the input and then adds one to the result
   to get the twos complement of the number.
-- The shifter function takes a number and does arithemetic shifting to right by one bit. It first concatenates the sign bit of
   the input to itself and then takes the init of result.
-- get_first_element, get_second_element, get_third_element are helper functions to get the first, second and third elements of
   a three membered tuple.
-- The processor function actually implements booths algorithm. It's first input is the multiplicand. Then it takes a tuple whose
   three elements are partial_product register, multiplier register and last_bit register in order. It also uses an index for compatibilty
   with scanl. If the partial_product register is Nothing, it means the adder has faulted at a previous step and so the computation
   is not done and it just returns Nothing and all other registers same. Else it checks the inputs multiplicand and multiplier
   to see if the adder faults at this step and then returns Nothings and other registers intact. Otherwise if the last bit of
   multiplier is equal to last_bit reg then nothing is done and the concatanation of partial_product reg and multiplier reg
   is just shifted one bit. If the two are '0' and '1' then multiplier is added to partial_product else subtracted. This is followed
   by shifting the regs.
-- Finally main takes input, processes it and returns the result of simulation. It does sanity check on inputs. In case of an error
   or an adder fault, user is prompted again else the simulation is run and the results shown.
