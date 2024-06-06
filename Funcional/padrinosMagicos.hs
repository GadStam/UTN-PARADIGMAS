import Text.Show.Functions()

data Chico = UnChico{
    nombre :: String,
    edad :: Int,
    habilidades :: [String],
    desesos :: [Deseo]
}deriving Show

type Deseo = Chico -> Chico

timy :: Chico
timy = UnChico{
    nombre = "Timy",
    edad = 10,
    habilidades = ["mirar television", "jugar en la pc"],
    desesos = [serMayor]
}
juan :: Chico
juan = UnChico{
    nombre = "Juan",
    edad = 10,
    habilidades = ["matar", "jugar en la pc"],
    desesos = [serMayor]
}

---------------------ACCESORS---------------------
mapHabilidades :: ([String] -> [String]) -> Chico -> Chico
mapHabilidades f chico = chico {habilidades = f . habilidades $ chico}

mapDesesos :: ([Deseo] -> [Deseo]) -> Chico -> Chico
mapDesesos f chico = chico {desesos = f . desesos $ chico}

mapEdad :: (Int -> Int) -> Chico -> Chico
mapEdad f chico = chico {edad = f . edad $ chico}

-------------------------------------------------------
-- PUNTO A
-- 1.
aprenderHablidades :: [String] -> Deseo
aprenderHablidades nuevasHabilidades chico = mapHabilidades (++nuevasHabilidades) chico

serGroseroEnNeedForSpeed :: Deseo
serGroseroEnNeedForSpeed chico = mapHabilidades (++versionesJuego) chico

versionesJuego :: [String]
versionesJuego = map (crearJuego) [1..]

crearJuego :: Int -> String
crearJuego version = "Need for Speed " ++ show version

serMayor :: Deseo
serMayor chico = mapEdad (const 18) chico

-----------
-- 2.
wanda :: Chico -> Chico
wanda chico = madurar . primerDeseo chico $ chico

madurar :: Chico -> Chico
madurar = mapEdad (+1)

primerDeseo :: Chico -> Deseo
primerDeseo = head . desesos 

cosmo :: Chico -> Chico
cosmo = mapEdad desMadurar

desMadurar :: Int -> Int
desMadurar edad = edad `div` 2

muffinMagico :: Chico -> Chico
muffinMagico chico = foldr ($) chico (desesos chico)

------------------------------------------------------------------
-- PUNTO B
-- 1.
tieneHabilidad :: String -> Chico -> Bool
tieneHabilidad habilidad chico = elem habilidad . habilidades $ chico

esSuperMaduro :: Chico -> Bool
esSuperMaduro chico = mayorDeEdad chico && tieneHabilidad "manejar" chico

mayorDeEdad :: Chico->Bool
mayorDeEdad chico = (>18) . edad $ chico

----------
--- 2. 
data Chica = UnaChica{
    nombreChica :: String,
    condicion :: Chico -> Bool
}deriving Show

trixie :: Chica
trixie = UnaChica{
    nombreChica = "Trixie",
    condicion = tieneHabilidad "ser super Modelo Noruego"
}

quienConquistaA :: Chica -> [Chico] -> Chico
quienConquistaA chica chicos = head . filter (condicion chica) $ chicos

comparando :: Chica -> [Chico] -> Chico
comparando chica (cabeza:cola) | condicion chica cabeza = cabeza
                                | null cola = cabeza
                               | otherwise = comparando chica cola

---------------------------------------------------------------------------
-- PUNTO C
-- 1.

infractoresDeDaRules :: [Chico] -> [String]
infractoresDeDaRules chicos =  map nombre (filter (buscarProhibidas . tomar5habilidades . aplicoDeseo) chicos)

aplicoDeseo :: Chico -> Chico
aplicoDeseo chico = muffinMagico chico

tomar5habilidades :: Chico -> [String]
tomar5habilidades chico = take 5 . habilidades $ chico

buscarProhibidas :: [String] -> Bool
buscarProhibidas habilidades = any (habilidadProhibida) habilidades

habilidadProhibida :: String -> Bool
habilidadProhibida "enamorar" = True
habilidadProhibida "matar" = True
habilidadProhibida "dominar el mundo" = True
habilidadProhibida _ = False
