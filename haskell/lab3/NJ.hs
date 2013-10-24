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
minSelection em fm dm = go Nothing em dm
  where 
    go :: Maybe (String, String) -> [(String, String)] -> Map.Map (String, String) Integer -> (String, String)
    go (Just minSel) [] _      = minSel             -- Last iteration, return the minimum selection.
    go Nothing (h:t) dm        = go (Just h) t dm   -- First iteration, set the first tuple as the minimum one.
    go (Just minSel) (h:t) dm  = go (Just sel) t dm -- Compare the current minimum selection with the new one.
      where
        d1  = selection minSel fm dm
        d2  = selection h fm dm
        sel = d1 <= d2 ? minSel :? h
