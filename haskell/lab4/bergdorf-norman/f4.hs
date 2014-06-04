import System.Environment
import MolSeq
import System.IO  
import Control.Monad
import Molbio

-- Metod 1. Inga skrivs :main arg1 arg2 arg3 arg4
-- där namnet på de olika sekvenserna är arg 1 och 3 och arg 2 och 4 
-- är proteinsekvenser.
main = do
	file <- getArgs -- motsvarande String [] args när man anropar ett java program med parametrar 
	let tupleList = reverse (getTuples file []) 
	let result = distanceMatrix (seqdata tupleList)--anropar distanceMatrix med vår skapade lista med tuples
	print result

-- Metod med en inparameter, fileIn är namnet på den fil som skall öppnas.
-- [] är nödvändig då f4 kräver två stycken inparameterar. 
f4 fileIn [] = do
	file <- openFile fileIn ReadMode -- öppnar fil och läser från den
	contents <- hGetContents file -- får listan av channel av file som vi öppnat för att läsa
	let allLines = lines contents -- tar in varje rad som element i allLines-listan
	let tupleList = reverse (getTuples allLines []) 
	let result = distanceMatrix (seqdata tupleList)
	print result
	
-- Metod som tar in 2 st parametrar.
-- Första är filnamnet som skall öppnas och den andra är namnet på den fil som resultatet ska sparas i. 
f4 fileIn fileOut = do
	file <- openFile fileIn ReadMode
	contents <- hGetContents file
	let allLines = lines contents
	let tupleList = reverse (getTuples allLines []) 
	let result = distanceMatrix (seqdata tupleList)
	writeFile fileOut (show result) -- skriver vårt resultat till fileOut

--nödvändig för att kunna anropa distanceMatrix då den kräver lista med tuples
-- stegar rekursivt igenom listan av rader från inparameterna och för in  resultat som tupler i tupleList
getTuples [] tupleList = tupleList
getTuples (name:seq: t) tupleList = do
		getTuples t (((tail name),seq):tupleList)
	

{-TEST main
:main >FOX ATGCTGATG >COW ATGTACAT
[("FOX", "COW", 0.44083995)]
-}

{- TEST första f4 med bara .txt fil som inparameter
*Main> f4 "foxp4.txt" []
[("FOXP4_HUMAN","FOXP4_COW",8.9884505e-2),("FOXP4_HUMAN","FOXP4_DOG",5.471934e-2),("FOXP4_HUMAN","FOXP4_FROG",
0.24521516),("FOXP4_DOG","FOXP4_COW",0.118596286),("FOXP4_RAT","FOXP4_HUMAN",4.928402e-2),("FOXP4_RAT","FOXP4_
COW",0.12444426),("FOXP4_RAT","FOXP4_DOG",8.800089e-2),("FOXP4_RAT","FOXP4_MOUSE",1.7309405e-2),("FOXP4_RAT","
FOXP4_FROG",0.25413853),("FOXP4_MOUSE","FOXP4_HUMAN",5.290411e-2),("FOXP4_MOUSE","FOXP4_COW",0.122490935),("FO
XP4_MOUSE","FOXP4_DOG",8.800089e-2),("FOXP4_MOUSE","FOXP4_FROG",0.25638255),("FOXP4_FROG","FOXP4_COW",0.314277
92),("FOXP4_FROG","FOXP4_DOG",0.2722408)]
-}

{-TEST andra f4 med två inparametrar infil.txt samr utfil.txt
*Main> f4 "foxp4.txt" "utfil.txt"
Resultat skrivs till utfil.txt
-}