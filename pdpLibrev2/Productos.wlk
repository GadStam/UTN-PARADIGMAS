class Producto{
  var nombre
  var precioBase

  method precio() = precioBase*1.21
  method precioFinal()
}

class Mueble inherits Producto{
  override method precioFinal() = self.precio() + 1000

}

class Indumentaria inherits Producto{
  var esDeTemporada
  override method precioFinal() = if(esDeTemporada) self.precio()*1.1 else self.precio()

}

class Ganga inherits Producto{
  
  override method precioFinal() = 0
}