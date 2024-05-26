import Text.Show.Functions

data Ciudad = UnaCiudad{
    nombre :: Nombre,
    añoFundacion :: Año,
    atracciones :: [Atraccion],
    costoDeVida :: Costo
}deriving Show

type Nombre = String
type Año = Int
type Atraccion = String
type Costo = Int

baradero :: Ciudad
baradero = UnaCiudad{
    nombre = "Baradero",
    añoFundacion = 1615,
    atracciones = ["Parque del Este","Museo Alejandro Barbich"],
    costoDeVida = 150
}

nullish :: Ciudad
nullish = UnaCiudad{
    nombre = "Nullish",
    añoFundacion = 1800,
    atracciones = [],
    costoDeVida = 140
}

caletaOlivia :: Ciudad
caletaOlivia = UnaCiudad{
    nombre = "Caleta Olivia",
    añoFundacion = 1901,
    atracciones = ["El Gorosito","Faro Costanera"],
    costoDeVida = 120
}
-----------------------------------------Punto 1------------------------------------------
valorDeUnaCiudad :: Ciudad -> Int
valorDeUnaCiudad ciudad | añoFundacion ciudad < 1800 = 5 * (1800- añoFundacion ciudad)
                        | null(atracciones ciudad) = 2* costoDeVida ciudad
                        | otherwise = 3* costoDeVida ciudad

---------------------------------------------------------------------------------------------

-----------------------------------------Punto 2------------------------------------------
isVowel :: Char -> Bool
isVowel character = character `elem` "aeiouAEIOU"

atraccionCopada :: Ciudad -> Bool
atraccionCopada ciudad = any isVowel . map (head) $ atracciones ciudad


esCiudadSobria :: Ciudad -> Int -> Bool
esCiudadSobria ciudad cantidadLetras = all (>cantidadLetras) atracciones ciudad
-------------------------------------------------------------------------------------------

-----------------------------------------Punto 3------------------------------------------
