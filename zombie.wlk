
class ZombiesNormales {
	const position = new MutablePosition(x=10, y=0.randomUpTo(5).truncate(0))
  var property moverse = true /*va  a servir para hacer que deje de avanzar*/
  method position() = position
  var property imagen = "durisimoHelmano.gif"
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

const pepe = new ZombiesNormales()