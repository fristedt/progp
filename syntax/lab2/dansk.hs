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
en2ni ("nul":tail)  = 0
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
en2ni (word:tail)   = ti2nitten word

ti2nitten :: String -> Int
ti2nitten "ti"      = 10
ti2nitten "ellve"   = 11
ti2nitten "tolv"    = 12
ti2nitten "tretten" = 13
ti2nitten "fjorten" = 14
ti2nitten "femten"  = 15
ti2nitten "seksten" = 16
ti2nitten "sytten"  = 17
ti2nitten "atten"   = 18
ti2nitten "nitten"  = 19
ti2nitten word      = tyve2halvfems [word]

mer :: [String] -> Int
mer ("og":tail) = tyve2halvfems tail
mer _           = 0 

tyve2halvfems :: [String] -> Int
tyve2halvfems ("tyve":tail)      = 20
tyve2halvfems ("tredive":tail)   = 30
tyve2halvfems ("fyrre":tail)     = 40
tyve2halvfems ("fyrretyve":tail) = 50
tyve2halvfems words              = halvtreds2halvfems words
          
halvtreds2halvfems :: [String] -> Int
halvtreds2halvfems ("halv":tail) = (-10 + halvmult (last tail))

mult :: String -> Int
mult "tres" = 60
mult "firs" = 80
mult "fjerds" = 80

halvmult :: String -> Int
halvmult "fems" = 100
halvmult word = mult word

emfas :: String -> Int
emfas word
  | word == "sindstyve" = 20
  | word == ""          = 20
  | otherwise           = error "Inte okej!"

-- main :: IO ()
main = do
  z <- readFile "dr.txt"
  -- print (lines z)
  -- map (print (dansk)) (lines z)
  mapM_ (print . dansk) (lines z)
  -- print dansk)a
