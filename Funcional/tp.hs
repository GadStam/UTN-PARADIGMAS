import Text.Show.Functions


data Ciudad = UnaCiudad {
    nombre :: Nombre,
    anioDeFundacion :: AnioDeFundacion,
    atracciones :: Atracciones,
    costoDeVida :: CostoDeVida
} deriving Show

type Nombre = String
type AnioDeFundacion = Int
type Atraccion = String
type Atracciones = [Atraccion]
type CostoDeVida = Int

-------------------------------------------------- CIUDADES ------------------------------------------------------------------

baradero :: Ciudad
baradero = UnaCiudad {
  nombre = "Baradero", 
  anioDeFundacion = 1615, 
  atracciones = ["Parque del Este", "Museo Alejandro Barbich"],
  costoDeVida = 150
}

nullish :: Ciudad
nullish = UnaCiudad {
  nombre = "Nullish", 
  anioDeFundacion = 1800, 
  atracciones = [], 
  costoDeVida = 140
}

caletaOlivia :: Ciudad
caletaOlivia = UnaCiudad {
  nombre = "Caleta Olivia", 
  anioDeFundacion = 1901, 
  atracciones = [ "El Gorosito", "Faro Costanera"],
  costoDeVida = 120
}

maipu :: Ciudad
maipu = UnaCiudad {
  nombre = "Maipu", 
  anioDeFundacion = 1878,
  atracciones = ["Fortin Kakel"],
  costoDeVida = 115
  }

azul :: Ciudad
azul = UnaCiudad{
  nombre = "Azul", 
  anioDeFundacion = 1832, 
  atracciones = [ "Teatro espanol", "Parque Municipal Sarmiento", "Costanera Cacique Catriel"],
  costoDeVida = 190
}

-------------------------------------------------- PUNTO 1 -----------------------------------------------------------------

noTieneAtracciones :: Ciudad -> Bool
noTieneAtracciones unaCiudad = null (atracciones unaCiudad)

valorDeCiudad :: Ciudad -> Int
valorDeCiudad unaCiudad 
  | esAntigua unaCiudad = 5 * (1800 - anioDeFundacion unaCiudad) 
  | otherwise = 3 * costoDeVida unaCiudad

esAntigua :: Ciudad -> Bool
esAntigua unaCiudad = anioDeFundacion unaCiudad < 1800

-------------------------------------------------- PUNTO 2 -----------------------------------------------------------------

------ Alguna Atraccion Copada
algunaAtraccionCopada :: Ciudad -> Bool
algunaAtraccionCopada unaCiudad = any esVocal.head $ (atracciones unaCiudad) 

esVocal :: Char -> Bool
esVocal unCaracter = unCaracter `elem` "aeiouAEIOU"

------ Ciudad Sobria 
esCiudadSobria :: Ciudad->Int->Bool
esCiudadSobria unaCiudad cantidadDeLetras = not (null (atracciones unaCiudad)) && all ((>cantidadDeLetras).length) (atracciones unaCiudad)

------ Tiene Nombre Raro
tieneNombreRaro :: Ciudad -> Bool
tieneNombreRaro unaCiudad = (<5).length $ nombre unaCiudad

-------------------------------------------------- PUNTO 3 -----------------------------------------------------------------

type Evento = Ciudad -> Ciudad

modificarCostoDeVida :: (Int ->  Int) -> Ciudad -> Ciudad
modificarCostoDeVida unaFuncion unaCiudad =  unaCiudad {costoDeVida = unaFuncion.costoDeVida $ unaCiudad}

modificarNombre :: (String->String) -> Ciudad -> Ciudad
modificarNombre unaFuncion unaCiudad = unaCiudad {nombre = unaFuncion.nombre $ unaCiudad}

-- modificar porcentualmente 
calcularCostoDeVidaPorcentual:: (Int -> Int -> Int) -> Int -> Int -> Int 
calcularCostoDeVidaPorcentual unaFuncion porcentaje costoDeVida =  (unaFuncion (costoDeVida * porcentaje  `div` 100)) $ costoDeVida

modificarCostoDeVidaPorcentual :: (Int->Int->Int) -> Int -> Ciudad -> Ciudad
modificarCostoDeVidaPorcentual unaFuncion unPorcentaje unaCiudad = modificarCostoDeVida (calcularCostoDeVidaPorcentual unaFuncion unPorcentaje) unaCiudad

