import NoHayLuegarException.NoHayLuegarException
import articulosNavidenos.*

class ArbolesArtificiales inherits Arbol{
var cantVaras

override method capacidadRegalos() = cantVaras
}

class ArbolesNaturales inherits Arbol{
var vejez
var tamTronco

override method capacidadRegalos() = vejez * tamTronco
}


class Arbol{
  var regalos =[]
  var tarjetas =[]
  var adornos =[]

  method capacidadRegalos()

  method agregarRegalo(regalo){
    if (regalos.size() < self.capacidadRegalos()){
      regalos.add(regalo)
    }else{
      throw new NoHayLuegarException()
    }
}

method beneficiados(){
  return self.destinatariosDe(regalos) + self.destinatariosDe(tarjetas)
}

method destinatariosDe(unosPresentes) = unosPresentes.map({unPresente => unPresente.destinatario()})
method costoTotalgastado(){
  return regalos.sum({unRegalo => unRegalo.precio()})
}

method importanciaArbol(){
  return adornos.sum({unAdorno => unAdorno.importancia()})
}

method esArbolPortentoso(){
  return self.regalosTeQuiierenMucho(5) && self.tarjetaMaDe(1000)
}

method regalosTeQuiierenMucho(unaCantidad){

  return regalos.count({regalo => regalo.esRegaloTeQuieroMucho()}) > unaCantidad
}

method tarjetaMaDe(unPrecio){
  return tarjetas.any({tarjeta => tarjeta.precioMayorA(unPrecio)})
}

method adornoMasPesado(){
  return adornos.max({adorno => adorno.peso()})
}

}


