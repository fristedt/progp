ackfib :: Int -> Integer
ackfib n = fibalicious n 0 1 0

fibalicious :: Int -> Integer -> Integer -> Int -> Integer
fibalicious n f1 f2 i
  | n == i    =   f1 + f2
  | otherwise =   fibalicious n f2 (f1+f2) (i+1)
