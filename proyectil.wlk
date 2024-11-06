// ===============================
// Revisado por nico
// ===============================

import adminProyectiles.*
import game.*

// ===============================
// Proyectil: Clase base para proyectiles
// ===============================
class Proyectil {
    // Propiedades
    const tipo
    const position = new MutablePosition()
    const danio = tipo.danio()
    const imagen = tipo.imagen()

    // Métodos públicos
    method position() = position
    method image() = imagen
    method frenarEnemigo() = false
    method sePuedeSuperponer() = true

    // Método de movimiento
    method mover() {
        position.goRight(1)
        if (self.llegueAlFinal()) { self.eliminar() }
    }
    // Método que revisa si llego al final
    method llegueAlFinal() = position.x() >= 14
    // Método de colisión
    method colisionar() {
        const objetoEnMiCelda = game.getObjectsIn(position)
        const posicionEnFrente = new MutablePosition(x = position.x() + 1, y = position.y())
        const objetoEnFrente = game.getObjectsIn(posicionEnFrente)

        const colisionFrente = objetoEnFrente.any({ objeto => objeto.recibeDanioEnemigo(danio) })
        const colisionCelda = objetoEnMiCelda.any({ objeto => objeto.recibeDanioEnemigo(danio) })

        if (colisionFrente || colisionCelda) {
            self.destruirse()
        }
    }

    // Métodos para recibir daño
    method recibeDanioEnemigo(_danio) { return false }
    method recibeDanioMago(_danio) { return false }

    // Método para destruir el proyectil
    method destruirse() {
        if (tipo.destruirse()) { self.eliminar()}
    }

    // Método para eliminar el proyectil
    method eliminar() {
        game.removeVisual(self)
        administradorDeProyectiles.destruirProyectil(self)
    }
}


// ===============================
// Proyectil Normal: Implementación específica de un proyectil normal
// ===============================
object proyectilNormal {
    // Propiedades
    const imagen = "p.proyectilFuego.png"
    const imagenDestruido = "p.bolaDeFuegoDestruida.gif"
    const danio = 50

    // Métodos públicos
    method imagen() { return imagen }
    method imagenDestruido() { return imagenDestruido }
    method danio() = danio
    method destruirse() = true
}


// ===============================
// Proyectil Penetrante: Implementación específica de un proyectil penetrante
// ===============================
object proyectilPenetrante {
    // Propiedades
    const imagen = "p.proyectilHielo.png"
    const imagenDestruido = "p.proyectilHieloDestuido.png"
    const danio = 25

    // Métodos públicos
    method imagen() { return imagen }
    method imagenDestruido() { return imagenDestruido }
    method danio() = danio
    method destruirse() = false
}
