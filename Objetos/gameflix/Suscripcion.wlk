


object premium{
  const precio = 50

  method precio(){
    return precio
  }

  method puedeJugar(unJuego){
    return true
  }


}

object base{
  const precio = 25

  method precio(){
    return precio
  }

  method puedeJugar(unJuego){
    return unJuego.saleMenosQue(30)
  }

}

class SuscripcionporCategoria{
  const categoria
  
  method puedeJugar(unJuego){
      return unJuego.perteneceACategoria(categoria)
  }

  const precio

  method precio(){
    return precio
  }
  
}

const infantil = new SuscripcionporCategoria(categoria = "infantil", precio = 10)
const prueba = new SuscripcionporCategoria(categoria = "demo", precio = 0)
