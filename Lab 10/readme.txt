                                      PART 1
-- The temp1 function is a recursive function that takes the first character of the string and converts it into integer using
   ASCII values and adds it to the previous result multiplied by 10. It also checks for minus sign and multiplies the result by -1 if found.
-- string2int calls temp1 with the string as first argument and the next two arguments as 0 and 1.

                                       PART 2
-- mymap uses foldl which takes a lambda function as its first input. The lambda function applies the required function to each element of
   the input list and appends it to the output list, thus producing a list of results.

-- myfilter uses foldr which a lambda function as its first input. The lambda function applies the required function to each element of
   the input list and if the output is true then the element is appended to the output list otherwise the element is left out.

                                       PART 3
-- The first line defines the type of function myFoldl. It takes a function as its first argument, an accumulator of type 'a' and a
   list of element type 'b', applies the function to each of the list element and returns the result of type 'a'. The function
   supplied to foldl takes two arguments of type 'a' and 'b' and return a value of type 'a'.
   A function step is defined which applies the function 'f' to 'a' and 'x' and then applies the function 'g' to the result.
   In the implementation of myFoldl foldr is used to apply 'f' to the elements of the list from right to left. The step function
   changes the order of arguments and with the help of id (which is the identity function), build up the final value by applying
   the function 'f' from left to rigth (the order is changed by the step function).

                                       PART 4
-- three2string is a function which takes 3 digit strings as input and returns the conversion of it in words.
-- This function is used by the convert2string which also used a variable index to keep track of the position of the triplet
   i.e. thousand or million or billion etc.
-- word2string calls convert2string with index 0
-- string2word first splits the string on commas and pass the list to process_list
-- process_list evaluates each element of passed string from left to rigth. It calls process_it (which is recursive) which return a three diigt
   number for each element and multiplier which returns the place value. process_it uses foldl to accumulate the value.
   A lookup table is defined as return_digits.
