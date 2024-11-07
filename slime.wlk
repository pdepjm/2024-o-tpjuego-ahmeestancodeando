// ===============================
// Revisado
// ===============================

import administradorDeEnemigos.*
import casa.*
// ===============================
// Clase Base: Slime
// ===============================
class Slime {
    // Propiedades
    const position
    const tipo 
    var property enMovimiento = true // Indica si el slime puede moverse
    var property vida = tipo.vida()
    var property danio = tipo.danio()

    // Métodos de visualización y estado
    method frenarEnemigo() = true
    method position() = position
    method image() = tipo.imagen()
    method sePuedeSuperponer() = false


    // Movimiento del Slime
    method movete() {
        self.meFreno()
        if (self.enMovimiento()) 
            return position.goLeft(tipo.desplazamiento())
        else 
            self.enMovimiento(false)
    }

    // Lógica para frenar el movimiento
    method meFreno() {
        const posicionEnFrente = new MutablePosition(x = self.position().x() - 1, y = self.position().y())
        const objetoEnCeldaEnFrente = game.getObjectsIn(posicionEnFrente)

        if (objetoEnCeldaEnFrente.any({ objeto => objeto.frenarEnemigo() })) { 
            self.enMovimiento(false)
            objetoEnCeldaEnFrente.map({ objeto => objeto.recibeDanioMago(danio) })
        } else {
            self.enMovimiento(true)
        }
    }

    // Métodos para recibir daño
    method recibeDanioMago(_danio) = false

    method recibeDanioEnemigo(_danio) {
        self.vida(self.vida() - _danio)
        return true
    }

    // Comprobación de estado de vida y eliminación
    method estaMuerto() {
        if (self.llegoACasa()) {
            casa.recibirDanio(self.position().y())
            self.eliminar()
        } else if (self.sinVida()) {
            self.eliminar()
        }
        return self.sinVida() || self.llegoACasa()
    }

    method sinVida() = vida <= 0
    method llegoACasa() = self.position().x() < 0
    method matarSlime() { vida = 0 }

    // Eliminación del Slime
    method eliminar() {
        game.removeVisual(self)
        administradorDeEnemigos.eliminarEnemigo(self)
    }
}
// ===============================
// Tipos de Slime: Variantes
// ===============================
  object slimeBasico { 
    const property danio = 25
    const property vida= 150
    method desplazamiento() = 1
    const  imagen="s.slimeBase.png"
    method imagen() {return imagen} 
    
  }

  object slimeNinja { 
    const property danio = 200
    const property vida= 120
    method desplazamiento() = 2
    const imagen="s.slimeNinja.png"
    method imagen() {return imagen} 
    
  }

  object slimeGuerrero { 
    const property danio = 25
    const property vida= 150
    method desplazamiento() = 1
    const imagen = "s.slimeGuerrero.png"
    method imagen() {return imagen} 
  }

  object slimeBlessed { 
    const property danio = 150
    const property vida= 250
    method desplazamiento() = 1
    const imagen="s.slimeBlessed.png"
    method imagen() {return imagen} 
  }



