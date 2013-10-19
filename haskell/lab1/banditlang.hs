isConst :: Char -> Bool
isConst c = elem c "BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz"

isVowel :: Char -> Bool
isVowel c = elem c "AEIOUYÅÄÖaeiouyåäö"

rovarsprak :: String -> String
rovarsprak [] = []
rovarsprak (c:s)
  | isConst c = c : 'o' : c : rovarsprak s
  | otherwise = c : rovarsprak s

svenska :: String -> String
svenska [] = []
svenska (c:s)
  | isVowel c = c : svenska s
  | isConst c = let s1 = tail s
                    s2 = tail s1
                in  c : svenska (s2)


