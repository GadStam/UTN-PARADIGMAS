import Text.Show.Functions

data Pais = UnPais{
    ingresoPerCapita :: Int,
    poblacionActivaPublico :: Int,
    poblacionActivaPrivado :: Int,
    recursosNaturales :: [String],
    deuda :: Int
}deriving Show

argentina :: Pais
argentina = UnPais{
    ingresoPerCapita = 20,
    poblacionActivaPublico = 100,
    poblacionActivaPrivado = 100,
    recursosNaturales = ["petroleo", "gas", "mineria"],
    deuda = 1000
}
----------------Accesors----------------------
mapIngresoPerCapita :: (Int -> Int) -> Pais -> Pais
mapIngresoPerCapita f pais = pais{ingresoPerCapita = f . ingresoPerCapita $ pais}

mapPoblacionActivaPublico :: (Int -> Int) -> Pais -> Pais
mapPoblacionActivaPublico f pais = pais{poblacionActivaPublico = f . poblacionActivaPublico $ pais}

mapPoblacionActivaPrivado :: (Int -> Int) -> Pais -> Pais
mapPoblacionActivaPrivado f pais = pais{poblacionActivaPrivado = f . poblacionActivaPrivado $ pais}

mapRecursosNaturales :: ([String] -> [String]) -> Pais -> Pais
mapRecursosNaturales f pais = pais{recursosNaturales = f . recursosNaturales $ pais}

mapDeuda :: (Int -> Int) -> Pais -> Pais
mapDeuda f pais = pais{deuda = f . deuda $ pais}

---------------------------------------------

-- PUNTO A
type Estrategia = Pais -> Pais

{-esto provoca que el país se endeude en un 150% de lo que el FMI le presta (por los intereses)-}


calcularDeuda :: Int -> Int -> Int
calcularDeuda cantidad deudaActual = deudaActual + (cantidad * 3 `div` 2)

prestar :: Int -> Estrategia
prestar cantidad = mapDeuda (calcularDeuda cantidad)

reducirPuestosDeTrabajo :: Int -> Estrategia
reducirPuestosDeTrabajo cantidad pais | poblacionActivaPublico pais > 100 = cambiarIngresosYpoblacion pais cantidad 20
                                      | otherwise = cambiarIngresosYpoblacion pais cantidad 15

cambiarIngresosYpoblacion :: Pais -> Int->Int -> Pais
cambiarIngresosYpoblacion pais cantidad porcentaje = mapIngresoPerCapita (subtract (calculatePercentage porcentaje (ingresoPerCapita pais))) . mapPoblacionActivaPublico (subtract cantidad) $ pais

calculatePercentage :: Int -> Int -> Int
calculatePercentage percentage value = value * percentage `div` 100

blindaje :: Estrategia
blindaje pais = reducirPuestosDeTrabajo 500 . prestar (productoInternoBruto pais) $ pais

productoInternoBruto :: Pais -> Int
productoInternoBruto pais = ingresoPerCapita pais * (poblacionActivaPublico pais + poblacionActivaPrivado pais)

-- PUNTO B
receta3 :: Estrategia
receta3 = prestar 200 . quitarMineria

quitarMineria :: Estrategia
quitarMineria = mapRecursosNaturales (filter (/="mineria"))

-- PUNTO C
listaZafar :: [Pais]->[Pais]
listaZafar = filter (tienePetroleo)

tienePetroleo :: Pais -> Bool
tienePetroleo = elem "petroleo" . recursosNaturales

deudaTotal :: [Pais] -> Int
deudaTotal = sum . map deuda

aplicarReceta :: [Estrategia] -> Pais -> Pais
-- opción con foldl + lambda
-- aplicarReceta receta pais = foldl (\pais estrategia -> estrategia pais) pais receta
-- opción con foldr + $
aplicarReceta receta pais = foldr ($) pais receta



-- Punto 6 - 1 punto
-- Si un país tiene infinitos recursos naturales, modelado con esta función
recursosNaturalesInfinitos :: [String]
recursosNaturalesInfinitos = "Energia" : recursosNaturalesInfinitos

--    a) ¿qué sucede con la función 4a? 
--    b) ¿y con la 4b?
--    Justifique ambos puntos relacionándolos con algún concepto.
-- pruebaInfinita1 = puedenZafar [namibia, Pais 1 1 1 recursosNaturalesInfinitos 1]
--              no termina nunca, porque quiere buscar "Mineria" entre los recursos
-- pruebaInfinita2 = totalDeuda [namibia, Pais 1 1 1 recursosNaturalesInfinitos 1]
--              se puede porque al no evaluar los recursos solamente suma deuda
-- relacionado con evaluacion diferida, solo se evalua lo que se necesita

-- Evaluacion
-- **********
-- 14     = 10
-- 13     =  9
-- 12, 11 =  8
-- 10     =  7
--  8, 9  =  6
--  7     = Revision
--  6     =  3
--  5..0  =  2

f :: Ord p => ((a, Bool) -> b) -> (b -> p) -> p -> [a] -> p
f x y h (c:cs) | (y . x) (c, True) > h = f x y h cs
               | otherwise             = h

