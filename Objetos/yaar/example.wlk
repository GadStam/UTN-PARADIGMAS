class Barco{
  var mision
  const tripulacion = #{}
  var capacidad


  method estemible(){
    return mision.puedeCumplirla(self)
  }

  method tieneSuficienteTripulacion(){
    return tripulacion.size() >= capacidad * 0.9
  }

  method sonUtilesLosTripulantes(){
    return mision.sonUtilesLosTripulantes(tripulacion)
  }

  method algunTripulanteTieneLlaveDeCofre(){
    return tripulacion.any({ pirata => pirata.tiene("llaveDeCofre")})
  }

  method sirveElPirata(pirata){
    return mision.sirveElPirata(pirata)
  }




}

class Pirata{
  var items = []

  var embriedad
  var dinero

  method esUtirlPara(mision) = true

  method tiene(item){
    return items.contains(item)
  }

  method masDeMonedas(unaCantidad){
    return dinero > unaCantidad
  }

  method menosDeMonedas(unaCantidad){
    return dinero < unaCantidad
  }

  method masDe10Items(){
    return items.size() > 10
  }
  
}

class mision{
  method puedeCumplirla(barco){
    return barco.tieneSuficienteTripulacion()
  }
}

class busquedaDeTesoros inherits mision{

  override method puedeCumplirla(barco){
    return super(barco) && barco.algunTripulanteTieneLlaveDeCofre()
  }

  method sirveElPirata(pirata){
    return (pirata.tiene("mapa") || pirata.tiene("brujula")|| pirata.tiene("botella")) && !pirata.masDeMonedas(5)
  }
  
}

class convertirseEnLeyenda inherits mision{
  var itemObligatorio

  method sirveElPirata(pirata){
    return pirata.tiene(itemObligatorio) && pirata.masDe10Items()
  }
}

class Saqueo inherits mision{
  var cantidadMonedas

  method sirveElPirata(pirata){
    return pirata.menosDeMonedas(cantidadMonedas) && pirata.seAnimaASaquear()
  }
}

