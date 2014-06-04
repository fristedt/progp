module MolSeq where
import Data.List
data MolSeq = NST String String SeqType
			deriving (Show)
			
data Profile = NTN [[(Char, Float)]] SeqType String Int 
			deriving (Show,Eq) 
			
data SeqType = DNA | Protein
			deriving (Show, Eq) 
			
class Evol a where  
   distance :: a -> a -> Float
   distanceMatrix :: [a] -> [(String, String, Float)]
   getName :: a -> String
   
instance Evol MolSeq where
	distance a b = seqDistance a b
	getName a = seqName a
	distanceMatrix a = distanceM a
	
instance Evol Profile where
	distance a b = profileDistance a b
	getName a = profileName a
	distanceMatrix a = distanceM a

-- Tar in en lista av Molseq/Profile från distanceMatrix
distanceM evolList = listTup
	where 
	listTup = [(getName a, getName b, distance a b) | a <- evolList, b <- evolList, (getName b) < (getName a)] 

-- Metoden som avgör om det är en DNA eller Protein sträng vi får in			
string2seq :: String -> String -> MolSeq
string2seq name sequence = string2seq2 name sequence sequence				

-- Hjälpmetod för att stega igenom sequence
string2seq2 name (head:tail) sequence			
						|tail == [] = NST name sequence DNA
						|elem head "ATCG" = string2seq2 name tail sequence
						|otherwise = NST name sequence Protein

seqName :: MolSeq -> String
seqName (NST name _ _) = name

profileName :: Profile -> String
profileName (NTN _ _ name _) = name

seqSequence :: MolSeq -> String
seqSequence (NST _ sequence _) = sequence

seqType :: MolSeq -> SeqType 
seqType (NST _ _ typ) = typ

seqLength :: MolSeq -> Int
seqLength (NST _ sequence _) = (length sequence)

getMatrix :: Profile -> [[(Char, Float)]]
getMatrix (NTN matrix _ _ _) = matrix

seqDistance :: MolSeq -> MolSeq -> Float
seqDistance (NST name sequence typ) (NST name2 sequence2 typ2)
						|not(typ == typ2) = (error "Not same type of sequence")
						|typ == DNA = dnaCalc sequence sequence2
						|otherwise = proteinCalc sequence sequence2
						
						
{-Metoden representerar "a" i matteformeln som ska användas.
vi får fram den genom att ta andelen som är samma (i sekvensen) genom totala antalet-}
checkPos :: String -> String -> Int -> String -> String -> Float
checkPos (seq1:tail) (seq2:tail2) nr hela1 hela2
						|tail == [] = (fromIntegral (nr))/ fromIntegral (max (length (hela1)) (length (hela2)))			
						|tail2 == [] = (fromIntegral (nr) )/ fromIntegral (max (length (hela1)) (length (hela2)))
						|seq1 == seq2 = checkPos tail tail2 nr hela1 hela2					 
						|otherwise = checkPos tail tail2 (nr+1) hela1 hela2
										

dnaCalc :: String -> String -> Float
dnaCalc seq1 seq2 
						|checkPos seq1 seq2 0 seq1 seq2 > 0.74 = 3.3
						|otherwise = (-0.75)*log(1 - (4 * checkPos seq1 seq2 0 seq1 seq2/ 3))
					
	
proteinCalc :: String -> String -> Float			
proteinCalc seq1 seq2	
						|checkPos seq1 seq2 0 seq1 seq2 >= 0.94 = 3.7
						|otherwise = ((-19/20)*log(1-(20*checkPos seq1 seq2 0 seq1 seq2)/19))
						
					
nucleotides = "ACGT"
aminoacids = sort "ARNDCEQGHILKMFPSTWYVX"

makeProfileMatrix :: [MolSeq] -> [[(Char, Float)]] 
makeProfileMatrix [] = error "Empty sequence list"
makeProfileMatrix sl = res
  where 
    t = seqType (head sl)
    n = length sl
    defaults = if (t == DNA) then 
                 zip nucleotides (replicate (length nucleotides) 0) -- Rad (i) slår ihop bokstäverna med 0:or till en tupel, DNA
               else 
                 zip aminoacids (replicate (length aminoacids) 0)   -- Rad (ii) slår ihop bostäverna med 0:or till en tuble, Protein
    strs = map seqSequence sl                                       -- Rad (iii) gör en lista av alla sekvenser som medkommer av sl 
    tmp1 = map (map (\x -> ((head x), fromIntegral (length x) / fromIntegral (n))) . group . sort)  -- Rad (iv) tmp1 är en lista (listor av listor)*
               (transpose strs)
    equalFst a b = (fst a ) == (fst b)
    res = map sort (map (\l -> unionBy equalFst l defaults) tmp1)  -- Input: unionBy (\x y -> x*3==y) [1,2,3,4] [4,6,9,10] Output: [1,2,3,4,4,10]
-- *sort tar (transpose strs) som parameter, group tar sort som parameter...
-- length av x är längden av exempelvis hur många a det står i första raden efter att group och sort har körts 


{-gör om en listor av molseq till en profile-}
fromMolSeqs [] = error "No molseqs were entered"
fromMolSeqs molseq = profile 
	where 
	name = seqName (head molseq)
	tmpmat = makeProfileMatrix molseq		
	rows = length tmpmat
	typ  = seqType (head molseq)
	profile = NTN tmpmat typ name rows 

				 		
{-Klumpar ihop alla siffror från matrisen till en lista och "zippar" ihop listorna 
med minus (-) samt abs så att resultatet blir en float-}
profileDistance :: Profile -> Profile -> Float   
profileDistance profile1 profile2 = res
	where
	mat1 = map snd (concat (getMatrix profile1)) 
	mat2 = map snd (concat (getMatrix profile2))
	res = sum (map abs (zipWith (-) mat1 mat2))	
	
