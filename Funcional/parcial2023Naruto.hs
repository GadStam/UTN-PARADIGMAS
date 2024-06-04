module Parcial where
import Text.Show.Functions()

---------------------DATAS---------------------
data Ninja = UnNinja{
    nombre :: String, 
    herramientas :: [Herramienta],
    jutsus :: [Jutsu],
    rango :: Int
}deriving Show

type Herramienta = (String, Int)
type Jutsu = Mision -> Mision

data Mision = UnaMision {
    cantidadNinjas :: Int,
    rangoRecomendable :: Int,
    ninjasEnemigos :: [Ninja],
    recompensa :: Herramienta
}deriving Show

type Equipo = [Ninja]

---------------------------------------------------
-----------------ACCESSORS NINJA-------------------------
mapHerramientas :: ([Herramienta] -> [Herramienta]) -> Ninja -> Ninja
mapHerramientas f ninja = ninja {herramientas = f . herramientas $ ninja}

mapJutsus :: ([Jutsu] -> [Jutsu]) -> Ninja -> Ninja
mapJutsus f ninja = ninja {jutsus = f . jutsus $ ninja}

mapRango :: (Int -> Int) -> Ninja -> Ninja
mapRango f ninja = ninja {rango = f . rango $ ninja}
------------------------------------------------------------------------
-----------------ACCESSORS HERRAMIENTA-------------------------
mapNombre :: (String -> String) -> Herramienta -> Herramienta
mapNombre f (nombre, poder) = (f nombre, poder)

mapCantidad :: (Int -> Int) -> Herramienta -> Herramienta
mapCantidad f (nombre, poder) = (nombre, f poder)

nombreHerramienta :: Herramienta -> String
nombreHerramienta (nombre, _) = nombre

cantidadHerramienta :: Herramienta -> Int
cantidadHerramienta (_, cantidad) = cantidad
--------------------------------------------------------------
-----------------ACCESSORS MISION-------------------------
mapCantidadNinjas :: (Int -> Int) -> Mision -> Mision
mapCantidadNinjas f mision = mision {cantidadNinjas = f . cantidadNinjas $ mision}

mapNinjasEnemigos :: ([Ninja] -> [Ninja]) -> Mision -> Mision
mapNinjasEnemigos f mision = mision {ninjasEnemigos = f . ninjasEnemigos $ mision}

--------------Ejemplos de Herramientas--------------
bombasDeHumo :: Herramienta
bombasDeHumo = ("Bombas de Humo", 10)

kunai :: Herramienta
kunai = ("Kunai", 750)

shuriken :: Herramienta
shuriken = ("Shuriken", 5)

sellosExplosivos :: Herramienta
sellosExplosivos = ("Sellos Explosivos", 15)

boba :: Ninja
boba = UnNinja{
    nombre = "Boba",
    herramientas = [bombasDeHumo, kunai, shuriken],
    jutsus = [],
    rango = 1
}

mision1 :: Mision
mision1 = UnaMision{
    cantidadNinjas = 3,
    rangoRecomendable = 2,
    ninjasEnemigos = [boba,boba,boba],
    recompensa = bombasDeHumo
}
--------------------------------------------
--------------Parte A----------------------

obtenerHerramientas :: Herramienta -> Ninja -> Ninja
obtenerHerramientas herramienta ninja | sumatoriaMenorIgualA100 ninja herramienta = mapHerramientas (++ [herramienta]) ninja
                                      | otherwise = mapHerramientas(++[(nombreHerramienta herramienta, 100 - sumatoriaHerramientas ninja)]) ninja

sumatoriaMenorIgualA100 :: Ninja -> Herramienta -> Bool
sumatoriaMenorIgualA100 ninja herramienta = sumatoriaHerramientas ninja + cantidadHerramienta herramienta <= 100

sumatoriaHerramientas :: Ninja -> Int
sumatoriaHerramientas ninja = sum . map cantidadHerramienta . herramientas $ ninja
---------------------------------------------

usarHerramienta :: Ninja -> Herramienta -> Ninja
usarHerramienta ninja herramienta = mapHerramientas (filter (/= herramienta)) ninja
------------------------------------------------------------------------------------
-----------------Parte B----------------------
esDesafiante :: Equipo -> Mision -> Bool
esDesafiante equipo mision = any (menorRango mision) equipo && mayorA2Enemigos mision

