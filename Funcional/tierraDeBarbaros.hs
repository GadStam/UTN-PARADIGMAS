import Text.Show.Functions
import Data.Char (toUpper, isUpper)
import Distribution.Simple.Program.Ar (createArLibArchive)


data Barbaro = UnBarbaro {
    nombre :: Nombre,
    fuerza :: Fuerza,
    habilidades :: Habilidades,
    objetos :: Objetos
} deriving Show

type Nombre = String
type Fuerza = Int
type Habilidad = String
type Habilidades = [Habilidad]
type Objetos = [Objeto]
type Objeto = Barbaro -> Barbaro
type Peso = Int

-- -------------------------------------------------- BARBAROS ------------------------------------------------------------------
dave :: Barbaro
dave = UnBarbaro {
    nombre = "Dave",
    fuerza = 100,
    habilidades = ["tejer","escribirPoesia", "Escribir Poesía Atroz", "robar"],
    objetos = [ardilla, varitasDefectuosas]
}

daffy :: Barbaro
daffy = UnBarbaro {
    nombre = "Faffssy",
    fuerza = 10,
    habilidades = ["tejer","escribirPoesia", "robar"],
    objetos = [ardilla, varitasDefectuosas]
}
--------------------------------------------------Accesors-----------------------------------------------------------------
mapNombre :: (String->String)->Barbaro->Barbaro
mapNombre funcion barbaro = barbaro {nombre = funcion .nombre $ barbaro}

mapFuerza :: (Int->Int)->Barbaro->Barbaro
mapFuerza funcion barbaro = barbaro {fuerza = funcion .fuerza $ barbaro}

mapHabilidades :: ([String]->[String])->Barbaro->Barbaro
mapHabilidades funcion barbaro = barbaro {habilidades = funcion .habilidades $ barbaro}

mapObjetos :: ([Objeto]->[Objeto])->Barbaro->Barbaro
mapObjetos funcion barbaro = barbaro {objetos = funcion . objetos $ barbaro}

--------------------------------------------------------------------------------------------------------------------------

-- -------------------------------------------------- PUNTO 1--------------------------------------------------------------
espada :: Peso->Objeto
espada peso= mapFuerza (+2*peso)

amuletosMisticos:: Habilidad->Objeto
amuletosMisticos habilidad = mapHabilidades (++[habilidad])

varitasDefectuosas:: Objeto
varitasDefectuosas barbaro = (mapHabilidades (++ ["hacer magia"]) . eliminarObjetos) barbaro




eliminarObjetos :: Objeto
eliminarObjetos barbaro = barbaro {objetos = [varitasDefectuosas]}

ardilla:: Objeto
ardilla barbaro = barbaro

cuerda :: Objeto->Objeto->Objeto
cuerda objeto1 objeto2 = objeto1 . objeto2

------------------------------------------------------------------------------------------------------



-- -------------------------------------------------- PUNTO 2 -----------------------------------------------------------------

megafono :: Objeto
megafono barbaro = mapHabilidades (ponerEnMayuscula.concatenar) barbaro


concatenar :: [String]->[String]
concatenar unasHabilidades = [concat unasHabilidades]

ponerEnMayuscula :: [String]->[String]
ponerEnMayuscula unasHabilidades = map (map toUpper) unasHabilidades


-------------------------AVENTURAS------------------------------------------------------------------------------------------
type Aventura = [Evento]
type Evento = Barbaro->Bool

invasionDeSuciosDuendes:: Evento
invasionDeSuciosDuendes barbaro = tieneHabilidad "Escribir Poesía Atroz" barbaro

cremalleraDelTiempo:: Evento
cremalleraDelTiempo barbaro = not . tienePulgares $ (nombre barbaro)


tienePulgares :: Nombre->Bool
tienePulgares "Faffy" = False
tienePulgares "Astro" = False
tienePulgares _ = True

ritualDeFechorias :: Aventura -> Evento
ritualDeFechorias eventos barbaro = any (\evento -> evento barbaro) eventos

saqueo :: Evento
saqueo barbaro = tieneHabilidad "robar" barbaro && tieneFuerza barbaro

tieneHabilidad :: Habilidad->Barbaro->Bool
tieneHabilidad habilidad barbaro = elem habilidad (habilidades barbaro)

tieneFuerza :: Barbaro->Bool
tieneFuerza barbaro = fuerza barbaro > 80



gritoDeGuerra :: Evento
gritoDeGuerra barbaro = poderGritoGuerra barbaro >= cantidadLetrasHabilidades barbaro

poderGritoGuerra :: Barbaro->Int
poderGritoGuerra = (4*).length.objetos

cantidadLetrasHabilidades :: Barbaro->Int
cantidadLetrasHabilidades = sum.map length.habilidades 

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

sobrevivientes :: [Barbaro]->Aventura-> [Barbaro]
sobrevivientes barbaros unaAventura = filter(\barbaro -> pasaUnaAventura all barbaro unaAventura) barbaros



pasaUnaAventura criterio barbaro unaAventura = criterio (\evento -> evento barbaro) unaAventura



-------------------------------------Punto 4------------------------------------------
sinRepetidos :: (Eq a)=>[a]->[a]----recursividad
sinRepetidos [] = []
sinRepetidos (cabeza:cola)
    |elem cabeza cola = cola
    |otherwise = (cabeza:cola)


descendiente :: Barbaro->Barbaro
descendiente = utilizarObjetos . mapNombre (++ "*"). mapHabilidades sinRepetidos

utilizarObjetos :: Barbaro->Barbaro
utilizarObjetos barbaro = foldr ($) barbaro (objetos barbaro)

descendientes :: Barbaro->[Barbaro]
descendientes barbaro = iterate descendiente barbaro


-------No, los objetos al ser funciones no son comparables, pero en cambio los nombres si lo son, por lo que se puede hacer una comparacion entre los nombres de los barbaros.----------------










