import Suscripcion.*

class Cliente{
  var humor
  var plata
  var suscripcion

method bajarHumor(unValor){
  if (plata < unValor){
  throw new Exception(message = "No tenes plata suficiente")
  }

  humor -= unValor
}

method aumentarHumor(unValor){
  humor += unValor
}

method pagar(unMonto){
  plata -= unMonto
}

method pagarSuscripcion(){
  try{
    self.pagar(suscripcion.precio())
  }catch unError : Exception{
    self.suscripcion(base)
  }
}



method suscripcion(unaSuscripcion){
  suscripcion = unaSuscripcion
}

}