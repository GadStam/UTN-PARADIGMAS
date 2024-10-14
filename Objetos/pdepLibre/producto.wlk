class Productos{
  var nombre
  var precioBase
  
  method precio() = precioBase*1.21
  method precioFinal()

  method nombreEnOferta(){
    return "SUPER OFERTA " + nombre
  }
}

class Muebles inherits Productos{
  override method precioFinal(){
    return self.precio()+1000
  }
}

class Indumentaria inherits Productos{
  var esDeTemporadaActual
  override method precioFinal() = if(esDeTemporadaActual){return self.precio() * 1.1}else{return self.precio()}
}

class Ganga inherits Productos{
  override method precioFinal() = 0

  override method nombreEnOferta(){
    return "COMPRAME POR FAVOR " + super()
  }
}

