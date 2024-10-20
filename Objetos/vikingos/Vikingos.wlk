class Vikingo{
  var casta
  method esProductivo()
  method puedeIrAExpedicion(){
    return self.esProductivo() 
  }

}

class Soldado inherits Vikingo{
  var vidasCobradas
  var armas

  override method esProductivo() = vidasCobradas > 20 && armas > 1
  override method puedeIrAExpedicion(){
    return super() && armas > 1 && casta != "jarl"
  }
}

class Granjero inherits Vikingo{
  var hijos
  var hectareasDesignadas

  override method esProductivo() = hijos * 2 <= hectareasDesignadas
}