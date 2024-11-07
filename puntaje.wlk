// ===============================
// Revisado
// ===============================

import game.*
import administradorDeMagos.*

// ===============================
// Puntaje: Manejo de puntos
// ===============================
object puntaje {
	var property puntos = 50000

	method position() = new MutablePosition(x = 7, y = 5)
	method sumarPuntos() { self.puntos(puntos + 10 + administradorDeMagos.magos().map({mago => mago.doyPlata()}).sum())} // preguntar que opina fede | posiblemente se cambie para la presentacion del concurso
	method restarPuntos(costo) { self.puntos(puntos - costo) }

	// Métodos para mostrar el puntaje
	method text() = puntos.toString() + "$"
	method textColor() = "#FA0770"

	// Método de reset
	method reset() {
		puntos = 50 
	}
}
