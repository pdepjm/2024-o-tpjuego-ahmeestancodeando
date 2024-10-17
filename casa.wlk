object casa {
    var property vida = 3
    method recibirDanio() {
      self.vida(self.vida()-1)
    }
    method terminarJuego() = if (self.vida()==0) {
        const musica = game.sound("deathScreen.mp3")
        game.schedule(100,{musica.play()})
        musica.volume(0.4) 
        game.addVisual(pantallaFinal)
        game.schedule(500,{game.stop()})

        }
}


object pantallaFinal {
    method position() = game.at(0,0)
    method image() = "fin.jpg"
}
