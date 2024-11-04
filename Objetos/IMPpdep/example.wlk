import NivelMaximosException.NivelMaximosException

class Pelicula{
  const nombre
  var elenco = #{}

  method elenco() = elenco
  method nombre() = nombre

  method presupuesto(){
    return self.sumaSueldos() + self.sumaSueldos() * 0.7
  }

  method sumaSueldos(){
    return elenco.sum({unArtista => unArtista.sueldo()})
  }

  method recaudado() = 1000000 + self.adicional()
  method adicional()

  method dineroRecaudado() = self.recaudado() - self.presupuesto()

  method rodarPelicula(){
    elenco.forEach({unArtista => unArtista.actuar()})
  }

  method esEconomica(){
    return self.presupuesto() < 500000
  }

}

class PeliculaDrama inherits Pelicula{
  override method adicional() = 100000
}

class PeliculaAccion inherits Pelicula{
  var vidriosRotos

  override method presupuesto(){
    return super() + vidriosRotos * 1000
  }
  override method adicional() = 50000 * elenco.size()
}

class PeliculaTerror inherits Pelicula{
  var cantidadCuchillos
  override method adicional() = 20000 * cantidadCuchillos
}

class PeliculaComedia inherits Pelicula{
  override method adicional() = 0
}



class Artista{
  var experiencia
  var cantidadPeliculasActuadas
  var ahorros

  method nivelFama() = cantidadPeliculasActuadas.div(2)
  method cantidadPeliculasActuadasMasDe(unaCantidad) = cantidadPeliculasActuadas > unaCantidad

  method sueldo(){
    return experiencia.sueldoXExperiencia(cantidadPeliculasActuadas)
  }

  method recategorizar(){
    const siguienteExperiencia = experiencia.recategorizar(self)
    experiencia = siguienteExperiencia
  }

  method actuar(){
    cantidadPeliculasActuadas += 1
    ahorros += self.sueldo()
  }
}






object amateur{
  
  method sueldoXExperiencia(cantidadPeliculasActuadas){
    return 1000
  }


  method recategorizar(unArtista){
    if(unArtista.cantidadPeliculasActuadasMasDe(10)){
      return establecida
    }else{
      return self
    }
  }  
}

object establecida{

  method sueldoXExperiencia(cantidadPeliculasActuadas){
    const nivelFama = cantidadPeliculasActuadas.div(2)
    if(nivelFama < 15){return 15000}else{return 5000}
  }

  method recategorizar(unArtista){
    if(unArtista.nivelFama() > 10){
      return estrella
    }else{
      return self
    }
  }
}

object estrella{
  method sueldoXExperiencia(cantidadPeliculasActuadas){
    return 30000 * cantidadPeliculasActuadas
  }

  method recategorizar(unArtista){
    throw new NivelMaximosException()
  }
}

object imPdep{
  var peliculas = #{}
  method artistas(){
    return peliculas.flatMap({unaPelicula => unaPelicula.elenco()})
  }

  method artistaConMejorSueldo(){
    return self.artistas().max({unArtista => unArtista.sueldo()})
  }

 

method nombresPeliculasEconomicas(){
  return self.peliculasEconomias().map({unaPelicula => unaPelicula.nombre()})
}

method peliculasEconomias(){
  return peliculas.filter({unaPelicula => unaPelicula.esEconomica()})
}

method gananciasPelisEconomias(){
  return self.peliculasEconomias().map({unaPelicula => unaPelicula.dineroRecaudado()}).sum()
}

method recategorizarArtistas(){
  self.artistas().forEach({unArtista => unArtista.recategorizar()})
}
}

