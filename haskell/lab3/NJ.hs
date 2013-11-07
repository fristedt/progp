module NJ where
import Data.List 
import qualified Data.Map as Map
import qualified Data.Set as Set

type DistanceMap     = Map.Map Edge Float
type DistanceTriplet = (String, String, Float)
type NodeSet         = Set.Set String
type Edge            = (String, String) 

tm1 :: [DistanceTriplet]
tm1 = [("a", "a", 0), ("a", "b", 2), ("a", "c", 3), ("a", "d", 5), ("a", "e", 6), ("a", "f", 5),
       ("b", "b", 0), ("b", "c", 3), ("b", "d", 5), ("b", "e", 6), ("b", "f", 5),
       ("c", "c", 0), ("c", "d", 4), ("c", "e", 5), ("c", "f", 4),
       ("d", "d", 0), ("d", "e", 5), ("d", "f", 4),
       ("e", "e", 0), ("e", "f", 3),
       ("f", "f", 0)]

tm2 :: [DistanceTriplet]
tm2 = [("a", "a", 0), ("a", "b", 7), ("a", "c", 11), ("a", "d", 14),
       ("b", "b", 0), ("b", "c", 6), ("b", "d", 9),
       ("c", "c", 0), ("c", "d", 7),
       ("d", "d", 0)]

-- Build a map of key -> value pairs where key is a tuple (a, b) and value is the distance.
buildDistanceMap :: [DistanceTriplet] -> DistanceMap
buildDistanceMap tm = Map.fromList m 
  where
    m = map (\(a, b, d) -> ((a, b), d)) tm  

-- Makes paths bidirectional. 
mirror :: [DistanceTriplet] -> [DistanceTriplet]
mirror [] =  []
mirror (head@(a, b, d):t) 
  | a == b    = head:mirror t
  | otherwise = head:(b, a, d):mirror t

-- Returns distance between a and b in key@(a, b) using lookup in map.
distance :: Edge -> DistanceMap -> Float
distance key map = case Map.lookup key map of 
  Nothing -> 0 
  Just x -> x

-- Returns a crazy integer that we need for determining stuff.
selection :: Edge -> [String] -> DistanceMap -> Float
selection (a, b) fm dm = (fromIntegral (length fm) - 2.0) * (distance (a, b) dm) - nodeSum a b fm dm
  where
    nodeSum :: String -> String -> [String] -> DistanceMap -> Float
    nodeSum _ _ [] _ = 0
    nodeSum a b (h:t) dm
      | a == b = 0
      | abs d1 >= 0 && abs d2 >= 0 = d1 + d2 + nodeSum a b t dm 
      | otherwise = nodeSum a b t dm 
      where
        d1 = distance (a, h) dm 
        d2 = distance (b, h) dm

-- Returns the tuple (a, b) that minimizes S(a, b).
minSelection :: [Edge] -> NodeSet -> DistanceMap -> Edge
minSelection em fm dm = go Nothing em (Set.toList fm) dm
  where 
    go :: Maybe Edge -> [Edge] -> [String] -> DistanceMap -> Edge
    go (Just minSel) []_ _      = minSel             -- Last iteration, return the minimum selection.
    go Nothing (h@(a, b):t) fml dm = go (Just h) t fml dm
    go (Just minSel) (h@(a, b):t) fml dm 
      | d1 <= d2  = go (Just minSel) t fml dm -- Compare the current minimum selection with the new one.
      | otherwise = go (Just h) t fml dm
      where
        d1  = selection minSel fml dm
        d2  = selection h fml dm

-- Build a node set. #unnecessaryComments
buildNodeSet :: [DistanceTriplet] -> NodeSet
buildNodeSet dt = Set.fromList (nub (map (\(a, _, _) -> a) dt))

-- Removes the distance from a list of distance triplet.
edges :: [DistanceTriplet] -> [Edge]
edges tm = map (\(a, b, _) -> (a, b)) tm

-- neighbor :: [DistanceTriplet] -> [Edge]
-- neighbor tm = go (buildDistanceMap (mirror tm)) (unique (edges tm)) (edges tm) 1
neighbor tm = go (buildDistanceMap (mirror tm)) (buildNodeSet tm) (edges tm) 1
  where
    -- go :: Map.Map Edge Float -> [String] -> [Edge] -> Integer -> [Edge]
    go dm fm em i 
      -- | length fm <= 3 = fm
      -- | i == 3         = selection ("d", "v2") fm dm
      -- | i == 3         = selection ("e", "f") fm dm
      -- | i == 3         = [(a, b) | a <- fm, b <- fm]
      | i == 3         = minSel
      | otherwise      = go newDm newFm newEm (i + 1) 
      where 
        fml = Set.toList fm
        minSel = minSelection [(a, b) | a <- fml, b <- fml] fm dm
        newNode = makeNode i 
        newFm = subNode fm minSel newNode
        newDm = recalcDistances newFm minSel newNode dm
        newEm = removeEdges (addEdges em newNode minSel) minSel

-- Make a node v(i).
makeNode :: Integer -> String
makeNode i = 'v' : (show i)

-- Removes all occurrences of a and b in (a, b) from the list of strings and add v(i).
subNode :: NodeSet -> Edge -> String -> NodeSet
-- subNode nodes edge node = (filter (\x -> (x /= fst edge) && (x /= snd edge)) nodes) ++ [node]
subNode nodes (a, b) node = Set.insert node (Set.delete a (Set.delete b nodes))
                            

-- Add edges.
addEdges :: [Edge] -> String -> Edge -> [Edge]
addEdges edges node edge = edges ++ (((fst edge), node) : [((snd edge), node)])

removeEdges :: [Edge] -> Edge -> [Edge]
removeEdges edges edge = filter (\x -> x /= edge) edges

-- -- recalcDistances :: Edges -> NewNode -> MinSel -> Distances -> NewDistances
-- recalcDistances :: [Edge] -> String -> Edge -> Map.Map Edge Float -> Map.Map Edge Float
recalcDistances :: NodeSet -> Edge -> String -> DistanceMap -> DistanceMap
recalcDistances nodes minSel node dm = go (Set.toList nodes) minSel node dm []
  where
    go :: [String] -> Edge -> String -> DistanceMap -> [DistanceTriplet]-> DistanceMap
    go [] _ _ dm list = Map.union dm (buildDistanceMap (mirror list))
    go (h:t) minSel@(a, b) node dm list 
      | h /= a && h /= b = go t minSel node dm (tup : list)
      | otherwise = go t minSel node dm list
      where
        d1  = distance (h, a) dm 
        d2  = distance (h, b) dm 
        tup = (h, node, (d1 + d2) / 2)
