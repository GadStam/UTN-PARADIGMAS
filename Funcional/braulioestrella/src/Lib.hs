
import Text.Show.Functions


data Personaje = UnPersonaje {
    nombre :: Nombre,
    poderBasico :: PoderBasico,
    superPoder :: SuperPoder,
    superPoderActivo :: SuperPoderActivo,
    cantidadVidas :: CantidadVidas
} deriving Show

type Nombre = String
type PoderBasico = Personaje -> Personaje
type SuperPoder = Personaje -> Personaje
type SuperPoderActivo = Bool
type CantidadVidas = Int
type Radio = Int

type TipoTuerca = String

bolaEspinosa :: PoderBasico
bolaEspinosa personaje = modificarVida (max 0 . subtract 1000) personaje

lluviaDeTuercas :: TipoTuerca->PoderBasico ---esta funcion utiliza patern matching. para que matchee con el tipo de tuerca que le pasan
lluviaDeTuercas "sanadora" personaje = modificarVida (+100) personaje
lluviaDeTuercas "dañina" personaje = modificarVida (`div` 2) personaje
lluviaDeTuercas _ personaje = personaje


modificarVida :: (Int->Int) -> Personaje -> Personaje ---recibe una funcion y un personaje y devuelve personaje. modifica la vida de un personaje ayuda a no repetir logica
modificarVida unaFuncion personaje = personaje { cantidadVidas = unaFuncion . cantidadVidas $ personaje}


granadaDeEspinas :: Radio -> PoderBasico
granadaDeEspinas radio personaje| radio > 3 = personaje { nombre = nombre personaje ++ "“Espina estuvo aquí”"}
                                | radio > 3 && cantidadVidas personaje < 800 = personaje { nombre = nombre personaje ++ " Espina estuvo aquí", cantidadVidas = 0, superPoderActivo = False}
                                | otherwise = bolaEspinosa personaje


torretaCurativa :: PoderBasico
torretaCurativa personaje = (modificarVida (*2) . modificarSuperPoderActivo) personaje

modificarSuperPoderActivo :: Personaje -> Personaje
modificarSuperPoderActivo personaje = personaje { superPoderActivo = True}



espina :: Personaje
espina = UnPersonaje {
    nombre = "Espina",
    poderBasico = bolaEspinosa,
    superPoder = granadaDeEspinas 5,
    superPoderActivo = True,
    cantidadVidas = 4800
}

pamela :: Personaje
pamela = UnPersonaje { 
    nombre = "Pamela", 
    poderBasico = lluviaDeTuercas "sanadora",       --aplicacion parcial 
    superPoder = torretaCurativa, 
    superPoderActivo = False, 
    cantidadVidas = 9600 
    }


