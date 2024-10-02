
class ZombiesNormales {
	const position = new MutablePosition(x=10, y=0.randomUpTo(5).truncate(0))
  var property estado= "movil"
  method position() = position
  var property imagen = "golondrina.png"
  method image() = imagen

  method movete() {
    if(self.estado()=="movil")
      return position.goLeft(1)
    else self.estado("frenado")
  }
  method moveteDerecha() {
    return position.goRight(1)
  }
}

