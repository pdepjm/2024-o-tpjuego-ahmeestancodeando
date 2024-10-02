class Fantasmas {
  const position = new MutablePosition()
  var property estado= "movil"
  var property zombie = "zombie"

  method position() = position

  method movete() {
    if(self.estado()=="movil")
      position.goLeft(1)
    else zombie.moveteDerecha()
  }
  method moveteDerecha() {
    position.goRight(1)
  }
}