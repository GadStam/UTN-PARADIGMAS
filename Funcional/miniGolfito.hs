data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Model

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

------Accesors---------
mapHabilidad :: (Habilidad -> Habilidad) -> Jugador -> Jugador
mapHabilidad f unJugador = unJugador {habilidad = f.habilidad $ unJugador}

-----------------Accesors Habilidad--------------
mapFuerza :: (Int -> Int) -> Habilidad -> Habilidad
mapFuerza f unaHabilidad = unaHabilidad {fuerzaJugador = f.fuerzaJugador $ unaHabilidad}

mapPrecision :: (Int -> Int) -> Habilidad -> Habilidad
mapPrecision f unaHabilidad = unaHabilidad {precisionJugador = f.precisionJugador $ unaHabilidad}
-----------------Accesors Tiro--------------
mapVelocidad :: (Int -> Int) -> Tiro -> Tiro
mapVelocidad f unTiro = unTiro {velocidad = f.velocidad $ unTiro}

mapPrecisionTiro :: (Int -> Int) -> Tiro -> Tiro
mapPrecisionTiro f unTiro = unTiro {precision = f.precision $ unTiro}

mapAltura :: (Int -> Int) -> Tiro -> Tiro
mapAltura f unTiro = unTiro {altura = f.altura $ unTiro}

----------------------------------
-- Punto 1
type Palo = Habilidad -> Tiro

putter :: Palo
putter habilidad = UnTiro{
  velocidad = 10,
  precision = precisionJugador habilidad * 2,
  altura = 0
}

madera :: Palo
madera habilidad = UnTiro{
  velocidad = 100,
  precision = div (precisionJugador habilidad) 2,
  altura = 5
}

hierro :: Int -> Palo
hierro n habilidad = UnTiro{
  velocidad = (n*). fuerzaJugador $ habilidad,
  precision = div (precisionJugador habilidad) n,
  altura = max 0 (n - 3)
}

golpe :: Jugador -> Palo -> Tiro
golpe jugador palo = palo.habilidad $ jugador
---------------------------------
-- Punto 2
type Obstaculo = Tiro -> Tiro

tunelConRampita :: Obstaculo
tunelConRampita tiro | (precision tiro > 90) && (altura tiro == 0) = mapAltura(const 0). mapPrecisionTiro(const 100) . mapVelocidad (*2) $ tiro
                     | otherwise = detenerse tiro

laguna :: Int -> Obstaculo
laguna largo tiro | (velocidad tiro > 80) && estaEntre 1 5 (altura tiro) = mapAltura (`div` largo) tiro
                  | otherwise = detenerse tiro

estaEntre :: Int->Int->Int -> Bool
estaEntre num1 num2 tiro = between num1 num2 tiro

hoyo :: Obstaculo
hoyo tiro | estaEntre 5 20 (velocidad tiro) && (precision tiro > 95) && (altura tiro == 0) = detenerse tiro
          | otherwise = tiro

detenerse :: Tiro -> Tiro
detenerse tiro = UnTiro{
  velocidad = 0,
  precision = 0,
  altura = 0
}

---------------------------------
-- Punto 3
palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles jugador obstaculo = filter(esUtil jugador obstaculo) [putter, madera] ++ map hierro [1..10]

esUtil :: Jugador -> Obstaculo -> Palo -> Bool
esUtil jugador obstaculo palo = aplicarObstaculo jugador obstaculo palo /= detenerse (golpe jugador palo)


aplicarObstaculo :: Jugador -> Obstaculo -> Palo->Tiro
aplicarObstaculo  jugador obstaculo palo = obstaculo . golpe jugador $ palo








