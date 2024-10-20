class Reglo{
  var destinatario
  const precio

  method destinatario(){
    return destinatario
  }

  method precio(){
    return precio
  }

  method esRegaloTeQuieroMucho(){
    return precio > self.umbralPrecios()
  }

  method umbralPrecios(){
    return 100 // no dice nada del umbral
  }
}

class Tarjeta{
  var destinatario
  const valor
  const precio = 2

  method precioMayorA(unPrecio){
    return valor > unPrecio
  }

}

class Adornos{
  var peso
  var coefSuperioridad

  method importancia(){
    return peso * coefSuperioridad
  }

  method peso(){
    return peso
  }
}

class Luces inherits Adornos{
  var cantLamparas
  override method importancia(){
    return super() * self.luminosisdad()
  }

  method luminosisdad(){
    return cantLamparas
  }
}

class Figuras inherits Adornos{
  var volumen

  override method importancia(){
    return super() * volumen
  }
}

class Guirnalda inherits Adornos{
  var anioCompra

  override method peso(){
    return super() - 100 * anioCompra
  }
}