object pepita {
  const position = new MutablePosition(x=0, y=0)

  method image() = "golondrina.png"
  method position() = position

  method moverseDerecha(casillas) {
    position.goRight(casillas)
  }
  method moverseIzquierda(casillas) {
    position.goLeft(casillas)
  }
  method moverseArriba(casillas) {
    position.goUp(casillas)
  }
  method moverseAbajo(casillas) {
    position.goDown(casillas)
  }

}