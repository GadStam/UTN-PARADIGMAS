class Cupon{
  const descuento
  var fueUsado = false

  method estaDisponible(){
    return !fueUsado
  }

  method descuento() = descuento
  

   
}