object casa {
    var property vida = 3
    method recibirDanio() {
      self.vida(self.vida()-1)
    }
    method terminarJuego() = if (self.vida()==0) {
        
        game.addVisual(pantallaFinal)
        game.schedule(500,{game.stop()})
        }
}


object pantallaFinal {
    method position()=game.at(0,0)
    method image()= "fin.jpg"
}
