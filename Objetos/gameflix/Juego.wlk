import Suscripcion.*

class Juego{
  const nombre
  const precio
  var categoria

  //aca defino por encapsulamiento el metodo perteneceACategoria

  method perteneceACategoria(unaCategoria){
    return categoria == unaCategoria
  }

  method seLlama(unNombre){
    return nombre == unNombre
  }



  method afectarA(unCliente, unasHoras){} // metodo abstracto

  method saleMenosQue(cantidad){
    return precio < cantidad
  }
}

class JuegoDeTerror inherits Juego{
  override method afectarA(unCliente, unasHoras){
    unCliente.suscripcion(infantil)
  }
}

class JuegoEstrategico inherits Juego{
  override method afectarA(unCliente, unasHoras){
    unCliente.aumentarHumor(5 * unasHoras)
  }
  
}

class Moba inherits Juego{
  override method afectarA(unCliente, unasHoras){
    unCliente.pagar(30)
  }
}

class JuegoViolento inherits Juego{
  override method afectarA(unCliente, unasHoras){
    unCliente.bajarHumor(10 * unasHoras)
  }

  
}