mayorA2Enemigos :: Mision -> Bool
mayorA2Enemigos mision = (> 2) . length . ninjasEnemigos $ mision 

menorRango :: Mision -> Ninja -> Bool
menorRango mision ninja = rango ninja < rangoRecomendable mision
-----------------------------------------------
esCopada :: Mision -> Bool
esCopada mision = cumpleRecompensa . recompensa $ mision

cumpleRecompensa :: Herramienta -> Bool
cumpleRecompensa ("Bombas de Humo", 3) = True
cumpleRecompensa ("Kunai", 14) = True
cumpleRecompensa ("Shuriken", 5) = True
cumpleRecompensa _ = False
-------------------------------------------------
esFactible :: Equipo -> Mision -> Bool
esFactible equipo mision = (not . esDesafiante equipo $ mision) && (ninjasSuficientes equipo mision || herramioentasTotalesMayorA500 equipo)

ninjasSuficientes :: Equipo -> Mision -> Bool
ninjasSuficientes equipo mision = length equipo >= cantidadNinjas mision

herramioentasTotalesMayorA500 :: Equipo -> Bool
herramioentasTotalesMayorA500 equipo = sum (map(sumatoriaHerramientas) equipo) >= 500
-------------------------------------------------
fallarMision :: Equipo -> Mision -> Equipo
fallarMision equipo mision = map (disminuirRango) . filter (rangoSuperior mision) $ equipo

rangoSuperior :: Mision -> Ninja -> Bool
rangoSuperior mision ninja = rango ninja >= rangoRecomendable mision

disminuirRango :: Ninja -> Ninja
disminuirRango ninja = mapRango (subtract 2) ninja
-------------------------------------------------
cumplirMision :: Equipo -> Mision -> Equipo
cumplirMision equipo mision = map (obtenerHerramientas (recompensa mision)). map (aumentarRango) $ equipo

aumentarRango :: Ninja -> Ninja
aumentarRango ninja = mapRango (+1) ninja
-------------------------------------------------
clonesDeSombra :: Int -> Jutsu
clonesDeSombra clones mision = mapCantidadNinjas(\n -> max 0 (n - clones)) mision

fuerzaDeUnCentenar :: Mision -> Mision
fuerzaDeUnCentenar mision = mapNinjasEnemigos (filter (not.rangoMenor500)) mision

rangoMenor500 :: Ninja -> Bool
rangoMenor500 ninja = rango ninja < 500

-----------------------------------------------
usarJutsus :: Equipo -> Mision -> Mision
usarJutsus equipo mision = foldr ($) mision (jutsusTotales equipo)

jutsusTotales :: Equipo -> [Jutsu]
jutsusTotales equipo = concat . map (jutsus) $ equipo

condicionCumplimineto :: Equipo -> Mision -> Bool
condicionCumplimineto equipo mision = esFactible equipo . usarJutsus equipo $ mision

ejecutarMision :: Equipo -> Mision -> Equipo
ejecutarMision equipo mision | condicionCumplimineto equipo mision = cumplirMision equipo mision
                             | otherwise = fallarMision equipo mision

--------------------------------------------------
-----------------Parte C----------------------

granGuerraNinja :: Mision
granGuerraNinja = UnaMision{
    cantidadNinjas = 100000,
    rangoRecomendable = 100,
    ninjasEnemigos = ninjasZetsu,
    recompensa = ("Abanico de Madara Uchiha", 1)
}

ninjasZetsu :: [Ninja]
ninjasZetsu = map (crearZetsu) [1..]

crearZetsu :: Int -> Ninja
crearZetsu n = UnNinja{
    nombre = "Zetsu " ++ show n,
    herramientas = [],
    jutsus = [],
    rango = 600
}

{-
  Si la misión es copada, termina de ejecutar sin problemas y se cumple la misión.
  Si el equipo es finito y la misión no es desafiante porque el equipo no tiene un miembro no calificado, termina sin problemas y se cumple la misión.
  Si el equipo es finito, la misión no es desafiante porque el equipo no tiene un miembro no calificado, y no es factible porque el equipo no está bien preparado, termina sin problemas y se falla la misión.
  En caso contrario, no termina de evaluar, ya sea porque tiene que evaluar la totalidad de la lista de enemigos, o la totalidad del equipo.
-}