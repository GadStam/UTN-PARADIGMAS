import Text.Show.Functions

data Tutista = UnTurista{
    nivelCansancio :: Int,
    nivelStress :: Int,
    viajaSolo :: Bool,
    idioms :: [String]
 }deriving Show

type Excursion = Tutista -> Tutista
type Marea = String

--Ejemplo de turista

ana :: Tutista
ana = UnTurista{
    nivelCansancio = 0,
    nivelStress = 21,
    viajaSolo = False,
    idioms = ["Español"]
}

beto :: Tutista
beto = UnTurista{
    nivelCansancio = 15,
    nivelStress = 15,
    viajaSolo = True,
    idioms = ["Aleman"]
}

cathi :: Tutista
cathi = UnTurista{
    nivelCansancio = 15,
    nivelStress = 15,
    viajaSolo = True,
    idioms = ["Aleman", "Catalan"]
}


--------------------------Accesors------------------------------------------------
mapCansancio :: (Int -> Int) -> Tutista -> Tutista
mapCansancio f turista = turista {nivelCansancio = f . nivelCansancio $ turista}--compuesta

mapStress :: (Int -> Int) -> Tutista -> Tutista
mapStress f turista = turista {nivelStress = f .nivelStress $ turista}--compuesta

mapViajaSolo :: Bool -> Tutista -> Tutista
mapViajaSolo booleano turista = turista {viajaSolo = booleano}

mapIdioms :: ([String] -> [String]) -> Tutista -> Tutista
mapIdioms f turista = turista {idioms = f . idioms $ turista}
-----------------------------------------------------------------------------------------
irALaPlaya :: Excursion
irALaPlaya turista |estaSolo turista = mapCansancio (subtract 5) turista
            |otherwise=mapStress (subtract 1) turista

estaSolo :: Tutista -> Bool
estaSolo = viajaSolo

apreciarAlgunElementoDelPaisaje :: String->Excursion
apreciarAlgunElementoDelPaisaje elemento= mapStress (subtract(cantidadLetras elemento))

cantidadLetras :: String -> Int
cantidadLetras = length

salirAHablarIdioma :: String -> Excursion
salirAHablarIdioma idioma = mapViajaSolo (False).mapIdioms (++[idioma])

caminar :: Int -> Excursion
caminar minutos = mapCansancio(+(calcularIntensidad minutos)). mapStress(subtract(calcularIntensidad minutos))

calcularIntensidad :: Int -> Int
calcularIntensidad minutos = minutos `div` 4


paseoEnBarco :: Marea->Excursion
paseoEnBarco "fuerte" = mapStress(+6).mapCansancio(+10)
paseoEnBarco "tranquila" = salirAHablarIdioma "aleman".apreciarAlgunElementoDelPaisaje "mar".caminar 10
paseoEnBarco _ = id

--hacerExcursion :: Excursion->Tutista->Tutista
--hacerExcursion excursion turista = mapStress (subtract porcentajePostExcursion). excursion $ turista

porcentajePostExcursion :: Excursion -> Tutista -> Int
porcentajePostExcursion excursion turista = calcularPorcentaje 10 (nivelStress turista)

calcularPorcentaje :: Int -> Int -> Int
calcularPorcentaje porcentaje numero = (porcentaje * numero) `div` 100

--deltaExcursionSegun :: (Tutista -> Int) -> Excursion -> Tutista -> Tutista -> Int


--deltaSegun :: (a -> Int) -> a -> a -> Int
--deltaSegun f algo1 algo2 = f algo1 - f algo2












