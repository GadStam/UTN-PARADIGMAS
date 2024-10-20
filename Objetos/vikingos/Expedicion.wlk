class Expedicion{
   
}

class Capital{
    var defensor
    var factorRiqueza
    method botin(){
        return defensor * factorRiqueza
    }

    method alMenosTresMonedasPorSoldado(cantSoldados){
        return self.botin() >= cantSoldados * 3
    }
}

class Aldea{

}