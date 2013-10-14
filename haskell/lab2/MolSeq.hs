module MolSeq where
data MolSeq = DNA {name :: String, mySequence :: String}
            | Protein {name :: String, mySequence :: String} deriving (Show)

string2seq :: String -> String -> MolSeq
string2seq name sequence
  | isDNA sequence = DNA name sequence
  | otherwise      = Protein name sequence

isDNA :: String -> Bool
isDNA [] = True
isDNA (c:s)  
  | elem c "ACGT" = isDNA s
  | otherwise     = False

seqName :: MolSeq -> String
seqName molseq = (name molseq)

seqSequence :: MolSeq -> String
seqSequence molseq = (mySequence molseq)

seqLength :: MolSeq -> Int 
seqLength molseq = length (mySequence molseq)

seqDistance :: MolSeq -> MolSeq -> Float
seqDistance (DNA _ seq1) (DNA _ seq2) = jukesCantor seq1 seq2 0 0
seqDistance (Protein _ seq1) (Protein _ seq2) = poisson seq1 seq2 0 0 
seqDistance _ _ = error "Can't compare protein with DNA."

-- Assumes equal length for seq1 and seq2.
jukesCantor :: String -> String -> Float -> Float -> Float
jukesCantor [] [] length diffs
  | diffs / length > 0.74 = 3.3
  | otherwise             = (-3)/4*log (1 - 4*(diffs/length)/3) 
jukesCantor (c1:s1) (c2:s2) length diffs
  | c1 /= c2  = jukesCantor s1 s2 (length + 1) (diffs + 1)
  | otherwise = jukesCantor s1 s2 (length + 1) diffs

poisson :: String -> String -> Float -> Float -> Float
poisson [] [] length diffs
  | diffs / length > 0.94 = 3.7
  | otherwise             = (-19)/20*log (1 - 20 * (diffs / length)/19)
poisson (c1:s1) (c2:s2) length diffs
  | c1 /= c2  = poisson s1 s2 (length + 1) (diffs + 1)
  | otherwise = poisson s1 s2 (length + 1) diffs
