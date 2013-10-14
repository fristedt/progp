fib :: Int -> Integer
fib n 
  | n <  0    = -((-1)^(-n)) * fib (-n)
  | n == 0    = 0
  | n == 1    = 1
  | otherwise = fib (n - 1) + fib (n - 2)
