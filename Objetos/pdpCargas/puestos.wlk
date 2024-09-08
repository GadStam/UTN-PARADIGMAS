import pdpCargas.camiones.*

object rutatlantica {
  method dejarPasar(unCamion) {
    pdepCargas.cobrar(self.tarifa(unCamion))
    unCamion.recorrer(400, 75) // Modelar velocidad maxima (Deberia ser el minimo entre 75 y la velocidad maxima del camion)
  }

  method tarifa(unCamion) {
    return 7000 + unCamion.pesoDeCarga().div(1000) * 100 
  }
}

object pdepCargas {
  var coste = 0

  method cobrar(unaTarifa) {
    coste += unaTarifa
  }
}