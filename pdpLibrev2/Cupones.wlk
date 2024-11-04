class Cupon{
    var fueUsado = false
    var descuento

    method fueUsado() = fueUsado

    method usar(){
        fueUsado = true
    }

    method estaDisponible(){
        return !fueUsado
    }

    method aplicarDescuento(unPrecio){
        return unPrecio*(1-descuento)
    }


}