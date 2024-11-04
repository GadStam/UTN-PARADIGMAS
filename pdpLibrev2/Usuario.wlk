import NoHayEspacioEnElCarritoException.*

class Usuario{
const nombre
var dinero
var puntos
var nivel
var carrito = []
var cupones =[]

method agregarAlCarrito(unProducto){
    if(nivel.puedeTenerEnElcarrito(carrito.size())){
        carrito.add(unProducto)
    }else{
        throw new NoHayEspacioEnElCarritoException()
    }
}

method comprarProductos(){
    const preciocarrito = self.precioCarrito()
    const cupon = self.cupon()
    cupon.usar()
    const precioFinal = cupon.aplicarDescuento(preciocarrito)
    self.pagar(precioFinal)
    self.sumarPuntos(precioFinal*0.1)

}
method precioCarrito(){
    return carrito.sum({unProducto => unProducto.precioFinal()})
}

method cupon(){
    return cupones.filter({unCupon => unCupon.estaDisponible()}).anyOne()
}

method pagar(unPrecio){
    dinero -= unPrecio
}

method sumarPuntos(unPrecio){
    puntos += unPrecio
}

method esMoroso() = dinero < 0


}


class NivelesConRestriccion{
    var puntosNcesarios
    var limite
    method puntosNecesarios() = puntosNcesarios
    method puedeTenerEnElcarrito(unaCantidad){
        return unaCantidad < limite
    }
}

object oro{
    method puntosNecesarios() = 15000
    method puedeTenerEnElcarrito(unaCantidad){
        return true
    }
    
}

const bronce = new NivelesConRestriccion(puntosNcesarios = 0, limite = 1)
const plata = new NivelesConRestriccion(puntosNcesarios = 5000, limite = 5)
