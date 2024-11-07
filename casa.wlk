// ===============================
// Revisado
// ===============================

import administradorDeEnemigos.*
import administradorDeJuego.*
import wollok.game.*
import slime.*

// ===============================
// Objeto: Casa
// ===============================
object casa {
  const vidaMax = 3
  method sonidoDanio() = game.sound("m.explosion.mp3") // efecto de explosion cuando llegan al fin de la pantlla
  var property vida = vidaMax

  method recibirDanio(fila) {
    vida -= 1
    administradorDeEnemigos.enemigos().filter({enemigo => enemigo.position().y() == fila}).map({enemigo => enemigo.matar()})// elimina enemigos de la misma fila
    self.sonidoDanio().volume(0.4)
    //self.explosion().play()
    if(vida <= 0) {
      pantalla.estado(derrota)
      administradorDeJuego.terminarJuego()
    }
  }

  method reset() {
      vida = vidaMax
  }
}
