
class ZombiesNormales {
	const position 
  var property moverse = true /*va  a servir para hacer que deje de avanzar*/
  method position() = position
  var property imagen = "slime base.png"
  method image() = imagen

  method movete() {
    if(self.moverse())
      return position.goLeft(1)
    else self.moverse(false)
  }
  method moveteDerecha() {
    return position.goRight(1)
  }

  var property danio = 1

}

