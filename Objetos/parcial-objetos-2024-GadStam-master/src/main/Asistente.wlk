import src.main.Banda.*
import src.main.NoTieneSaldoException.NoTieneSaldoException
import src.main.Entrada.*

class Asistente{
	var abono
	var historialEntradas = #{}
	var dinero
	method comprarEntrada(entrada){
		if(self.tieneSaldoPositivo()){
			historialEntradas.add(entrada)
			self.pagarEntrada(entrada)
		}else{
			throw new NoTieneSaldoException()
		}
	}

	method tieneSaldoPositivo(){
		return dinero > 0
	}

	method pagarEntrada(entrada){
		if(abono.tieneDescuento()){
			dinero -= abono.aplicarDescuento(entrada.precioAlPublico())
		}else{
			dinero -= entrada.precioAlPublico()
		}
	}

	method entradasAnoAnterior(){
		return historialEntradas.filter({unaEntrada => unaEntrada.esDelAnoAnterior()})
	}

	method nomberBandasQueCompro(){
		return historialEntradas.map({unaEntrada => unaEntrada.nombreBanda()})
	}

	method cantidadEntradasCompradas(){
		return historialEntradas.size()
	}

	method montoGastadoEnEntradas(){
		return historialEntradas.sum({unaEntrada => unaEntrada.precioAlPublico()})
	}

	method esVip(){
		return abono.esVip()
	}

	method aumentarDescuento(){
		abono.aumentoDescuento()
	}
}

object fan{
	method tieneDescuento() = false
	method esVip() = false
}

class Vip{
	var descuento

	method aumentoDescuento(){
		descuento += 0.1
	}
	
	method aplicarDescuento(montoAAplicar){
		return montoAAplicar * descuento
	}

	method tieneDescuento() = true

	method esVip() = true
}