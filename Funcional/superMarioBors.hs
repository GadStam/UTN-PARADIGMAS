import Text.Show.Functions
data Plomero = UnPlomero{
    nombre::String,
    cajaHerramientas :: [Herramienta],
    historial :: [String],
    dinero :: Float
}deriving Show

{-Hay unas cuantas herramientas que un plomero puede tener encima, y de cada una conocemos su denominación (nombre de la herramienta), su precio y el material de su empuñadura, que puede ser hierro, madera, goma o plástico-}

data Herramienta = UnaHerramienta{
    nombreHerramienta::String,
    precio::Float,
    material::String
}deriving Show

{-Mario, un plomero que tiene $1200, no hizo ninguna reparación hasta ahora y en su caja de herramientas lleva una llave inglesa con mango de hierro que tiene un precio de $200 y un martillo con empuñadura de madera que le salió $20.
Wario, tiene 50 centavos encima, no hizo reparaciones, lleva infinitas llaves francesas, obviamente de hierro, la primera le salió un peso, pero cada una que compraba le salía un peso más cara. La inflación lo está matando. 
-}

mario :: Plomero
mario = UnPlomero{
    nombre = "Mario",
    cajaHerramientas = [UnaHerramienta "llaveInglesa" 200 "hierro", UnaHerramienta "martillo" 20 "madera"],
    historial = [],
    dinero = 1200
}

llaveInglesa :: Herramienta
llaveInglesa = UnaHerramienta "llaveInglesa" 200 "hierro"

wario :: Plomero
wario = UnPlomero{
    nombre = "Wario",
    cajaHerramientas = infinitasLlavesFrancesas,
    historial = [],
    dinero = 0.50
}

infinitasLlavesFrancesas :: [Herramienta]
infinitasLlavesFrancesas = map (crearLLaveFrancesa) [1..]

crearLLaveFrancesa :: Float -> Herramienta
crearLLaveFrancesa n = UnaHerramienta "llaveFrancesa" (n + 1) "hierro"
------------------------------------------------------------------------
tieneHerramientaConDenominnacion :: String -> Plomero -> Bool
tieneHerramientaConDenominnacion denominacion plomero = any ((== denominacion).nombreHerramienta) (cajaHerramientas plomero)

esMalvado :: Plomero -> Bool
esMalvado plomero = take 2 (nombre plomero) == "Wa"

puedeComprarHerramineta :: Herramienta -> Plomero -> Bool
puedeComprarHerramineta herramienta plomero = precio herramienta <= dinero plomero
---------------------------------------------------------------------------------------
esBuena :: Herramienta -> Bool
esBuena herramienta = condicionHierro herramienta || esDelMaterial (material herramienta)

condicionHierro :: Herramienta -> Bool
condicionHierro herramienta = esDelMaterial (material herramienta) && (precio herramienta > 1000)

esDelMaterial :: String -> Bool
esDelMaterial "hierro" = True
esDelMaterial "madera" = True
esDelMaterial _ = False




