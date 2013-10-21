module NJ where
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

-- neighbour [String] -> [(String, String, Integer)] -> VADFANSOMHELST
neighbour f1@(h:t) d1 
  | length f1 > 3 = doStuff f1 d1
  | otherwise     = error "DONE"

-- Bilda hörnet u så att (a, u) samt (b, u), förutsatt att (a, b) 
-- är det lägsta avståndet.
-- Använd wikiformel för att räkna ut avstånden d1 mellan a och u samt
-- d2 mellan b och u.
-- Ta bort alla permutationer av "ab" i distansmatrisen. Lägg det nya
-- hörnet u som första element i distansmatrisen. 
-- Beräkna avstånd från alla gamla punkter skilda från a och b till 
-- u och kasta in i distansmatris.
-- Repeat til death.
Upprepa till klart.
doStuff f1 d1 = removeCorner f1 (minSelection f1)
  where 
      minSelection :: [String] -> (String, String, Integer)
      minSelection f1 = minDist d1 (corners d1) ("ASD", "asd", 0)
        where
          minDist :: [(String, String, Integer)] -> [(String, String)] -> (String, String, Integer) -> (String, String, Integer)
          minDist _ [] c1 = c1
          minDist d1 ((a, b):t) c1@(_, _, min)
            | min <= dist2 = minDist d1 t c1 
            | otherwise    = minDist d1 t c2 
            where 
              c2 = (a, b, dist2)
              dist2 = selection d1 a b


removeCorner :: [String] -> (String, String, Integer) -> [String]
removeCorner [] _ = []
removeCorner (h:t) c@(a, b, _)
  | h == a || h == b = removeCorner t c
  | otherwise        = h:removeCorner t c

corners :: [(String, String, Integer)] -> [(String, String)]
corners list = map (\(a, b, _) -> (a, b)) list

permutate :: [String] -> [(String, String)]
permutate f1 = [(a, b) | a <- f1, b <- f1] 

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

