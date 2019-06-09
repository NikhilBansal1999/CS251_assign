calculate n a b = if n==1 then a else calculate (n-1) b (a+b)
fibonacci n = calculate n 0 1
infinite_fibonacci = [fibonacci n | n <- [1,2..]]

check_prime 1 = False
check_prime 2 = True
check_prime n = if length ([x | x<-[2..n], mod n x == 0]) == 1 then True else False

infinite_prime = [x | x<-[1,2..], check_prime x]

nth_prime n = infinite_prime!! (n-1)
