                                         INSERTAT
If the second argument of insertat function is negative, then it returns a list with a single element i.e. the current element.
Also if the third argument od the function is 1 than it return a list by prepending the first argument to the second list.
Otherwise it concatenates the head of list to the output obtained by running insertat in the tail of the list and inserting at one
less index.

                                          INCRRANGE
If the starting index is 0 then the function increments the starting n positions of the input list by one and concatenates it to
the rest of the list. Otherwise, the function concatenates the head of the list to the list obtained by incrementing the tail by one
in one less index positions.

                                          COMBINATION
If the list is empty the function returns empty list.
If one element combination is required then it returns the given list.
Otherwise the function appends the head of the list with (n-1) element combinations of the remaining list and this list formed
is then appended to the n element combination of the list formed by excluding the first element.
