import Text.Show.Functions
data Heore = UnHeroe{
    epileto :: String,
    reconocimiento :: Int,
    coraje :: Int,
    artefactos::[Artefacto],
    tareas :: [Tarea]
} deriving Show

data Artefacto = UnArtefacto{
    nombre :: String,
    rareza :: Int
}deriving Show

data Bestia = UnaBestia{
    nombreBestia :: String,
    debilidad :: Debilidad
}deriving Show

type Debilidad = Heore -> Bool
type Tarea = Heore -> Heore

hordus :: Heore
hordus = UnHeroe "Hordus" 600 50 [UnArtefacto "Espada de la noche" 50, UnArtefacto "jjche" 100] [encontrarUnArtefacto (UnArtefacto "Lanza del Olimpo" 100),escalarElOlimpo]


----accesors-----
mapReconocimiento :: (Int -> Int) -> Heore -> Heore
mapReconocimiento f heroe = heroe {reconocimiento = f . reconocimiento $ heroe}

mapCoraje :: (Int -> Int) -> Heore -> Heore
mapCoraje f heroe = heroe {coraje = f . coraje $ heroe}

mapArtefactos :: ([Artefacto] -> [Artefacto]) -> Heore -> Heore
mapArtefactos f heroe = heroe {artefactos = f . artefactos $ heroe}

mapEpileto :: (String -> String) -> Heore -> Heore
mapEpileto f heroe = heroe {epileto = f . epileto $ heroe}

nuevoEpileto :: String -> Heore -> Heore
nuevoEpileto unEpileto = mapEpileto (const unEpileto)
----------------------------------------------------------------------------
pasarAlaHistoria :: Heore -> Heore
pasarAlaHistoria unHeroe | reconociminetoMayor unHeroe 1000 =nuevoEpileto "El mitico " unHeroe
                        | reconociminetoMayor unHeroe 500 = nuevoEpileto "El magnifico " . agregarArtefacto "Lanza del Olimpo"  100  $ unHeroe
                        | estarEntre 100 500 unHeroe = nuevoEpileto "hoplita". agregarArtefacto "Xiphos"  50 $ unHeroe
                         | otherwise = unHeroe

reconociminetoMayor :: Heore -> Int-> Bool
reconociminetoMayor unHeroe unReconocimiento = (reconocimiento unHeroe) > unReconocimiento



agregarArtefacto :: String -> Int -> Heore -> Heore
agregarArtefacto unNombre unaRareza = mapArtefactos (++ [UnArtefacto unNombre unaRareza])

estarEntre :: Int -> Int -> Heore -> Bool
estarEntre unNumero otroNumero unHeroe = (reconocimiento unHeroe) > unNumero && (reconocimiento unHeroe) < otroNumero

-------------------------------------------------------------------------------------------------
encontrarUnArtefacto :: Artefacto -> Tarea
encontrarUnArtefacto unArtefacto = mapArtefactos (++ [unArtefacto]).mapReconocimiento (+ (rareza unArtefacto))

escalarElOlimpo :: Tarea
escalarElOlimpo unHeroe = agregarArtefacto "El relámpago de Zeus" 500 .mapReconocimiento (+ 500) . mapArtefactos (const listaFiltrada artefactos) $ unHeroe

listaFiltrada :: [Artefacto]->[Artefacto]
listaFiltrada = filtrarRarezas . triplicarRareza

filtrarRarezas :: [Artefacto] -> [Artefacto]
filtrarRarezas = filter ((>100) . rareza)


triplicarRareza :: [Artefacto] -> [Artefacto]
triplicarRareza = map triplicarRarezaArtefacto

triplicarRarezaArtefacto :: Artefacto -> Artefacto
triplicarRarezaArtefacto unArtefacto = unArtefacto {rareza = (*3) . rareza $ unArtefacto}

ayudarAcruzarLaCalle :: Int->Tarea
ayudarAcruzarLaCalle unNumero = mapEpileto (const ((\groso -> groso ++ replicate unNumero 'o') "gros"))

matarUnaBestia :: Bestia -> Tarea
matarUnaBestia unaBestia unHeroe | (debilidad unaBestia) unHeroe = mapEpileto (const ("El asesino de " ++ nombreBestia unaBestia)) unHeroe
                                | otherwise = nuevoEpileto "el cobarde" . mapArtefactos (drop 1) $ unHeroe

tareaPrueba :: Tarea
tareaPrueba = ayudarAcruzarLaCalle 3

heracles :: Heore
heracles = UnHeroe "Guardián del Olimpooo" 700 100[UnArtefacto "Pistola" 1000, UnArtefacto "El relámpago de Zeus" 500] [escalarElOlimpo]

leonDeNemea :: Bestia
leonDeNemea = UnaBestia "Leon de Nemea" epitetoMayorA20

epitetoMayorA20 :: Debilidad
epitetoMayorA20 = (> 20) . length . epileto

hacerTarea :: Heore -> Tarea -> Heore
hacerTarea unHeroe unaTarea = unaTarea unHeroe

presumir :: Heore -> Heore -> (Heore , Heore)
presumir unHeroe otroHeroe | reconocimiento unHeroe > reconocimiento otroHeroe = (unHeroe,otroHeroe)
                            | reconocimiento unHeroe < reconocimiento otroHeroe = (otroHeroe, unHeroe)
                            | reconocimiento unHeroe == reconocimiento otroHeroe  && sumatoriararezas unHeroe > sumatoriararezas otroHeroe= (unHeroe,otroHeroe)
                            | reconocimiento unHeroe == reconocimiento otroHeroe  && sumatoriararezas unHeroe < sumatoriararezas otroHeroe= (otroHeroe, unHeroe)
                            | otherwise = (unHeroe, otroHeroe)


sumatoriararezas :: Heore -> Int
sumatoriararezas unHeroe = sum . map rareza . artefactos $ unHeroe

type Labor = [Tarea]

realizarLabor :: Labor -> Heore -> Heore
realizarLabor unasTareas unHeroe = foldl (hacerTarea) unHeroe unasTareas




















