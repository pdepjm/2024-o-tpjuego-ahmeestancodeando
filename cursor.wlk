import wollok.game.*

object cursor {
  var property position = new MutablePosition(x=7, y=3)
  var property vida = 3  // Le doy una propiedad vida para que reciba daño cuando choca con un zombie

  method perderVida(danio) { vida -= danio}

  method image() = "marcoRojo.png"
  
  method accion(){
    keyboard.right().onPressDo({ self.moverseDerecha() })
    keyboard.left().onPressDo({ self.moverseIzquierda() })
    keyboard.up().onPressDo({ self.moverseArriba() })
    keyboard.down().onPressDo({ self.moverseAbajo() })
  }

  method moverseDerecha() = if (self.position().x()<14) position.goRight(1)
  method moverseIzquierda() = if (self.position().x()>0) position.goLeft(1)
  method moverseArriba() = if (self.position().y()<4) position.goUp(1)
  method moverseAbajo() = if (self.position().y()>0) position.goDown(1)

  method noEstaViva() = vida < 0

  method morir(){
    if (self.noEstaViva()){ game.say(self, "Durisimo Helmano")} // Delego la resonsabilidad de morir a pepita
  }
}
