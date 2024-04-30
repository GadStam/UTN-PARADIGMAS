palabra :: String
palabra = "hola"

sacarLetras :: String -> String
sacarLetras palabra = take 3 palabra

encontrarAlgo :: String -> [String] -> Bool
encontrarAlgo palabra lista = elem palabra lista


reverseFunction :: String -> String
reverseFunction palabra = reverse palabra

anyFunction :: [Int] -> Bool
anyFunction lista= any (>4) lista

filterFunction :: [Int] -> [Int]
filterFunction lista=  filter (>4) lista