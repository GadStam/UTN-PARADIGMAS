import Text.Show.Functions
data Participante = Participante {
  nombre       :: String,
  trucos       :: [Truco],
  especialidad :: Plato
}deriving Show

type Truco = Plato -> Plato

data Plato = Plato {
  dificultad  :: Int,
  componentes :: [Componente]
} deriving Show

type Componente = (Ingrediente, Peso)
type Ingrediente = String
type Peso = Int

fideos :: Plato
fideos = Plato {
    dificultad = 8,
    componentes = [("fideos", 1), ("agua", 5), ("sal", 1), ("aceite", 1), ("tomate", 2), ("carne", 1)]
}

carne :: Plato
carne = Plato {
    dificultad = 5,
    componentes = [("carne", 100), ("sal", 10), ("aceite", 100)]
}

hambuguesa :: Plato
hambuguesa = Plato {
    dificultad = 3,
    componentes = [("carne", 1000), ("sal", 10), ("aceite", 100), ("pan", 50), ("lechuga", 50), ("tomate", 50)]
}


---------------Accesors--------------------------
mapComponentes :: ([Componente]->[Componente])->Plato->Plato
mapComponentes funcion plato = plato {componentes = funcion .componentes $ plato}

mapDificultad :: (Int->Int)->Plato->Plato
mapDificultad funcion plato = plato {dificultad = funcion .dificultad $ plato}

duplicarCantidad :: Componente -> Componente
duplicarCantidad (ingrediente, cantidad) = (ingrediente, cantidad * 2)

endulzar :: Peso->Truco
endulzar cantidad = mapComponentes (++ [("azucar", cantidad)])


salar :: Peso->Truco
salar cantidad = mapComponentes (++ [("sal", cantidad)])

darSabor :: Peso->Peso->Truco
darSabor cantidadSal cantidadAzucar = mapComponentes (++ [("sal", cantidadSal), ("azucar", cantidadAzucar)])

duplicarPorcion :: Truco
duplicarPorcion = mapComponentes $ map duplicarCantidad

simplificar :: Plato -> Plato 
simplificar plato 
    | dificultadMayorA7 plato && masDe5componentes plato = mapDificultad (\_ -> 5) $ mapComponentes quitarComponentes plato
    | otherwise = plato

dificultadMayorA7 :: Plato -> Bool
dificultadMayorA7 plato = dificultad plato > 7

masDe5componentes :: Plato -> Bool
masDe5componentes plato = length (componentes plato) > 5

quitarComponentes :: [Componente] -> [Componente]
quitarComponentes = filter (not.pesoMenorA10)

pesoMenorA10 :: Componente -> Bool
pesoMenorA10 (_, peso) = peso < 10

esVegano :: Plato -> Bool
esVegano = all (not.ingredienteDeCarne.fst).componentes

ingredienteDeCarne :: Ingrediente -> Bool
ingredienteDeCarne ingrediente = ingrediente == "carne"

esSinTacc :: Plato -> Bool
esSinTacc = any (esHarina.fst).componentes

esHarina :: Ingrediente -> Bool
esHarina ingrediente = ingrediente == "harina"

esComplejo :: Plato -> Bool
esComplejo plato = dificultadMayorA7 plato && masDe5componentes plato

noAptoHipertension :: Plato -> Bool
noAptoHipertension plato
  | tieneSal plato = (cantidadDeSal plato > 2)
  | otherwise = False

cantidadDeSal :: Plato -> Int
cantidadDeSal = sum.(map snd).filter ((=="sal").fst).componentes

tieneSal :: Plato -> Bool
tieneSal = any ((=="sal").fst).componentes

--En la prueba piloto del programa va a estar participando Pepe Ronccino quien tiene unos trucazos bajo la manga como darle sabor a un plato con 2 gramos de sal y 5 de azúcar, simplificarlo y duplicar su porción. Su especialidad es un plato complejo y no apto para personas hipertensas.
pepeRonccino :: Participante
pepeRonccino = Participante {
  nombre = "Pepe Ronccino",
  trucos = [darSabor 2 5, simplificar, duplicarPorcion],
  especialidad = fideos
}

pop :: Participante
pop = Participante {
  nombre = "Pop",
  trucos = [salar 1, endulzar 1, simplificar],
  especialidad = carne
}

gad :: Participante
gad = Participante {
  nombre = "gad",
  trucos = [simplificar],
  especialidad = hambuguesa
}

cocinar :: Participante -> Plato
cocinar unParticipante = aplicarTrucos (trucos unParticipante) (especialidad unParticipante)

-- foldl unaFuncion unaSemilla unaLista
-- foldr
aplicarTrucos :: [Truco] -> Plato -> Plato
aplicarTrucos unosTrucos unPlato = foldr ($) unPlato unosTrucos

cantidad :: Componente -> Int
cantidad unComponente = snd unComponente

esMejorQue :: Plato -> Plato -> Bool
esMejorQue plato1 plato2 = dificultad plato1 < dificultad plato2 && sumaComponentes plato1 plato2

sumaComponentes :: Plato -> Plato -> Bool
sumaComponentes plato1 plato2 = peso plato1 < peso plato2

peso :: Plato -> Int
peso unPlato = sum . map cantidad . componentes $ unPlato

concursantes :: [Participante]
concursantes = [pepeRonccino, pop, gad]

participanteEstrella :: [Participante] -> Participante
participanteEstrella [] = error "La lista de participantes no puede estar vacía"
participanteEstrella [participante] = participante
participanteEstrella (cabeza:cola)
  | esMejorQue (cocinar cabeza) (cocinar (participanteEstrella cola)) = cabeza
  | otherwise = participanteEstrella cola


platinum :: Plato
platinum = Plato {
  dificultad = 10,
  componentes = unaListaDecomponentesRara
}


unaListaDecomponentesRara :: [Componente]
unaListaDecomponentesRara =
  map (\unNumero -> ("Ingrediente " ++ show unNumero, unNumero)) [1..]




            
  











--darSabor: dadas una cantidad de sal y una de azúcar sala y endulza un plato.

