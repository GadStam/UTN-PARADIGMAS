import SinSaldoException.*
class Juego{
  var nombre
  var precio
  var categoria

  method valorMenorA(valor){
    precio < valor
  }

  method esCategoria(unaCategoria){
     categoria == unaCategoria
  }

  method seLlama(unNombre){
    nombre == unNombre
  }




}

class Usuario{
  var suscripcion
  var saldo
  var humor

  method pagar(monto){
    if(saldo < monto){
    saldo = saldo - monto
  }else{
    throw new SinSaldoException()
  }
  }

  method suscrpcion(unaSuscripcion){
    suscripcion = unaSuscripcion
  }

  method pagarSuscripcion(){
    if(saldo < suscripcion.precio()){
      self.suscrpcion(suscripcionPrueba)
  }else{
    self.pagar(suscripcion.precio())
  }
  }
}

object gameFlix{

  var juegos = #{new Juego(nombre = "juego1", precio = 10, categoria = "Infantil"), new Juego(nombre = "juego2", precio = 20, categoria = "Accion")}


  method filtrarJuegosPorCategoria(categoria){
    return juegos.filter({unJuego => unJuego.esCategoria(categoria)})
  }

  method buscarJuego(nombre){
    return juegos.find({unJuego => unJuego.seLlama(nombre)})
  }

  method recomendarJuego(){
    return juegos.anyOne()
  }

  method cobrarSuscripcion(usuario){
    usuario.pagarSuscripcion()
  }
}

object suscrpcionPremium{
const precio = 50
method permiteJugar(juego) = true

method precio() = precio
}

object suscripcionBase{
const precio = 25
method precio() = precio
method permiteJugar(juego){
  juego.valorMenorA(30)
}
}


class SuscripcionConReestriccion{
  const precio
  var categoria
  method precio() = precio
  method permiteJugar(juego){
    juego.esCategoria(categoria)
  }
}

const suscripcionInfantil = new SuscripcionConReestriccion(precio = 20, categoria = "Infantil")
const suscripcionPrueba = new SuscripcionConReestriccion(precio = 0, categoria = "Prueba")