module MolSeq where
import Evol
data MolSeq = MolSeq {
            name, sequence :: String
            , seqType :: SeqType} 
            deriving (Show)

instance Evol MolSeq where
  distance s1 s2 = seqDistance s1 s2
  name s         = seqName s
  seqType s      = getType s

string2seq :: String -> String -> MolSeq
string2seq name sequence
  | isDNA sequence = MolSeq name sequence DNA
  | otherwise      = MolSeq name sequence Protein

isDNA :: String -> Bool
isDNA [] = True
isDNA (c:s)  
  | elem c "ACGT" = isDNA s
  | otherwise     = False

seqName :: MolSeq -> String
seqName molseq = (MolSeq.name molseq)

seqSequence :: MolSeq -> String
seqSequence molseq = (MolSeq.sequence molseq)

seqLength :: MolSeq -> Int 
seqLength molseq = length (MolSeq.sequence molseq)

getType :: MolSeq -> SeqType
getType molseq = (MolSeq.seqType molseq)

seqDistance :: MolSeq -> MolSeq -> Float
seqDistance (MolSeq _ seq1 seqType1) (MolSeq _ seq2 seqType2)
  | seqType1 /= seqType2 = error "Can't compare protein with DNA."
  | seqType1 == DNA      = jukesCantor seq1 seq2 0 0
  | seqType1 == Protein  = poisson seq1 seq2 0 0 

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
