import Text.Show.Functions

{- Modelar a los animales: escribir un sinónimo de tipo y definir algunos ejemplos de animales como constantes. De un animal se sabe su coeficiente intelectual (un número), su especie (un string) y sus capacidades (strings). 
-}
data Animal = UnAnima{
    coeficienteIntelectual :: Int,
    especie :: String,
    capacidades :: [String]
}deriving Show

pinky :: Animal
pinky = UnAnima{
    coeficienteIntelectual = 101,
    especie = "raton",
    capacidades = ["hacer cacann", "hacer ojotann", "hacer cacann"]
}

-----------------------------------------------------------------
--Accesors
mapCoeficienteIntelectual :: (Int -> Int) -> Animal -> Animal
mapCoeficienteIntelectual funcion animal = animal{coeficienteIntelectual = funcion . coeficienteIntelectual $ animal}

mapEspecie :: (String -> String) -> Animal -> Animal
mapEspecie funcion animal = animal{especie = funcion . especie $ animal}

mapCapacidades :: ([String] -> [String]) -> Animal -> Animal
mapCapacidades funcion animal = animal{capacidades = funcion . capacidades $ animal}
------------------------------------------------------------------
--punto 2

inteligenciaSuperior :: Int -> Animal -> Animal
inteligenciaSuperior n = mapCoeficienteIntelectual (+n)

pinkificar :: Animal -> Animal
pinkificar = mapCapacidades (const [])

superpoderes :: Animal -> Animal
superpoderes unAnimal | esAnimal (especie unAnimal) = mapCapacidades (++["no tenerle miedoa los ratones"]) unAnimal
                        | esRaton unAnimal = mapCapacidades (++["hablar"]) unAnimal
                        | otherwise = unAnimal

esRaton :: Animal -> Bool
esRaton unAnimal = esAnimal(especie unAnimal) && coeficienteIntelectual unAnimal > 100


esAnimal :: String -> Bool
esAnimal "elefante" = True
esAnimal "raton" = True
esAnimal _ = False
---------------------------------------------------------------------
--punto 3
antropomorfico :: Animal -> Bool
antropomorfico unAnimal = coeficienteIntelectual unAnimal > 60 && (elem "hablar" . capacidades $ unAnimal)

noTanCuerdo :: Animal -> Bool
noTanCuerdo unAnimal = (length . filter pinkiesco $ capacidades unAnimal) > 2

pinkiesco :: String -> Bool
pinkiesco capacidad = take 5 capacidad == "hacer" && palabraPinkiestaca capacidad

palabraPinkiestaca :: String -> Bool
palabraPinkiestaca capacidad = (length . tomarSegundaPalabra $ capacidad) <= 4 && any esVocal (tomarSegundaPalabra capacidad)

tomarSegundaPalabra :: String -> String
tomarSegundaPalabra capacidad = drop 6 capacidad 

esVocal :: Char -> Bool
esVocal letra = elem letra "aeiou"

--------------------------------------------------------------
-- punto 4
type Experimento = ([Animal -> Animal],Criterio)

type Criterio = Animal -> Bool

experimentoExitoso :: Experimento -> Animal -> Bool
experimentoExitoso (listaDeFunciones,criterio) animal = criterio . aplicarFunciones listaDeFunciones $ animal

aplicarFunciones :: [Animal -> Animal] -> Animal -> Animal
aplicarFunciones listaDeFunciones animal = foldr ($) animal listaDeFunciones

animalDePrueba :: Animal
animalDePrueba = UnAnima{
    coeficienteIntelectual = 17,
    especie = "raton",
    capacidades = ["destruenglonir el mundo", "hacer planes desalmados"]
}

experimentoDePrueba :: Experimento
experimentoDePrueba = ([inteligenciaSuperior 10],antropomorfico)
----------------------------------------------------------------
-- punto 5

listaCoefIntelectuales :: [Animal] -> [String] -> Experimento -> [Int]
listaCoefIntelectuales animales listaCapacidades experimento = reporte animales listaCapacidades experimento coeficienteIntelectual

listaEspecies :: [Animal] -> [String] -> Experimento -> [String]
listaEspecies animales listaCapacidades experimento = reporte animales listaCapacidades experimento especie

listaCantidadCapacidades :: [Animal] -> [String] -> Experimento -> [Int]
listaCantidadCapacidades animales listaCapacidades experimento = reporte animales listaCapacidades experimento (length . capacidades)


reporte :: [Animal] -> [String] -> Experimento -> (Animal -> a) -> [a]
reporte animales listaCapacidades (listaDeFunciones,_) f = map f . filter (tieneCapacidades listaCapacidades) $ aplicarFuncionesAAnimales animales listaDeFunciones

tieneCapacidades :: [String] -> Animal -> Bool
tieneCapacidades listaCapacidades animal = any (flip elem listaCapacidades) (capacidades animal)
    
aplicarFuncionesAAnimales :: [Animal] -> [Animal->Animal] -> [Animal]    
aplicarFuncionesAAnimales animales listaDeFunciones = map (aplicarFunciones listaDeFunciones) animales

------------------------------------------------------------------------------
-- punto 6

nuevoAnimal :: Animal
nuevoAnimal = UnAnima{
    coeficienteIntelectual = 100,
    especie = "elefante",
    capacidades = capacidadesInfinitas
}

capacidadesInfinitas :: [String]
capacidadesInfinitas = map (crearCapacidad) [1..]

crearCapacidad :: Int -> String
crearCapacidad n = "capacidad" ++ show n

------------------------------------------------------------------------------
-- punto 7
{-Generar todas las posibles palabras pinkiescas. Pistas:
generateWordsUpTo, que toma una longitud y genera una lista con todas las posibles palabras de hasta la longitud dada.
generateWords que toma una longitud y genera una lista de palabras donde todas tienen exactamente la longitud dada. 
-}
-- NO SUPE
