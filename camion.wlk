import cosas.*

object camion {
	const property cosas = #{}
	const property pesoCamion = 1000 
		
	method cargar(cosa) {
		cosas.add(cosa)
		cosa.cambiar()
	}

	method descargar(cosa) {
		cosas.remove(cosa)
	}

	method todoPesoPar() {
		return cosas.all({ 
			cosa => self.esPar(cosa.peso())
		})
	}

	method esPar(numero) {
		return numero.even()
	}

	method hayAlgunoQuePesa(peso) {
		return cosas.any({
			cosa => self.pesaLaCosa(peso, cosa)
		})
	}

	method pesaLaCosa(peso, cosa) {
		return cosa.peso() == peso
	}

	method elDeNivel(nivel) {
		return cosas.find({
			cosa => self.esCosaDeNivel(cosa, nivel)
		})
	}

	method esCosaDeNivel(cosa, nivel) {
		return cosa.nivelPeligrosidad() == nivel
	}

	method pesoTotal() {
		return pesoCamion + self.pesoCarga()
	}

	method pesoCarga() {
		return cosas.sum({
			cosa => cosa.peso()
		})
	}

	method excedidoDePeso() {
		return self.pesoTotal() > self.pesoMaximo()
	}

	method pesoMaximo() {
		return 2500
	}

	method objetosQueSuperanPeligrosidad(nivel) {
		return cosas.filter({
			cosa => self.esCosaQueSuperaNivel(cosa, nivel)
		})
	}

	method esCosaQueSuperaNivel(cosa, nivel) {
		return cosa.nivelPeligrosidad() > nivel
	}

	method objetosMasPeligrososQue(cosa) {
		return self.objetosQueSuperanPeligrosidad(cosa.nivelPeligrosidad())
		
	}

	method puedeCircularEnRuta(nivelMaximoPeligrosidad) {
		return !self.excedidoDePeso() && self.cumpleNivelDePeligrosidad(nivelMaximoPeligrosidad)
	}

	method cumpleNivelDePeligrosidad(nivelMaximo) {
		return cosas.all({
			cosa => self.tieneNivelPermitido(cosa, nivelMaximo)
		})
	}

	method tieneNivelPermitido(cosa, nivelMaximo) {
		return cosa.nivelPeligrosidad() <= nivelMaximo
	}

	method tieneAlgoQuePesaEntre(min, max) {
		return cosas.all({ 
			cosa => self.pesaEntre(cosa, min, max)
		}) 
	}

	method pesaEntre(cosa, min, max) {
		return cosa.peso().between(min, max)
	}

	method cosaMasPesada() {
		return cosas.max({
			cosa => cosa.peso()
		})
	}

	method pesos() {
		return cosas.map({
			cosa => cosa.peso()
		})
	}

	method totalBultos() {
		return cosas.sum({
			cosa => cosa.bultos()
		})
	}

	method descargarEnAlmacen() {
		almacen.almacenar(cosas)
		cosas.clear()
	}

	method transportar(destino, camino) {
		
	}
}

object almacen {
	const property zonaAlmacenamiento = #{}
	var capacidad = 3

	method almacenar(cosas) {
		zonaAlmacenamiento.addAll(cosas)
	}

	method totalBultos() {
		return zonaAlmacenamiento.sum({
			cosa => cosa.bultos()
		})
	}
	
	method capacidad(_capacidad) {
		capacidad = _capacidad
	}

}

object ruta {
	method nivelPeligrosidadMaxPermitido() { return 11 } 
}

object caminos {
	var property pesoMaxSoportado = 0

	method puedeCircular(transporte) {
		return transporte.pesoTotal() <= pesoMaxSoportado
	} 
}


