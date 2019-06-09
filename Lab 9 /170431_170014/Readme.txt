                                                README
-- The two ciphertexts and the readme file are copied to the haskell source file first
-- Then a function present_in_list is defined which ckecks if a given element in present in a list or not.
-- Then a function unique_list is defined which when given an empty list as its first argument and a list as its second argument
   return a list of all the unique elements in the input list.
-- The above function is used to get all the unique characters in the cipher.
-- Then frequency (or new_frequency) is defined which is a list of tuples with the first element of each tuple being a character
   from the unique list and the second element is zero.
-- Then a function inc_frequency is defined which takes the above frequency and ciphertext as input and returns the character frequencies.
-- Then a function replace_char_list is defined which produces a key which is a list of tuples which contains (original_char, new_char_to_replace)
   which is then stored in a variable replaced_list (or new_replaced_list)
-- Then a function decipher takes ciphertext and the key as input and returns the decrypted ciphertext which is stored in
   message or new_message.
-- A function lowercase_converter is defined to convert message to lowercase.
-- Special characters are removed and the message is split into words.
-- Then found function checks if each message is present in dictionary or not.
-- The number of words found is counted by the function correct_words
-- The function words_frequency_list takes cipher as input and a len as another input and returns a list of len length words
   along with their frequencies.
