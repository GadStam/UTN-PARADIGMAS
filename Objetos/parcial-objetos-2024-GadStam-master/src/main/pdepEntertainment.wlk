import src.main.Banda.*
import src.main.NoTieneSaldoException.NoTieneSaldoException
import src.main.Asistente.*
import src.main.Entrada.*

object pdepEntretainment{

	var impuestoPorProductora = 0.10
	method impuestoPorProductora(){
		return impuestoPorProductora
	}

	var asistentes = #{}
	var bandas = #{}
	method gananciaTotal(){
		return self.montoTotalGastadoEnEntradas() - self.presupuestoTotalDeBandas()
	}

	method presupuestoTotalDeBandas(){
		return bandas.sum({unaBanda => unaBanda.presupuesto()})
	}

	method montoTotalGastadoEnEntradas(){
		return asistentes.sum({unAsistente => unAsistente.montoGastadoEnEntradas()})
	}

	method entradasVendidas(){
		return asistentes.sum({unAsistente => unAsistente.cantidadEntradasCompradas()})
	}

	method bandaMasPopular(){
		return bandas.max({unaBanda => unaBanda.popularidad()})
	}

	method bonificicarAsitentesVip(){
		const asistentesVip = asistentes.filter({unAsistente => unAsistente.esVip()})
		asistentesVip.forEach({unAsistente => unAsistente.aumentarDescuento()})
	}

}