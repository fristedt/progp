module NJ where
import Data.List 
import qualified Data.Map as Map

data Cond a = a :? a
 
infixl 0 ?
infixl 1 :?      

(?) :: Bool -> Cond a -> a
True  ? (x :? _) = x
False ? (_ :? y) = y


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

-- Length of all edges. 
dm1 = buildDistanceMap (mirror tm1)
dm2 = buildDistanceMap (mirror tm2)

-- Set of all corners.
fm1 = unique em1
fm2 = unique em2

-- Set of all edges.
em1 = map (\(a, b, _) -> (a, b)) tm1
em2 = map (\(a, b, _) -> (a, b)) tm2

-- Build a map of key -> value pairs where key is a tuple (a, b) and value is the distance.
buildDistanceMap :: [(String, String, Integer)] -> Map.Map (String, String) Integer
buildDistanceMap tm = Map.fromList m 
  where
    m = map (\(a, b, d) -> ((a, b), d)) tm  

-- Makes paths bidirectional. 
mirror :: [(String, String, Integer)] -> [(String, String, Integer)]
mirror [] =  []
mirror (head@(a, b, d):t) 
  | a == b    = head:mirror t
  | otherwise = head:(b, a, d):mirror t

-- Returns distance between a and b in key@(a, b) using lookup in map.
distance :: (String, String) -> Map.Map (String, String) Integer -> Integer
distance key map = case Map.lookup key map of 
  Nothing -> 0 
  Just x -> x

-- Return all the unique corners in the matrix containing the edges.
unique :: [(String, String)] -> [String]
unique list = nub (map (\(x, _) -> x) list)

-- Returns a crazy integer that we need for determining stuff.
selection :: (String, String) -> [String] -> Map.Map (String, String) Integer -> Integer
selection (a, b) fm dm = (toInteger ((length fm) - 2)) * (distance (a, b) dm) - cornerSum a b fm dm
  where
    cornerSum :: String -> String -> [String] -> Map.Map (String, String) Integer -> Integer
    cornerSum _ _ [] _ = 0
    cornerSum a b (h:t) dm
      | a == b = 0
      | abs d1 >= 0 && abs d2 >= 0 = d1 + d2 + cornerSum a b t dm 
      | otherwise = cornerSum a b t dm 
      where
        d1 = distance (a, h) dm 
        d2 = distance (b, h) dm

-- Returns the tuple (a, b) that minimizes S(a, b).
minSelection :: [(String, String)] -> [String] -> Map.Map (String, String) Integer -> (String, String)
minSelection em fm dm = go ("asd", "asd") em dm
  where 
    go :: (String, String) -> [(String, String)] -> Map.Map (String, String) Integer -> (String, String)
    go minSel [] _ = minSel
    go minSel em@(h:t) dm  = go sel t dm 
        where
          d1 = selection minSel fm dm 
          d2 = selection h fm dm
          sel = d1 <= d2 ? minSel :? h


-- -- neighbour [String] -> [(String, String, Integer)] -> VADFANSOMHELST
-- neighbour f1@(h:t) d1 
--   | length f1 > 3 = buildTree f1 d1 
--   | otherwise     = error "DONE"
-- 
-- -- Bilda hörnet u så att (a, u) samt (b, u), förutsatt att (a, b) 
-- -- är det lägsta avståndet.
-- -- Använd wikiformel för att räkna ut avstånden d1 mellan a och u samt
-- -- d2 mellan b och u.
-- -- Ta bort alla permutationer av "ab" i distansmatrisen. Lägg det nya
-- -- hörnet u som första element i distansmatrisen. 
-- -- Beräkna avstånd från alla gamla punkter skilda från a och b till 
-- -- u och kasta in i distansmatris.
-- -- Repeat til death.
-- buildTree f1 d1 = buildEdge ((\(x, _, _) -> x) oldCorner) ((\(_, x, _) -> x) oldCorner) corner d1 (length f1)
--   where 
--     minSelection :: [String] -> (String, String, Integer)
--     minSelection f1 = minDist d1 (corners d1) ("ASD", "asd", 0)
--     oldCorner = minSelection f1
--     corner = buildCorner (minSelection f1)
--      where
--        minDist :: [(String, String, Integer)] -> [(String, String)] -> (String, String, Integer) -> (String, String, Integer)
--        minDist _ [] c1 = c1
--        minDist d1 ((a, b):t) c1@(_, _, min)
--          | min <= dist2 = minDist d1 t c1 
--          | otherwise    = minDist d1 t c2 
--          where 
--            c2 = (a, b, dist2)
--            dist2 = selection d1 a b
-- 
-- buildCorner :: (String, String, Integer) -> String
-- buildCorner (a, b, _) = a ++ b
-- 
-- buildEdge :: String -> String -> String -> [(String, String, Integer)] -> Integer -> [(String, String, Distance)]
-- buildEdge a b u d1 r = (a, b, d)
--   where
--     d = 1/2*distance(a, b, d1) + 1/(2(r - 2))
-- 
-- removeCorner :: [String] -> (String, String, Integer) -> [String]
-- removeCorner [] _ = []
-- removeCorner (h:t) c@(a, b, _)
--   | h == a || h == b = removeCorner t c
--   | otherwise        = h:removeCorner t c
-- 
-- corners :: [(String, String, Integer)] -> [(String, String)]
-- corners list = map (\(a, b, _) -> (a, b)) list
-- 
-- permutate :: [String] -> [(String, String)]
-- permutate f1 = [(a, b) | a <- f1, b <- f1] 
-- 
-- selection :: [(String, String, Integer)] -> String -> String -> Integer
-- selection matrix x y = ((toInteger (length uniqueMatrix)) - 2) * (distance x y matrix) - cornerSum x y matrix uniqueMatrix
--   where
--     uniqueMatrix = unique matrix
-- 
-- 
-- cornerSum :: String -> String -> [(String, String, Integer)] -> [String] -> Integer
--     
