import Data.List

tm1 = [("a", "a", 0), ("a", "b", 2), ("a", "c", 3), ("a", "d", 5), ("a", "e", 6), ("a", "f", 5),
       ("b", "b", 0), ("b", "c", 3), ("b", "d", 5), ("b", "e", 6), ("b", "f", 5),
       ("c", "c", 0), ("c", "d", 4), ("c", "e", 5), ("c", "f", 4),
       ("d", "d", 0), ("d", "e", 5), ("d", "f", 4),
       ("e", "e", 0), ("e", "f", 3),
       ("f", "f", 0)]

tm2 = [("a", "a", 0), ("a", "b", 7), ("a", "c", 11), ("a", "d", 14),
       ("b", "b", 0), ("b", "c", 6), ("b", "d", 9),
       ("c", "c", 0), ("c", "d", 7),
       ("d", "d", 0)]

selection :: [(String, String, Integer)] -> String -> String -> Integer
selection matrix x y = ((toInteger (length uniqueMatrix)) - 2) * (distance x y matrix) - cornerSum x y matrix uniqueMatrix
  where
    uniqueMatrix = unique matrix

unique :: [(String, String, Integer)] -> [String]
unique list = nub (map (\(x, _, _) -> x) list)

distance :: String -> String -> [(String, String, Integer)] -> Integer
distance from to [] = 0
distance from to ((a, b, d):t)
  | from == a && to == b = d
  | otherwise            = distance from to t

cornerSum :: String -> String -> [(String, String, Integer)] -> [String] -> Integer
cornerSum _ _ _ [] = 0
cornerSum from to matrix (h:t) 
  | from == to = 0
  | abs d1 >= 0 && abs d2 >= 0 = d1 + d2 + cornerSum from to mm t
  | otherwise = cornerSum from to mm t
  where
    mm = mirror matrix
    d1 = distance from h mm 
    d2 = distance to h mm
    
mirror :: [(String, String, Integer)] -> [(String, String, Integer)]
mirror [] =  []
mirror (head@(a, b, d):t) 
  | a == b    = head:mirror t
  | otherwise = head:(b, a, d):mirror t

