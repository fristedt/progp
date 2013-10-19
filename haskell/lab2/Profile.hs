module Profile where
import MolSeq
import Data.List
data Profile = Profile {
                      name :: String
                    , len :: Int
                    , matrix :: [[(Char, Float)]]
                    , seqtype :: SeqType
                       } deriving (Show)

nucleotides = "ACGT"
aminoacids = sort "ARNDCEQGHILKMFPSTWYVX"

makeProfileMatrix :: [MolSeq] -> [[(Char, Int)]]
makeProfileMatrix [] = error "Empty sequence list"
makeProfileMatrix sl = res
  where 
    t = seqType (head sl)
    n = length sl
    defaults = if (t == DNA) then
                 -- Create a list of tuples like [(A, 0), (C, 0), ..., (T, 0)]
                 zip nucleotides (replicate (length nucleotides) 0)
               else 
                 -- Same as above, but with the list aminoacids.
                 zip aminoacids (replicate (length aminoacids) 0) 
    -- Get all the sequences in sl and put them in strs.
    strs = map seqSequence sl                                    
    -- Transpose the sequences, and for each sequence, sort it,
    -- group the nucleotides/aminoacids and create a tuple for 
    -- each sequence in the form ('A', 1). This new list tmp1 will
    -- only contain the tuples where element X has a length > 0.
    tmp1 = map (map (\x -> ((head x), (length x))) . group . sort)
               (transpose strs)
    equalFst a b = (fst a ) == (fst b)
    -- Here the matrix gets filled with the elements of zero length.
    res = map sort (map (\l -> unionBy equalFst l defaults) tmp1)

fromMolSeqs :: [MolSeq] -> Profile
fromMolSeqs [] = error "Empty sequence list"
fromMolSeqs sl = res
  where
    t = seqType (head sl)
    n = length sl
    profileMatrix = makeProfileMatrix sl
    tmp1 = map (\x -> (map (\l -> ((fst l), divi (snd l) n)) x)) profileMatrix
    res = Profile (seqName (head sl)) n tmp1 t

-- Divides two ints and returns a float.
divi :: Int -> Int -> Float
divi x y = a / b 
  where a = fromIntegral x :: Float
        b = fromIntegral y :: Float

-- Assumes equal length.
profileDistance :: Profile -> Profile -> Float
profileDistance p1 p2 = distance (matrix p1) (matrix p2)

distance :: [[(Char, Float)]] -> [[(Char, Float)]] -> Float
distance ((h1:t1):r1) ((h2:t2):r2) = (snd h1 - snd h2) + distance
