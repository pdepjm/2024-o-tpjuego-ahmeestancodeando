import wollok.game.*

object pepita {
  const position = new MutablePosition(x=0, y=0)

  var property vida = 3  // Le doy una propiedad vida para que reciba daño cuando choca con un zombie

  method perderVida(danio) { vida -= danio}

  method image() = "marcoRojo.png"
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

  method noEstaViva() = vida < 0

  method morir(){
    if (self.noEstaViva()){ game.say(self, "Durisimo Helmano")} // Delego la resonsabilidad de morir a pepita
  }
}
