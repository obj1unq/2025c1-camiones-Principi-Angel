object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }

	method bultos() { return 1 }

	method cambiar() {

	}
}
object bumblebee {
	var property transformacion = auto

	method peso() { return 800 }
	method nivelPeligrosidad() { return transformacion.peligrosidad() }

	method bultos() { return 2 }

	method cambiar() { self.transformarA(robot)}

	method transformarA(modo) { transformacion = modo }
}
object paqueteDeLadrillos {
	var property ladrillos = 1 
	const pesoUnLadrillo   = 2

	method peso() { return pesoUnLadrillo * ladrillos }
	method nivelPeligrosidad() { return 2 }

	method bultos() {
		return if (ladrillos.between(1, 100)) 1 
				else if (ladrillos.between(101, 300)) 2
				   else 3
	}

	method cambiar() { ladrillos += 12}
}
object arenaAGranel {
	var property peso = 0
 
	method nivelPeligrosidad() { return 1 }

	method bultos() { return 1 }

	method cambiar() { self.agregarPeso(12)}

	method agregarPeso(agregado) {
		peso += agregado
	}
}
object bateriaAntiaerea {
	var property tieneLosMisiles = false

	method peso() { return if (!tieneLosMisiles) 200 else { 300 } }
	method nivelPeligrosidad() { return if (!tieneLosMisiles) 0 else { 100 } }

	method bultos() { return if (!tieneLosMisiles) 1 else 2	}

	method cambiar() { self.tieneLosMisiles(true) }
}
object contenedorPortuario {
	var property cosas    = #{} 
	var property pesoBase = 100

	method peso() { return pesoBase + self.pesoCosas() }
	method nivelPeligrosidad() { 
		return if (self.estaVacio()) 0 else self.cosaMasPeligrosa().nivelPeligrosidad() }

	method estaVacio() {
		return cosas.isEmpty()
	}

	method cosaMasPeligrosa() {
		return cosas.max({
			cosa => cosa.nivelPeligrosidad()
		})
	}

	method pesoCosas() {
		return cosas.sum({
			cosa => cosa.peso()
		})
	}

	method bultos() { 
		return 1 + self.cantBultosCosas()
	}

	method cantBultosCosas() { 
		return cosas.sum({
			cosa => cosa.bulto()
		})
	}

	method cambiar() { 
		cosas.forEach({
			cosa => cosa.cambiar()
		})
	}
}
object residuosRadiactivos {
	var property peso = 0

	method peso() { return peso }
	method nivelPeligrosidad() { return 200 }

	method bultos() { return 1 }

	method cambiar() { self.agregarPeso(15) }

	method agregarPeso(agregado) {
		peso += agregado
	} 
}
object embalajeDeSeguridad {
	var property bultos = 2
	var property cosaEmbalada = bumblebee

	method peso() { return cosaEmbalada.peso() }
	method nivelPeligrosidad() { return cosaEmbalada.peso()/2 }

	method bultos() { return 2 }

	method cambiar() { }
}


// =================================================
object auto {
	method peligrosidad() { return 15 }
}


object robot {
	method peligrosidad() { return 30 }
}







