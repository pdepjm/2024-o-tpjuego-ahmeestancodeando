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
    const property danio = tipo.danio()

    // Métodos de visualización y estado
    method frenarEnemigo() = true
    method position() = position
    method image() = tipo.imagen()
    method sePuedeSuperponer() = false


    // Movimiento del Slime
    method movete() { 
        self.meFreno()
        if (self.enMovimiento()) 
            position.goLeft(tipo.desplazamiento())
            if(self.llegoACasa()){
            casa.recibirDanio(self.position().y())
            return
        }
        else 
            self.enMovimiento(false) 
        
    }

    // Lógica para frenar el movimiento
    method meFreno() {
        const posicionEnFrente = new MutablePosition(x = self.position().x() - 1, y = self.position().y())
        const objetoEnCeldaEnFrente = game.getObjectsIn(posicionEnFrente)

        if (objetoEnCeldaEnFrente.any({ objeto => objeto.frenarEnemigo() })) { 
            self.enMovimiento(false)
            objetoEnCeldaEnFrente.forEach({ objeto => objeto.recibeDanioMago(danio) })
        } else {
            self.enMovimiento(true)
        }
    }

    // Métodos para recibir daño
    method recibeDanioMago(_danio){}

    method recibeDanioEnemigo(_danio) {
        self.vida(self.vida() - _danio)
        self.estaMuerto()
        return true
    }

    // Comprobación de estado de vida y eliminación
    method estaMuerto() {
        if (self.sinVida()) self.eliminar()
        return self.sinVida()
    }

    method sinVida() = vida <= 0
    method llegoACasa() = self.position().x() < 0
    method matarSlime() {self.eliminar()}

    // Eliminación del Slime
    method eliminar() {
        game.removeVisual(self)
        administradorDeEnemigos.eliminarEnemigo(self)
    }
    method combinarProyectil(proyectil) {return false}
}
// ===============================
// Tipos de Slime: Variantes
// ===============================
  object slimeBasico { 
    const property danio = 25
    const property vida= 100
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



