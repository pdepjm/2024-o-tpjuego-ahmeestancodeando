import iniciarJuego.*
import administradorDeEnemigos.*
object casa {
  //method explosion() = game.sound("m.explosion.mp3") // efecto de explosion cuando llegan al fin de la pantlla
    var property vida = 3
    method recibirDanio(fila) {
      self.vida(self.vida()-1)
      administradorDeEnemigos.enemigos().filter({enemigo => enemigo.position().y() == fila}).map({enemigo => enemigo.recibeDanioEnemigo(10000)}) // elimina enemigos de la misma fila
     // self.explosion().volume(0.4)
     // self.explosion().play()
    }
    method terminarJuego() = if (self.vida()==0) {
        const musica2 = game.sound("m.deathScreen.mp3")
        configuracion.detenerMusica()
        game.schedule(100,{musica2.play()})
        musica2.volume(0.4) 
        game.addVisual(pantallaFinal)
        game.schedule(500,{game.stop()})

        }
}


object pantallaFinal {
    method position() = game.at(0,0)
    method image() = "fin.jpg"
}
