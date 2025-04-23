import cosas.*

object camion {
	const property cosas = #{}
	const property tara = 1000 
		
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
		return tara + self.pesoCarga()
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

	method descargarEn(destino) {
		destino.almacenar(cosas, self.totalBultos())
		cosas.clear()
	}

	method transportar(destino, camino) {
		self.validarTransporte(destino, camino)
		self.descargarEn(destino)
	}

	method validarTransporte(destino, camino) {  
		destino.validar(self)
		camino.validar(self)
	}
}

object almacen {
	const property zonaAlmacenamiento = #{}
	var property capacidad = 3

	method almacenar(cosas, bultosDescarga) {
		zonaAlmacenamiento.addAll(cosas)
		capacidad += bultosDescarga
	}

	method totalBultos() {
		return zonaAlmacenamiento.sum({
			cosa => cosa.bultos()
		})
	}
	
	method validar(transporte) {
		if ( ! self.hayLugarParaCargaDe(transporte) ) {
			self.error("destino sin espacio suficiente para albergar carga.")
		} 
	}

	method hayLugarParaCargaDe(transporte) {
		return capacidad >= self.totalBultos() + transporte.totalBultos()
	}
}

object ruta9 {
	method nivelPeligrosidadMaxPermitido() { return 11 } 

	method validar(transporte) {
		if (! self.puedeCircular(transporte)) {
			self.error("no se cumple reglamentación para circular por este camino.")
		}
	}

	method puedeCircular(transporte) {
		return transporte.puedeCircularEnRuta(self.nivelPeligrosidadMaxPermitido()) 
	} 
}

object caminos {
	var property pesoMaxSoportado = 1500

	method validar(transporte) {
		if (! self.puedeCircular(transporte)) {
			self.error("no se cumple reglamentación para circular por este camino.")
		}
	}

	method puedeCircular(transporte) {
		return transporte.pesoTotal() <= pesoMaxSoportado
	} 
}


