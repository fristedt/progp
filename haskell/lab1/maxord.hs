import Data.Char

maxord :: String -> Int
maxord s = maxord2 s 0 0

maxord2 :: String -> Int -> Int -> Int
maxord2 [] l m = max m l
maxord2 (c:s) l m
  |   isAlpha c = maxord2 s (l+1) m
  |   otherwise = maxord2 s 0 (max m l)
