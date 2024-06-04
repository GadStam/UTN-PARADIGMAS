import Text.Show.Functions
data Chocolate = UnChocolate{
    nombre :: String,
    porcentajeCacao :: Int,
    porcentajeAzucar :: Int,
    ingredientes :: [Ingrediente]
}deriving Show

data Ingrediente = UnIngrediente{
    nombreIngrediente :: String,
    caloriasIngrediente :: Int
}deriving Show
--type Ingrediente = Chocolate -> Chocolate
type Peso = Float

chocolate1 :: Chocolate
chocolate1 = UnChocolate{
    nombre = "Chocolate1",
    porcentajeCacao = 70,
    porcentajeAzucar = 0,
    ingredientes = [UnIngrediente "Leche" 50, UnIngrediente "Azucar" 50]
}


---------------------------------------------PUNTO 1---------------------------------------------------------

costoPorChocolate :: Peso -> Chocolate -> Float
costoPorChocolate unPeso unChocolate 
    | esAmargo unChocolate = calcularPrecioPremium unChocolate unPeso
    | tieneMasIngredientes unChocolate = calcularPrecio4Ingredientes unPeso
    | otherwise = calcularPrecioBase unPeso

esAmargo :: Chocolate -> Bool
esAmargo unChocolate = (porcentajeCacao unChocolate) > 60

calcularPrecioPremium :: Chocolate -> Peso -> Float
calcularPrecioPremium unChocolate unPeso | esAptoDiabeticos unChocolate = 8 * unPeso
                                         | otherwise = 5 * unPeso

esAptoDiabeticos :: Chocolate -> Bool
esAptoDiabeticos unChocolate = (porcentajeAzucar unChocolate) == 0

tieneMasIngredientes :: Chocolate -> Bool
tieneMasIngredientes unChocolate = (length . ingredientes $ unChocolate) > 4

calcularPrecio4Ingredientes :: Peso -> Float
calcularPrecio4Ingredientes unPeso = 8 * unPeso

calcularPrecioBase :: Peso -> Float
calcularPrecioBase unPeso = 1.5 * unPeso
------------------------------------------------------------------------------------------------------------

esBombonAsesino :: Chocolate -> Bool
esBombonAsesino unChocolate = any (>200) (map caloriasIngrediente (ingredientes unChocolate))

totalCalorias :: Chocolate -> Int
totalCalorias unChocolate = sum . map caloriasIngrediente $ ingredientes unChocolate

aptosParaNinos :: [Chocolate] -> [Chocolate]
aptosParaNinos chocolates = take 3 (filtrarChocolates chocolates)

filtrarChocolates :: [Chocolate] -> [Chocolate]
filtrarChocolates chocolates = filter (not . esBombonAsesino) chocolates

----------------------------------------------------------------------------------------------------------------
type Proceso = Chocolate -> Chocolate

mapIngedientes :: ([Ingrediente] -> [Ingrediente]) -> Chocolate -> Chocolate
mapIngedientes unaFuncion unChocolate = unChocolate {ingredientes = unaFuncion .ingredientes $ unChocolate}

frutalizado :: String -> Proceso
frutalizado fruta unChocolate = mapIngedientes (agregarFruta fruta) unChocolate

agregarFruta :: String -> [Ingrediente] -> [Ingrediente]
agregarFruta fruta ingredientes = ingredientes ++ [UnIngrediente fruta 50]



-----------------------------------------------------------------------------------------------------------------

preparacionChocolate :: [Proceso] -> Chocolate -> Chocolate
preparacionChocolate procesos unChocolate = foldr ($) unChocolate procesos




