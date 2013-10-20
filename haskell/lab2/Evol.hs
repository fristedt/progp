module Evol where
data SeqType = DNA | Protein deriving (Eq, Enum, Show)
class Evol a where
  name :: a -> String
  distance :: a -> a -> Float
  seqType :: a -> SeqType
  distanceMatrix :: [a] -> [(String, String, Float)]
  distanceMatrix a = [(name a1, name a2, distance a1 a2) | a1 <- a, a2 <- a]
  
