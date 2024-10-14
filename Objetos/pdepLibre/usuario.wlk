import NoPuedeAgregarAlCarritoException.NoPuedeAgregarAlCarritoException
import niveles.*
class Usuario{
const nombre
var dineroDisponible
var puntos
var nivel
const carrito = []
const cupones = []

method agregarAlCarrito(producto){
  if(nivel.puedeAgregarAlCarrito(carrito.size())){
    carrito.add(producto)
  }else{
    throw new NoPuedeAgregarAlCarritoException()
  }
}

method comprarCarrito(){
const cupon = self.cuponDisponible()
const precioAPagar = self.descuentoAplicado(cupon.descuento(), carrito.precioDelCarrito())
dineroDisponible -= precioAPagar
}

method cuponDisponible(){
  return cupones.filter({unCupon => unCupon.estaDisponible()}).anyOne()
}

method precioDelCarrito(){
  return carrito.sum({unProducto => unProducto.precio()})
}

method descuentoAplicado(unDescuento, unPrecio){
  return unPrecio*(1-unDescuento)
}

method esMoroso(){
  return dineroDisponible < 0
}

method penalizar(){
  dineroDisponible -= 1000
}

method eliminarCuponesUsados(){
  cupones.removeAllSuchThat({unCupon => !unCupon.estaDisponible()})
}

  method actualizarNivel(){
  nivel = self.nivelCorrespondiente()       
  }

  method nivelCorrespondiente(){
    if(puntos < 5000){return bronce}else if(puntos < 15000){return plata}else{return oro}
  } 
}

