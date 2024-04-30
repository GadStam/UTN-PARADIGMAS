
import Text.Show.Functions
import Foreign (toBool)

data Personaje = UnPersonaje {
    nombre :: Nombre,
    poderBasico :: PoderBasico,
    superPoder :: SuperPoder,
    superPoderActivo :: SuperPoderActivo,
    cantidadVidas :: CantidadVidas
} deriving Show

type Nombre = String
type PoderBasico = Personaje -> Personaje
type SuperPoder = String
type SuperPoderActivo = Bool
type CantidadVidas = Int

type TipoTuerca = String

bolaEspinosa :: PoderBasico
bolaEspinosa personaje = modificarVida (max 0 . subtract 1000) personaje

lluviaDeTuercas :: TipoTuerca->PoderBasico ---esta funcion utiliza patern matching. para que matchee con el tipo de tuerca que le pasan
lluviaDeTuercas "sanadora" personaje = modificarVida (+100) personaje
lluviaDeTuercas "dañina" personaje = modificarVida (`div` 2) personaje
lluviaDeTuercas _ personaje = personaje


modificarVida :: (Int->Int) -> Personaje -> Personaje ---recibe una funcion y un personaje y devuelve personaje. modifica la vida de un personaje ayuda a no repetir logica
modificarVida unaFuncion personaje = UnPersonaje { cantidadVidas = unaFuncion . cantidadVidas $ personaje}





espina :: Personaje
espina = UnPersonaje "Espina" bolaEspinosa "Granada de Espinas" False 4800

pamela :: Personaje
pamela = UnPersonaje { 
    nombre = "Pamela", 
    poderBasico = lluviaDeTuercas "sanadora",       --aplicacion parcial 
    superPoder = "Torreta Curativa", 
    superPoderActivo = False, 
    cantidadVidas = 9600 
    }


