class NivelLimitado{
    const limite
    method puedeAgregarAlCarrito(cantidadDeProductos){
        return cantidadDeProductos < limite
    }
}


const bronce = new NivelLimitado(limite=1)
const plata = new NivelLimitado(limite=5)


object oro{
         
        method puedeAgregarAlCarrito(cantidadDeProductos){
            return true
        }
}