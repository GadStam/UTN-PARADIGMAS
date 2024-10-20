class TrajeTierno{
  const capacidadSusto = 2
  method capacidadSusto(){
    return capacidadSusto
  }
}

class TrajeTerrorificos{
  const capacidadSusto = 5
  method capacidadSusto(){
    return capacidadSusto
  }
}

class Maquillaje{
  var capacidadSusto = 3
  method capacidadSusto(){
    return capacidadSusto
  }
}

class Ninio{
  var elementos = []
  var actitud
  var caramelos

  method recibirCaramelos(unosCaramelos){
    caramelos += unosCaramelos
  }

  method elementos(){
    return elementos
  }

  method caramelos(){
    return caramelos
  }

  method capacidadSusto(){
    return actitud * self.sumatoriaSustos()
  }

  method sumatoriaSustos(){
    return elementos.sum({unElemento => unElemento.capacidadSusto()})
  }

  method asustarA(unaPersona){
    if(unaPersona.recibirSusto(self)){
      self.recibirCaramelos(unaPersona.DarCaramelos())
    }
  }

    method tieneMasDecaramelos(cantidadCaramelos){
      return caramelos > cantidadCaramelos
    }
  }


//const ninio1 = new Ninio(elementos = [new TrajeTierno(), new Maquillaje()], actitud = 10)

class Adulto{
  var niniosQueAsustaron = #{}
  method tolerancia(){
    return 10* self.niniosConMasDe15Caramelos().size()
  }

  method niniosConMasDe15Caramelos(){
    return niniosQueAsustaron.filter({unNinio => unNinio.tieneMasDecaramelos(15)})
  }

  method recibirSusto(unNinio){
    return unNinio.capacidadSusto() > self.tolerancia()
  }

  method DarCaramelos(){
    return self.tolerancia() / 2
  }

  }
  
  class Abuelo inherits Adulto{
    override method recibirSusto(unNinio){
      return true
    }

    override method DarCaramelos(){
      return super().div(2)
    }
  }

  class AdultoNecio inherits Adulto{
    override method recibirSusto(unNinio){
      return false
    }
  }

  const ninio1 = new Ninio(elementos = [new TrajeTierno(), new Maquillaje()], actitud = 10, caramelos = 0)
  const ninio2 = new Ninio(elementos = [new TrajeTerrorificos(), new Maquillaje()], actitud = 10, caramelos = 20)

  const adulto1 = new Adulto(niniosQueAsustaron = #{ninio2})

  class Legion{
    var miembros = #{}

    method capacidadAsustar(){
      return miembros.sum({unMiembro => unMiembro.capacidadSusto()})
    }

    method caramelos(){
      return miembros.sum({unMiembro => unMiembro.caramelos()})
    }

    method lider(){
      return miembros.max({unMiembro => unMiembro.capacidadSusto()})
    }

    method asustarA(unaPersona){
      miembros.forEach({unMiembro => unMiembro.asustarA(unaPersona)})
  
    }
  }

  class Barriales{
    const niniosQueHabitan = #{}
//los tres ninios con mas caramelos
    method niniosConMasCaramelos(){
      return niniosQueHabitan.sortBy({unNinio => unNinio.caramelos()}).take(3)
    }

    //Los elementos, sin repetidos, usados por los niños con más de 10 caramelos.
    method elementosUsadosPorNiniosConMasDe10Caramelos(){
      return self.niniosCopnMasDeCaramelos(10).flatMap({unNinio => unNinio.elementos()}).distinct()
    }

    method niniosCopnMasDeCaramelos(cantidadCaramelos){
      return niniosQueHabitan.filter({unNinio => unNinio.tieneMasDecaramelos(cantidadCaramelos)})
    }

  }



  const legion1 = new Legion(miembros = #{ninio1})



  



