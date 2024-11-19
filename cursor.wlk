// ===============================
// Revisado
// ===============================

import wollok.game.*
import administradorDeJuego.administradorDeJuego
// ===============================
// Cursor: Controlador de movimiento
// ===============================
object cursor {
    const celdaMaxima = 9


    // Propiedad de posición
    var property position = new MutablePosition(x = 7, y = 3)

    // Método de imagen del cursor
    method image() = "marcosRojo.png"

    // Acciones del teclado
    method accion() {
        keyboard.right().onPressDo({ if(!administradorDeJuego.pausado()&& !administradorDeJuego.usuarioEnMenu()){self.moverseDerecha()} })
        keyboard.left().onPressDo({ if(!administradorDeJuego.pausado()&& !administradorDeJuego.usuarioEnMenu()){self.moverseIzquierda()} })
        keyboard.up().onPressDo({ if(!administradorDeJuego.pausado()&& !administradorDeJuego.usuarioEnMenu()){self.moverseArriba() }})
        keyboard.down().onPressDo({ if(!administradorDeJuego.pausado()&& !administradorDeJuego.usuarioEnMenu()){self.moverseAbajo()} })
    }

    // Métodos de movimiento
    method moverseDerecha() = if (self.position().x() < celdaMaxima) position.goRight(1)
    method moverseIzquierda() = if (self.position().x() > 1) position.goLeft(1)
    method moverseArriba() = if (self.position().y() < 4) position.goUp(1)
    method moverseAbajo() = if (self.position().y() > 0) position.goDown(1)

    // Interacciones con enemigos
    method frenarEnemigo() = false
    method recibeDanioEnemigo(_danio) { return false }
    method recibeDanioMago(_danio) { return false }
    method combinarProyectil(_tipo){return false}
    method matarSlime(){return false}
    method tipoProyectil()=false
}