konkatt :: (Ord a) => [a] -> [a] -> [a]
konkatt l1 l2
  | last l1 < head l2 = l1 ++ l2
  | last l2 < head l1 = l2 ++ l1 
