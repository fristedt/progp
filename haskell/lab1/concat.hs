konkatt :: (Ord a) => [a] -> [a] -> [a]
konkatt l1 [] = l1
konkatt [] l2 = l2
konkatt l1@(h1:b1) l2@(h2:b2) 
  | h1 < h2   =  h1 : (konkatt b1 l2)
  | otherwise =  h2 : (konkatt l1 b2)
