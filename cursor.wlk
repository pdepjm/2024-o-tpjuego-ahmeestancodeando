// ===============================
// Revisado
// ===============================

import wollok.game.*

// ===============================
// Cursor: Controlador de movimiento
// ===============================
object cursor {
    // Propiedad de posición
    var property position = new MutablePosition(x = 7, y = 3)

    // Método de imagen del cursor
    method image() = "marcosRojo.png"

    // Acciones del teclado
    method accion() {
        keyboard.right().onPressDo({ self.moverseDerecha() })
        keyboard.left().onPressDo({ self.moverseIzquierda() })
        keyboard.up().onPressDo({ self.moverseArriba() })
        keyboard.down().onPressDo({ self.moverseAbajo() })
    }

    // Métodos de movimiento
    method moverseDerecha() = if (self.position().x() < 12) position.goRight(1)
    method moverseIzquierda() = if (self.position().x() > 1) position.goLeft(1)
    method moverseArriba() = if (self.position().y() < 4) position.goUp(1)
    method moverseAbajo() = if (self.position().y() > 0) position.goDown(1)

    // Interacciones con enemigos
    method frenarEnemigo() = false
    method recibeDanioEnemigo(_danio) { return false }
    method recibeDanioMago(_danio) { return false }
    method matarSlime() {}
    
}