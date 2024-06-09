import Text.Show.Functions
import Data.Char (toUpper, isUpper)







data Barbaro = UnBarbaro{
    nombre :: String,
    fuerza :: Int,
    habilidades :: [String],
    objetos :: [Objeto]
}deriving Show

type Objeto = Barbaro -> Barbaro

dave :: Barbaro
dave = UnBarbaro{
    nombre = "Dave",
    fuerza = 100,
    habilidades = ["tejer", "escribir"],
    objetos = []
}

-------------------------Accesors--------
mapNombre :: (String -> String) -> Barbaro -> Barbaro
mapNombre f unBarbaro = unBarbaro {nombre = f.nombre $ unBarbaro}

mapFuerza :: (Int -> Int) -> Barbaro -> Barbaro
mapFuerza f unBarbaro = unBarbaro {fuerza = f.fuerza $ unBarbaro}

mapHabilidades :: ([String] -> [String]) -> Barbaro -> Barbaro
mapHabilidades f unBarbaro = unBarbaro {habilidades = f.habilidades $ unBarbaro}

mapObjetos :: ([Objeto] -> [Objeto]) -> Barbaro -> Barbaro
mapObjetos f unBarbaro = unBarbaro {objetos = f.objetos $ unBarbaro}
-------------------------------------------
---------------------------------------------------------------------
--Punto 1
espada :: Int -> Objeto
espada peso = mapFuerza (+2*peso)

amuletoMistico :: String->Objeto
amuletoMistico habilidad = mapHabilidades (++[habilidad])

varitasDefectuosas :: Objeto
varitasDefectuosas = mapHabilidades(const ["hacer magia"])

ardilla :: Objeto
ardilla = id

cuerda :: Objeto->Objeto->Objeto
cuerda objeto1 objeto2 = objeto1.objeto2
----------------
--Punto 2
megafono :: Objeto
megafono unBarbaro= mapHabilidades(concatenar . pasarAMayusq) unBarbaro
    
pasarAMayusq :: [String] -> [String]
pasarAMayusq habilidades = map (map toUpper) habilidades

concatenar :: [String] -> [String]
concatenar unasHabilidades = [concat unasHabilidades]

megafonoBarbarico :: Objeto
megafonoBarbarico = cuerda ardilla megafono
--------------
--Punto 3
type Aventura = [Evento]
type Evento = Barbaro->Bool

invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes unBarbaro = elem "Escribir Poesía Atroz" (habilidades unBarbaro)

cremalleraDelTiempo :: Evento
cremalleraDelTiempo unBarbaro = noTienePulgares . nombre $ unBarbaro

noTienePulgares :: String -> Bool
noTienePulgares "Faffy" = True
noTienePulgares "Astro" = True
noTienePulgares _ = False

saqueo :: Evento
saqueo unBarbaro = (>80) (fuerza unBarbaro) && elem "robar" (habilidades unBarbaro)

gritoDeGuerra :: Evento
gritoDeGuerra unBarbaro = poderGritoGuerra unBarbaro >= cantidadLetrasHabilidades unBarbaro

poderGritoGuerra :: Barbaro -> Int
poderGritoGuerra unBarbaro = (4*).length.objetos $ unBarbaro

cantidadLetrasHabilidades :: Barbaro -> Int
cantidadLetrasHabilidades = sum . map length . habilidades

caligrafia :: Evento
caligrafia barbaro = habilidadesTieneMasDe3Vocales barbaro && habilidadesComienzanConMayuscula barbaro

habilidadesTieneMasDe3Vocales :: Barbaro->Bool
habilidadesTieneMasDe3Vocales = any (mayorA3Vocales).habilidades

mayorA3Vocales :: String->Bool
mayorA3Vocales = (>3).length.filter esVocal

esVocal :: Char->Bool
esVocal letra = elem letra "aeiouAEIOU"

habilidadesComienzanConMayuscula :: Barbaro->Bool
habilidadesComienzanConMayuscula = all comienzaConMayuscula.habilidades

comienzaConMayuscula :: String->Bool
comienzaConMayuscula = isUpper.head

ritualDeFechorias :: Aventura -> Evento
ritualDeFechorias eventos barbaro = any (\evento -> evento barbaro) eventos

sobrevivientes :: [Barbaro]->Aventura-> [Barbaro]
sobrevivientes barbaros eventos = filter (\barbaro -> pasarPruebas barbaro eventos) barbaros
    
pasarPruebas :: Barbaro->Aventura-> Bool    
pasarPruebas barbaro eventos = all (\evento -> evento barbaro) eventos

------------------------------
--Punto 4
sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (cabeza:cola) | elem cabeza cola = sinRepetidos cola
                          | otherwise = cabeza : sinRepetidos cola

descendiente :: Barbaro->Barbaro
descendiente = utilizarObjetos . mapNombre (++ "*"). mapHabilidades sinRepetidos

utilizarObjetos :: Barbaro->Barbaro
utilizarObjetos barbaro = foldr ($) barbaro (objetos barbaro)

descendientes :: Barbaro->[Barbaro]
descendientes barbaro = iterate descendiente barbaro




