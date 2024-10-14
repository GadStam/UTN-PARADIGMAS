class Rick{
    var demencia
    const acompaniante

    method irDeAventuras(){
        try{
            acompaniante.irseDeAventurasCon(self)
        }catch e: Exception{
            self.noPuedeIrDeAventuras()
        }
    }

    method modificarNivelDeDemencia(unaCantidad){
        demencia += unaCantidad
    }

    method noPuedeIrDeAventuras(){
        self.modificarNivelDeDemencia(1000)
    }

}