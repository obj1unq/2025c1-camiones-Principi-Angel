import cosas.*

object camion {
	const property cosas = #{}
	const property pesoCamion = 1000 
		
	method cargar(cosa) {
		cosas.add(cosa)
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

	// method esMasPeligrosoQue(objeto, cosa) {
	// 	return objeto.nivelPeligrosidad() > cosa.nivelPeligrosidad()
	// }

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


}


