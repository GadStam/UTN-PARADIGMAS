import Text.Show.Functions



data Participante = UnParticipante{
    nombre :: String,
    trucos :: [Truco],
    especialidad :: Plato
}deriving Show

data Plato = UnPlato{
    dificultad :: Int,
    componentes :: [Componente]
}deriving Show

type Truco = Plato -> Plato
type Componente = (String, Int)

fideos :: Plato
fideos = UnPlato{
    dificultad = 10,
    componentes = [("fideos", 100), ("agua", 100), ("sal", 1),("arroz", 3), ("azucar", 3), ("mariscos", 3)]
}

--------------------Accesors----------------
mapTrucos :: ([Truco] -> [Truco]) -> Participante -> Participante
mapTrucos f unParticipante = unParticipante{trucos = f.trucos $ unParticipante}

mapEspecialidad :: (Plato -> Plato) -> Participante -> Participante
mapEspecialidad f unParticipante = unParticipante{especialidad = f.especialidad $ unParticipante}

---------------------------------------------------
----------------Accesors Plato---------------------
mapDificultad :: (Int -> Int) -> Plato -> Plato
mapDificultad f unPlato = unPlato{dificultad = f.dificultad $ unPlato}

mapComponentes :: ([Componente] -> [Componente]) -> Plato -> Plato
mapComponentes f unPlato = unPlato{componentes = f.componentes $ unPlato}

mapIngrediente :: (String -> String) -> Componente -> Componente
mapIngrediente f (ingrediente, cantidad) = (f ingrediente, cantidad)

mapCantidad :: (Int -> Int) -> Componente -> Componente
mapCantidad f (ingrediente, cantidad) = (ingrediente, f cantidad)

ingrediente :: Componente -> String
ingrediente (ingrediente, _) = ingrediente

cantidad :: Componente -> Int
cantidad (_, cantidad) = cantidad
--------------------------------------------------
--Punto A
endulzar :: Int->Truco
endulzar gramos = mapComponentes (++[("azucar", gramos)])

salar :: Int->Truco
salar gramos = mapComponentes (++[("sal", gramos)])

darSabor :: Int -> Int -> Truco
darSabor gramosSal gramosAzucar = salar gramosSal . endulzar gramosAzucar

duplicarPorcion :: Truco
duplicarPorcion unPlato = mapComponentes(map duplicarCantidad) unPlato

duplicarCantidad :: Componente -> Componente
duplicarCantidad = mapCantidad (*2)

simplificar :: Truco
simplificar unPlato | esBardo unPlato = quitarComponentes . bajarDificultad $ unPlato
                    | otherwise = unPlato

esBardo :: Plato -> Bool
esBardo unPlato = (dificultad unPlato > 7) && ((> 5) . length . componentes $ unPlato)

bajarDificultad :: Truco
bajarDificultad = mapDificultad (const 5)

quitarComponentes :: Truco
quitarComponentes = mapComponentes (filter ((>10).cantidad))

esVegano :: Plato -> Bool
esVegano = all (aptoVegano . ingrediente) . componentes

aptoVegano :: String -> Bool
aptoVegano "carne" = False
aptoVegano "huevos" = False
aptoVegano "leche" = False
aptoVegano _ = True

esSinTacc :: Plato -> Bool
esSinTacc = any (aptoSinTacc . ingrediente) . componentes

aptoSinTacc :: String -> Bool
aptoSinTacc "harina" = True
aptoSinTacc _ = False

esComplejo :: Plato -> Bool
esComplejo unPlato = esBardo unPlato

noAptoHipertension :: Plato -> Bool
noAptoHipertension = all ((>2).cantidad) . cantidadSal

cantidadSal :: Plato -> [Componente]
cantidadSal = filter ((=="sal").ingrediente) . componentes

-----------------------------------------------------------------
--Punto B

pepeRonccino :: Participante
pepeRonccino = UnParticipante{
    nombre = "Pepe Ronccino",
    trucos = [darSabor 2 5, simplificar, duplicarPorcion],
    especialidad = UnPlato{
        dificultad = 10,
        componentes = [("fideos", 100), ("agua", 100), ("sal", 1),("arroz", 3), ("azucar", 3), ("mariscos", 3)]
    }
}

------------------------
--Punto C
cocinar :: Participante -> Plato
cocinar unParticipante = foldr ($) (especialidad unParticipante) (trucos unParticipante)

esMejorQue :: Plato -> Plato -> Bool
esMejorQue unPlato otroPlato = masDificil unPlato otroPlato && sumaPesos unPlato < sumaPesos otroPlato

masDificil :: Plato -> Plato -> Bool
masDificil unPlato otroPlato = dificultad unPlato > dificultad otroPlato

sumaPesos :: Plato -> Int
sumaPesos = sum . map cantidad . componentes

participanteEstrella :: [Participante] -> [Plato]
participanteEstrella participantes = map cocinar participantes

elMejorPLato :: [Plato]->Plato
elMejorPLato [unPlato] = unPlato
elMejorPLato (cabeza : cola) | esMejorQue cabeza (elMejorPLato cola) = cabeza
                            | otherwise = elMejorPLato cola 

------------------------
--Punto D
platinum :: Plato
platinum = UnPlato{
    dificultad = 10,
    componentes = componentesMisteriosos
}

componentesMisteriosos :: [Componente]
componentesMisteriosos = map (crearIngrediente) [1..]

crearIngrediente :: Int -> Componente
crearIngrediente n = ("ingrediente" ++ show n, n)






