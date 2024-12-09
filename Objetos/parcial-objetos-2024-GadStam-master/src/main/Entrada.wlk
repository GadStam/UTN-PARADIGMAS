import src.main.NoTieneSaldoException.NoTieneSaldoException
import src.main.pdepEntertainment.pdepEntretainment
import src.main.Banda.*
class Entrada{
	const banda
	const fecha
	
	method precioAlPublico() = 1000 + pdepEntretainment.impuestoPorProductora()

	method esDelAnoAnterior(){
		const fechaActual = new Date()
		return fecha.year() == fechaActual.minusYears(1)
	}

	method nombreBanda(){
		return banda.nombre()
	}
}