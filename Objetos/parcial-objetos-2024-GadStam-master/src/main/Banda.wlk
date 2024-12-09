class Banda{
	const nombre
	method nombre() = nombre
	method canon() = 1000000
	method presupuesto() = self.canon() + self.gastoPorTipoDeBanda()
	method gastoPorTipoDeBanda()
	method popularidad()



}

class BandaDeRock inherits Banda{
	const solosDeGuitarra
	override method gastoPorTipoDeBanda() = 10000
	override method popularidad() = 100*solosDeGuitarra


}

class BandaDeTrap inherits Banda{

	const tieneHielo
	override method gastoPorTipoDeBanda() = 0
	override method popularidad(){
		if(tieneHielo){
			return 1000
		}else{
			return 0
		}
	}

	override method canon(){
		if(self.popularidad() > 0){
			return super() * self.popularidad()
		}
		return 0
	}

}

class BandaIndie inherits Banda{
	const instrumentos
	override method popularidad(){
		return 3.14 * nombre.size()
	}

	override method gastoPorTipoDeBanda(){
		return instrumentos * 500
	}
}