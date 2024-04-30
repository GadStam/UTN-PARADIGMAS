dispersion:: Int -> Int -> Int -> Int
dispersion dia1 dia2 dia3 = (calcularMaximo dia1 dia2 dia3) - (calcularMinimo dia1 dia2 dia3)

calcularMaximo:: Int -> Int -> Int -> Int
calcularMaximo dia1 dia2 dia3 = max dia1 (max dia2 dia3)

calcularMinimo:: Int -> Int -> Int -> Int
calcularMinimo dia1 dia2 dia3 = min dia1 (min dia2 dia3)


tipoDeDia:: Int -> Int -> Int -> String
tipoDeDia dia1 dia2 dia3
    | esDiasParejos dia1 dia2 dia3 = "parejos" --guardas
    | esDiasLocos dia1 dia2 dia3 = "locos"
    | otherwise = "normales"

esDiasParejos:: Int -> Int -> Int -> Bool
esDiasParejos dia1 dia2 dia3 = dispersion dia1 dia2 dia3 < 30

esDiasLocos:: Int -> Int -> Int -> Bool
esDiasLocos dia1 dia2 dia3 = dispersion dia1 dia2 dia3 > 100



