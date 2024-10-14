import Juego.*

object gameflix{
  const juegos = #{new Juego(nombre = "Hollow Knight", precio = 10, categoria = "demo")}
  const clientes = #{}

  //que el juego se ocupe de saber si pertenece a una categoria
  method juegosPorCategoria(unaCategoria){
    return juegos.filter({unJuego => unJuego.perteneceACategoria(unaCategoria)})
  }

  method juegoQueSeLlama(unNombre){
    return juegos.findOrElse({unJuego => unJuego.seLlama(unNombre)},{throw new Exception(message = "No se encontro el juego " + unNombre)})
  }

  method juegoRecomendado(){
    return juegos.anyOne()
  }

  method cobrarSuscripciones(){
    clientes.forEach({unCliente => unCliente.pagarSuscripcion()})
  }

}