------ Sumar una nueva atraccion
sumarUnaNuevaAtraccion :: Atraccion -> Evento
sumarUnaNuevaAtraccion unaAtraccion unaCiudad = (modificarCostoDeVidaPorcentual (+) 20).(modificarAtraccion ([unaAtraccion] ++)) $ unaCiudad

modificarAtraccion :: (Atracciones->Atracciones) -> Ciudad -> Ciudad
modificarAtraccion unaFuncion unaCiudad = unaCiudad {atracciones = unaFuncion.atracciones $ unaCiudad}

------ Crisis 
crisis :: Evento
crisis unaCiudad 
  | noTieneAtracciones unaCiudad =  modificarCostoDeVidaPorcentual subtract 10 unaCiudad
  | otherwise = (modificarCostoDeVidaPorcentual subtract 10).(modificarAtraccion (drop 1)) $ unaCiudad 

------ Remodelación
remodelacion :: Int -> Evento
remodelacion unPorcentaje unaCiudad =  (modificarCostoDeVidaPorcentual (+) unPorcentaje).modificarNombre ("New " ++) $ unaCiudad

---- Reevaluación 
reevaluacion :: Int -> Evento
reevaluacion cantidadDeLetras unaCiudad 
  | esCiudadSobria unaCiudad cantidadDeLetras = modificarCostoDeVidaPorcentual (+) 10 unaCiudad
  | otherwise = modificarCostoDeVida (subtract 3) unaCiudad 

-------------------------------------------------- PUNTO 4 -----------------------------------------------------------------

{- El comando sería el siguiente: sumarUnaNuevaAtraccion *atraccion*.remodelacion *porcentaje*. crisis. reevaluacion *numeroDeLetras* $ baradero
POR EJEMPLO: le queremos agregar a la ciudad Baradero un parque de diversiones, remoderarla con porcentaje 50%, causarle una crisis y reevaluarla tomando 5 letras.
el comando sería sumarUnaNuevaAtraccion "Parque de diversiones".remodelacion 50. crisis. reevaluacion 5 $ baradero -} 

----------------------------------------------Entrega 2 ----------------------------------------------------------------------

data Anio = UnAnio {
  numero :: Int,
  eventos :: [Evento]
} deriving Show

anio2022 :: Anio
anio2022 = UnAnio {
  numero = 2022,
  eventos = [crisis, reevaluacion 5, reevaluacion 7]
}

anio2015 :: Anio
anio2015 = UnAnio {
  numero = 2015,
  eventos = []
}

anioParaRecordar :: Anio->Ciudad->Ciudad
anioParaRecordar unAnio unaCiudad = foldr ($) unaCiudad (eventos unAnio)

type Criterio = Ciudad->Int

algoMejor :: Ciudad -> Criterio -> Evento -> Bool
algoMejor unaCiudad unCriterio unEvento = unCriterio (unEvento unaCiudad) > unCriterio unaCiudad

filtrarEventosQueSuban :: Ciudad -> Criterio -> [Evento] -> [Evento]
filtrarEventosQueSuban unaCiudad costoDeVida listaDeEventos = filter (algoMejor unaCiudad costoDeVida) listaDeEventos

filtrarEventosQueBaje :: Ciudad -> Criterio -> [Evento] -> [Evento]
filtrarEventosQueBaje unaCiudad costoDeVida listaDeEventos = filter (not. algoMejor unaCiudad costoDeVida) listaDeEventos

costoDeVidaQueSuba :: Anio -> Ciudad -> Ciudad
costoDeVidaQueSuba unAnio unaCiudad = foldr ($) unaCiudad (filtrarEventosQueSuban unaCiudad costoDeVida (eventos unAnio))

costoDeVidaQueBaje :: Anio -> Ciudad -> Ciudad
costoDeVidaQueBaje unAnio unaCiudad = foldr ($) unaCiudad (filtrarEventosQueBaje unaCiudad costoDeVida (eventos unAnio))

---------------------------------------------------------------------------------------------------------------------------
eventosOrdenados :: Anio -> Ciudad -> Bool
eventosOrdenados unAnio unaCiudad = serieDeEventosOrdenados (eventos unAnio) unaCiudad

serieDeEventosOrdenados :: [Evento] -> Ciudad -> Bool
serieDeEventosOrdenados [unEvento] unaCiudad = costoDeVida (unEvento unaCiudad) > costoDeVida unaCiudad
serieDeEventosOrdenados (cabeza:cola) unaCiudad | costoDeVida (cabeza unaCiudad) > costoDeVida unaCiudad = serieDeEventosOrdenados cola (cabeza unaCiudad)
                                                | otherwise = False 







