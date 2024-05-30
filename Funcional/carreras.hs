import Text.Show.Functions

data Auto = UnAuto {
    color::String,
    velocidad::Int,
    distanciaRecorrida :: Int
} deriving Show



type Carrera = [Auto]

auto1 :: Auto
auto1 = UnAuto {
    color = "Rojo",
    velocidad = 10,
    distanciaRecorrida = 100
}

auto2 :: Auto
auto2 = UnAuto {
    color = "Azul",
    velocidad = 20,
    distanciaRecorrida = 90
}

auto3 :: Auto
auto3 = UnAuto {
    color = "Verde",
    velocidad = 30,
    distanciaRecorrida = 50
}

auto4 :: Auto
auto4 = UnAuto {
    color = "Amarillo",
    velocidad = 40,
    distanciaRecorrida = 10
}

carrera :: Carrera
carrera = [auto1, auto2, auto3, auto4]


autoCerca :: Auto->Auto->Bool
autoCerca auto1 auto2 = abs (distanciaRecorrida auto1 - distanciaRecorrida auto2) < 10

autoTranquilo :: Auto->Carrera->Bool
autoTranquilo auto carrera = hayAutosCerca auto carrera && vaGanando auto carrera

hayAutosCerca :: Auto->Carrera->Bool
hayAutosCerca auto carrera = any (autoCerca auto) carrera

vaGanando :: Auto->Carrera->Bool
vaGanando auto carrera = all (<=distanciaRecorrida auto) (map distanciaRecorrida carrera)

puesto :: Auto->Carrera->Int
puesto auto carrera =  (length carrera - (length. filter (>= distanciaRecorrida auto) $ map distanciaRecorrida carrera)) +1

mapDistanciaRecorrida :: (Int->Int)->Auto->Auto
mapDistanciaRecorrida funcion auto = auto {distanciaRecorrida = funcion .distanciaRecorrida $ auto}

mapVelocidad :: (Int->Int)->Auto->Auto
mapVelocidad funcion auto = auto {velocidad = funcion .velocidad $ auto}

correrPorUnTiempo :: Int->Auto->Auto
correrPorUnTiempo tiempo auto = mapDistanciaRecorrida (+tiempo * velocidad auto) auto

bajarVelocidad :: Int->Auto->Auto
bajarVelocidad cantidad auto = mapVelocidad (max 0. subtract cantidad) auto



