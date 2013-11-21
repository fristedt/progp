module NJ where
import Data.List 
import qualified Data.Map as Map
import qualified Data.Set as Set

type EdgeSet = Set.Set (String, String)

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

-- Set of all initial edges.
em1 = edges tm1
em2 = edges tm2

-- Removes the distance from a distance matrix.
edges :: [(String, String, Float)] -> [(String, String)]
edges tm = map (\(a, b, _) -> (a, b)) tm

-- Build a map of key -> value pairs where key is a tuple (a, b) and value is the distance.
buildDistanceMap :: [(String, String, Float)] -> Map.Map (String, String) Float
buildDistanceMap tm = Map.fromList m 
  where
    m = map (\(a, b, d) -> ((a, b), d)) tm  

-- Makes paths bidirectional. 
mirror :: [(String, String, Float)] -> [(String, String, Float)]
mirror [] =  []
mirror (head@(a, b, d):t) 
  | a == b    = head:mirror t
  | otherwise = head:(b, a, d):mirror t

-- Returns distance between a and b in key@(a, b) using lookup in map.
distance :: (String, String) -> Map.Map (String, String) Float -> Float
distance key map = case Map.lookup key map of 
  Nothing -> 0 
  Just x -> x

-- Return all the unique corners in the matrix containing the edges.
unique :: [(String, String)] -> [String]
unique list = nub (map (\(x, _) -> x) list)

-- Returns a crazy integer that we need for determining stuff.
selection :: (String, String) -> [String] -> Map.Map (String, String) Float -> Float
selection (a, b) fm dm = (fromIntegral (length fm) - 2.0) * (distance (a, b) dm) - cornerSum a b fm dm
  where
    cornerSum :: String -> String -> [String] -> Map.Map (String, String) Float -> Float
    cornerSum _ _ [] _ = 0
    cornerSum a b (h:t) dm
      | a == b = 0
      | abs d1 >= 0 && abs d2 >= 0 = d1 + d2 + cornerSum a b t dm 
      | otherwise = cornerSum a b t dm 
      where
        d1 = distance (a, h) dm 
        d2 = distance (b, h) dm

-- Returns the tuple (a, b) that minimizes S(a, b).
minSelection :: [(String, String)] -> [String] -> Map.Map (String, String) Float -> (String, String)
minSelection em fm dm = go Nothing em dm
  where 
    go :: Maybe (String, String) -> [(String, String)] -> Map.Map (String, String) Float -> (String, String)
    go (Just minSel) [] _      = minSel             -- Last iteration, return the minimum selection.
    go Nothing (h@(a, b):t) dm = go (Just h) t dm
    go (Just minSel) (h@(a, b):t) dm 
      | d1 <= d2  = go (Just minSel) t dm -- Compare the current minimum selection with the new one.
      | otherwise = go (Just h) t dm
      where
        d1  = selection minSel fm dm
        d2  = selection h fm dm

-- neighbor :: [(String, String, Float)] -> [(String, String)]
neighbor tm = buildTree nodes res 
  where
    nodes = (unique (edges tm)) 
    res = go (buildDistanceMap (mirror tm)) nodes (edges tm) Set.empty 1
    go :: Map.Map (String, String) Float -> [String] -> [(String, String)] -> EdgeSet -> Integer -> EdgeSet
    go dm fm em es i 
      | length fm <= 3 = es 
      -- | i == 3         = selection ("e", "f") fm dm
      -- | i == 3         = selection ("c", "v1") fm dm
      -- | i == 3         = [(a, b) | a <- fm, b <- fm]
      -- | i == 3         = minSel
      | otherwise      = go newDm newFm newEm newEs (i + 1) 
      where 
        minSel = minSelection [(a, b) | a <- fm, b <- fm] fm dm
        newCorner = makeCorner i 
        newFm = subCorner fm minSel newCorner
        newDm = recalcDistances newFm minSel newCorner dm
        newEm = removeEdges (addEdges em newCorner minSel) minSel
        newEs = Set.insert minSel es

-- Make a corner v(i).
makeCorner :: Integer -> String
makeCorner i = 'v' : (show i)

-- Removes all occurrences of a and b in (a, b) from the list of strings and add v(i).
subCorner :: [String] -> (String, String) -> String -> [String]
subCorner corners edge corner = (filter (\x -> (x /= fst edge) && (x /= snd edge)) corners) ++ [corner]

-- Add edges.
addEdges :: [(String, String)] -> String -> (String, String) -> [(String, String)]
addEdges edges corner edge = edges ++ (((fst edge), corner) : [((snd edge), corner)])

removeEdges :: [(String, String)] -> (String, String) -> [(String, String)]
removeEdges edges edge = filter (\x -> x /= edge) edges

-- -- recalcDistances :: Edges -> NewCorner -> MinSel -> Distances -> NewDistances
-- recalcDistances :: [(String, String)] -> String -> (String, String) -> Map.Map (String, String) Float -> Map.Map (String, String) Float
recalcDistances :: [String] -> (String, String) -> String -> Map.Map (String, String) Float -> Map.Map (String, String) Float
recalcDistances corners minSel corner dm = go corners minSel corner dm []
  where
    go :: [String] -> (String, String) -> String -> Map.Map (String, String) Float -> [(String, String, Float)]-> Map.Map (String, String) Float
    go [] _ _ dm list = Map.union dm (buildDistanceMap (mirror list))
    go (h:t) minSel@(a, b) corner dm list 
      | h /= a && h /= b = go t minSel corner dm (tup : list)
      | otherwise = go t minSel corner dm list
      where
        d1  = distance (h, a) dm 
        d2  = distance (h, b) dm 
        tup = (h, corner, (d1 + d2) / 2)
