object gandalf {
 var nivelDeVida = 100.max(0).min(100)
 var armas = [baculo, espada]

 method sumatoriaDePoderDeArmas() {
    return armas.sum({unArma => unArma.poder()})
  }

  method poder(){
    if(nivelDeVida > 10){
      return nivelDeVida*15 + self.sumatoriaDePoderDeArmas()*2
    }else{
      return nivelDeVida*300 + self.sumatoriaDePoderDeArmas()
    }
  }
}

object baculo{
  method poder() = 400
}

object espada{
   var origen = "elfico"

  method poder() {
    if (origen == "elfico") {
      return 25 * 10
    } else if (origen == "enano") {
      return 20 * 10
    } else {
      return 15 * 10
    }
  }
}