object verdurin{
  var cantCajones = 10
  var pesoCajon = 50
  var kilometraje = 700000
  method pesoDeCarga() = cantCajones * pesoCajon
  method velocidadMaxima()= 80 - (500.div(self.pesoDeCarga()))

  method recorrer(unosKilometros, unaVelocidadMaxima) {
    kilometraje += unosKilometros
  }

}

object scanion5000{
  const capacidadCombustible = 5000
  var densidad = 1

  method pesoDeCarga() {
    return densidad * capacidadCombustible
  }

  method densidad(unaDensidad) {
    densidad = unaDensidad
  }

  method velocidadMaxima() = 140

  method recorrer(unosKilometros, unaVelocidadMaxima) {}
}

object cerealitas{
  var deterioro = 0
  method deterioro(unDeterioro) {
    deterioro = unDeterioro
  }
  var carga = 0
  method carga(unaCarga) {
    carga = unaCarga
  }
  method velocidadMaxima() {
    if (deterioro < 10) {
      return 40
    } else {
      return 60 - deterioro
    }
  }

  method recorrer(unosKilometros, unaVelocidadMaxima) {
    deterioro += (unaVelocidadMaxima - 45).max(0)
  }
}