object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
}
object bumblebee {
	var property transformacion = auto
	method peso() { return 800 }
	method nivelPeligrosidad() { return transformacion.peligrosidad() }
}
object paqueteDeLadrillos {
	var property ladrillos = 0 
	const pesoUnLadrillo   = 2

	method peso() { return pesoUnLadrillo * ladrillos }
	method nivelPeligrosidad() { return 2 }
}
object arenaAGranel {
	var property peso = 0
 
	method nivelPeligrosidad() { return 1 }
}
object bateriaAntiaerea {
	var property tieneLosMisiles = false

	method peso() { return if (!tieneLosMisiles) 200 else { 300 } }
	method nivelPeligrosidad() { return if (!tieneLosMisiles) 0 else { 100 } }
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

	method estibar(loQueLlega) {
	  cosas.addAll(loQueLlega)
	}
}
object residuosRadiactivos {
	var property peso = 0

	method peso() { return peso }
	method nivelPeligrosidad() { return 200 }
}
object embalajeDeSeguridad {
	var property cosaEmbalada = bumblebee

	method peso() { return cosaEmbalada.peso() }
	method nivelPeligrosidad() { return cosaEmbalada.peso()/2 }
}


// =================================================
object auto {
	method peligrosidad() { return 15 }
}


object robot {
	method peligrosidad() { return 30 }
}







