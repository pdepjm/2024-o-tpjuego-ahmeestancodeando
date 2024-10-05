import fantasma.Fantasmas
class ZombiesNormales {
	const position 
  var property moverse = true /*va  a servir para hacer que deje de avanzar*/
  method position() = position
  var property imagen = "slime base.png"
  method image() = imagen
  method queSoy() = "zombie"
  method movete() {
    self.meFreno()
    if(self.moverse())
      return position.goLeft(1)
    else self.moverse(false)
  }
  method moveteDerecha() {
    return position.goRight(1)
  }
  method meFreno(){
    const posicionFantasma = game.at(self.position().x()-1, self.position().y())
    const fantasma = new Fantasmas(position=posicionFantasma)
    game.addVisual(fantasma)
    if (fantasma.colision()){
      
      self.moverse(false)
      game.removeVisual(fantasma)
    }
    else {game.removeVisual(fantasma) 
    }
  }
  var property danio = 1

}

