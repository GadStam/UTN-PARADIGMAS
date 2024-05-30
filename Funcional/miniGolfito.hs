
-- Modelo inicial
data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

type Palo = Habilidad -> Tiro

putter :: Palo
putter habilidad = UnTiro {
  velocidad = 10,
  precision = 2* precisionJugador habilidad,
  altura = 0
}

madera :: Palo
madera habilidad = UnTiro {
  velocidad = 100,
  precision = div (precisionJugador habilidad) 2,
  altura = 5
}
type N = Int
hierro :: N -> Palo
hierro n habilidad = UnTiro {
  velocidad = fuerzaJugador habilidad *n,
  precision = div (precisionJugador habilidad) n,
  altura = max 0 (n-3)
}

palos :: [Palo]
palos = [putter, madera] ++ map hierro [1..10]

golpe :: Jugador -> Palo -> Tiro
golpe jugador palo = palo (habilidad jugador)

type Obstaculo = Tiro -> Bool
type EfectoObstaculo = Int->Tiro -> Tiro

tunelConRampita :: Obstaculo
tunelConRampita tiro = precision tiro > 90 && altura tiro == 0

laguna :: Obstaculo
laguna tiro = velocidad tiro > 80 && between 1 5 (altura tiro)

efectos :: EfectoObstaculo
efectos largoLaguna tiro | tunelConRampita tiro = tiro {precision = 100, velocidad = 2*velocidad tiro, altura = 0}
             | laguna tiro = modificarLaguna tiro largoLaguna
             | otherwise = tiro

        
modificarLaguna :: Tiro -> Int -> Tiro
modificarLaguna tiro largoLaguna = tiro {altura = div (altura tiro) largoLaguna, velocidad = div (velocidad tiro) largoLaguna}



