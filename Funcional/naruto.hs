
import Text.Show.Functions


data Ninja = UnNinja{
    nombre :: String,
    herramientas :: [Herramienta],
    jutsus :: [Jutsu],
    rango :: Int
}deriving Show

type Herramienta = (String, Int)

type Jutsu = Mision -> Mision
-------------------------------------
-----Ejemplos--------------
mam :: Ninja
mam = UnNinja{
    nombre = "Mam",
    herramientas = [("Shuriken", 100), ("Kunai", 5)],
    jutsus = [],
    rango = 1
}

----------------Accesors Ninja----------------
mapNombre :: (String -> String) -> Ninja -> Ninja
mapNombre f ninja = ninja {nombre = f . nombre $ ninja}

mapHerramientas :: ([Herramienta] -> [Herramienta]) -> Ninja -> Ninja
mapHerramientas f ninja = ninja {herramientas = f . herramientas $ ninja}

mapJutsus :: ([Jutsu] -> [Jutsu]) -> Ninja -> Ninja
mapJutsus f ninja = ninja {jutsus = f . jutsus $ ninja}

mapRango :: (Int -> Int) -> Ninja -> Ninja
mapRango f ninja = ninja {rango = max 0 (f . rango $ ninja)}
----------------------------------------------
----------------Accesors Herramienta----------------
mapNombreHerramienta :: (String -> String) -> Herramienta -> Herramienta
mapNombreHerramienta f (nombre, cantidad) = (f nombre, cantidad)

mapCantidadHerramienta :: (Int -> Int) -> Herramienta -> Herramienta
mapCantidadHerramienta f (nombre, cantidad) = (nombre, f cantidad)

nombreHerramienta :: Herramienta -> String
nombreHerramienta (nombre, _) = nombre

cantidadHerramienta :: Herramienta -> Int
cantidadHerramienta (_, cantidad) = cantidad


------------------------------------------------------
-- Parte A

obtenerHerramienta :: Herramienta -> Ninja -> Ninja
obtenerHerramienta (nombre,cantidad) ninja | sumaHerramientas ninja + cantidad <= 100 = mapHerramientas (++[(nombre,cantidad)]) ninja
                                      | otherwise = mapHerramientas (++[(nombre, min 100 (sumaHerramientas ninja + cantidad))]) ninja

sumaHerramientas :: Ninja -> Int
sumaHerramientas = sum . map cantidadHerramienta . herramientas

--usarHerramienta :: Herramienta -> Ninja -> Ninja
--usarHerramienta (nombre, cantidad) ninja = mapHerramientas (filter ((/= nombre) . nombreHerramienta)) ninja

usarHerramienta :: Herramienta -> Ninja -> Ninja
usarHerramienta unaHerramienta = mapHerramientas (filter (/= unaHerramienta))

--------------
-- Parte B
data Mision = UnaMision{
    cantidadNinjas :: Int,
    rangoRecomendable :: Int,
    ninjasEnemigos :: [Ninja],
    recompensa :: Herramienta
}deriving Show

mapCantidadNinjas :: (Int -> Int) -> Mision -> Mision
mapCantidadNinjas f mision = mision {cantidadNinjas = max 1 (f . cantidadNinjas $ mision)}

mapNinjasEnemigos :: ([Ninja] -> [Ninja]) -> Mision -> Mision
mapNinjasEnemigos f mision = mision {ninjasEnemigos = f . ninjasEnemigos $ mision}

mision1 :: Mision
mision1 = UnaMision{
    cantidadNinjas = 3,
    rangoRecomendable = 10,
    ninjasEnemigos = [mam,mam,mam],
    recompensa = ("Shuriken", 10)
}

type Equipo = [Ninja]

----------------------------

esDesafiante :: Equipo -> Mision -> Bool
esDesafiante equipo mision = menorRango equipo mision && ((>2). length . ninjasEnemigos $ mision)

menorRango :: Equipo -> Mision -> Bool
menorRango equipo mision = any ((< rangoRecomendable mision) . rango) equipo

esCopada :: Mision -> Bool
esCopada = esLaRecompensa . recompensa

esLaRecompensa :: Herramienta -> Bool
esLaRecompensa ("bomba de humo",3) = True
esLaRecompensa ("Shuriken",5) = True
esLaRecompensa ("Kunais",14) = True
esLaRecompensa _ = False

esFactible :: Equipo -> Mision -> Bool
esFactible equipo mision = not (esDesafiante equipo mision) && (ninjasSuficientes equipo mision || sumaTotal equipo > 500)

ninjasSuficientes :: Equipo -> Mision -> Bool
ninjasSuficientes equipo mision = length equipo >= cantidadNinjas mision

sumaTotal :: Equipo -> Int
sumaTotal = sum . map sumaHerramientas

--------------

fallarMision :: Equipo -> Mision -> Equipo
fallarMision equipo = disminuirRango . equipoRestante equipo

equipoRestante :: Equipo -> Mision -> Equipo
equipoRestante equipo mision = filter ((> rangoRecomendable mision).rango) equipo

disminuirRango :: Equipo -> Equipo
disminuirRango = map (mapRango (subtract 2))

cumplirMision :: Equipo -> Mision -> Equipo
cumplirMision equipo mision = obtenerRecompensa mision . aumentarRango $ equipo

aumentarRango :: Equipo -> Equipo
aumentarRango = map (mapRango (+1))

obtenerRecompensa :: Mision -> Equipo -> Equipo
obtenerRecompensa mision = map (obtenerHerramienta (recompensa mision))

---Jutsus---
clonesDeSombbra :: Int -> Jutsu
clonesDeSombbra clones = mapCantidadNinjas (subtract clones)

fuerzaDeUnCentenar :: Jutsu
fuerzaDeUnCentenar = mapNinjasEnemigos (filter rangoMenor500)

rangoMenor500 :: Ninja -> Bool
rangoMenor500 = (<500) . rango

usarJutsus :: Equipo -> Mision -> Mision
usarJutsus equipo mision = foldr ($) mision (jutsusTotales equipo)

jutsusTotales :: Equipo -> [Jutsu]
jutsusTotales = concat . map jutsus

condicionCumplimiento :: Equipo -> Mision -> Bool
condicionCumplimiento equipo = esFactible equipo . usarJutsus equipo


ejecucionMision :: Equipo -> Mision -> Equipo
ejecucionMision equipo mision | condicionCumplimiento equipo mision = cumplirMision equipo mision
                             | otherwise = fallarMision equipo mision














