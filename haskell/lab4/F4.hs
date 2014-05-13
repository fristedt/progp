import MolSeq
import Evol 
import System.IO
import System.Environment

main = getArgs >>= parse

-- Pattern match the args and perform the appropriate steps.
parse [] = do
  contents <- getContents
  print $ distanceMatrix $ translateContents $ lines contents
parse [infile] = do
  contents <- readFile infile 
  print $ distanceMatrix $ translateContents $ lines contents
parse [infile, outfile] = do
  contents <- readFile infile
  writeFile outfile $ show $ distanceMatrix $ translateContents $ lines contents

-- Grab two lines at a time, remove the > and description, and send
-- everything to string2seq. Repeat recursively.
translateContents [] = []
translateContents (nameAndDescription:dnaStuff:xs) = string2seq (head $ words $ drop 1 nameAndDescription) dnaStuff : translateContents xs
