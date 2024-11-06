import administradorDeEnemigos.*
import administradorDeJuego.*
import wollok.game.*
import slime.*
object casa {
  //method explosion() = game.sound("m.explosion.mp3") // efecto de explosion cuando llegan al fin de la pantlla
    var property vida = 1
    method recibirDanio(fila) {
    vida -= 1
    administradorDeEnemigos.enemigos().filter({enemigo => enemigo.position().y() == fila}).map({enemigo => enemigo.eliminar()})// elimina enemigos de la misma fila
     // self.explosion().volume(0.4)
     // self.explosion().play()
      if(vida <= 0) {administradorDeJuego.terminarJuego()}
      
    }



    
    method reset() {
        vida=1
    }
    
}
