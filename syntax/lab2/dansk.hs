-- translate :: String -> Int
-- translate s = perWord (words s)
--   where 
--     perWord :: [String] -> Int
--     perWord [] = 0
--     perWord (h:s) = dansk h + perWord s
import System.IO
import Control.Monad

dansk :: String -> Int
dansk word = en2ni (words word)

en2ni :: [String] -> Int
en2ni ("nul":tail)  = 0 + (mer tail)
en2ni ("en":tail)   = 1 + (mer tail)
en2ni ("et":tail)   = 1 + (mer tail)
en2ni ("to":tail)   = 2 + (mer tail)
en2ni ("tre":tail)  = 3 + (mer tail)
en2ni ("fire":tail) = 4 + (mer tail)
en2ni ("fem":tail)  = 5 + (mer tail)
en2ni ("seks":tail) = 6 + (mer tail)
en2ni ("syv":tail)  = 7 + (mer tail)
en2ni ("otte":tail) = 8 + (mer tail)
en2ni ("ni":tail)   = 9 + (mer tail)
en2ni words   = ti2nitten words

ti2nitten :: [String] -> Int
ti2nitten ["ti"]      = 10
ti2nitten ["ellve"]   = 11
ti2nitten ["tolv"]    = 12
ti2nitten ["tretten"] = 13
ti2nitten ["fjorten"] = 14
ti2nitten ["femten"]  = 15
ti2nitten ["seksten"] = 16
ti2nitten ["sytten"]  = 17
ti2nitten ["atten"]   = 18
ti2nitten ["nitten"]  = 19
ti2nitten word      = tyve2halvfems word

mer :: [String] -> Int
mer []          = 0
mer ("":tail)   = 0 
mer ("og":tail) = tyve2halvfems tail
mer asdf        = error "CUT IT THE FUCK AUS!"

tyve2halvfems :: [String] -> Int
tyve2halvfems ("tyve":tail)      = 20
tyve2halvfems ("tredive":tail)   = 30
tyve2halvfems ("fyrre":tail)     = 40
tyve2halvfems ("fyrretyve":tail) = 40
tyve2halvfems words              = halvtreds2halvfems words
          
halvtreds2halvfems :: [String] -> Int
halvtreds2halvfems ("halv":tail) = 20*(halvmult tail) - 10 
halvtreds2halvfems words = 20*(mult words)

mult :: [String] -> Int
mult ("tres":tail) = 3 + (emfas tail)
mult ("firs":tail) = 4 + (emfas tail)
mult ("fjerds":tail) = 4 + (emfas tail)
mult fuckerdoodle = error "NaN, bitch!"

halvmult :: [String] -> Int
halvmult ("fems":tail) = 5 + (emfas tail)
halvmult word = mult word

emfas :: [String] -> Int
emfas word
  | word == ["sindstyve"] = 0
  | word == []            = 0
  | otherwise           = error "Inte okej!"

test = do
  good <- readFile "dr.txt"
  bad <- readFile "dr-fel.txt"
  mapM_ (print . dansk) (lines good)

main = do
  forever $ do
    line <- getLine
    putStrLn $ show $ dansk line
  
