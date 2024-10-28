import wollok.game.*

object cursor {
  var property position = new MutablePosition(x=7, y=3)

  method image() = "marcosRojo.png"
  
  method accion(){
    keyboard.right().onPressDo({ self.moverseDerecha() })
    keyboard.left().onPressDo({ self.moverseIzquierda() })
    keyboard.up().onPressDo({ self.moverseArriba() })
    keyboard.down().onPressDo({ self.moverseAbajo() })
  }

  method moverseDerecha() = if (self.position().x()<12) position.goRight(1)
  method moverseIzquierda() = if (self.position().x()>1) position.goLeft(1)
  method moverseArriba() = if (self.position().y()<4) position.goUp(1)
  method moverseAbajo() = if (self.position().y()>0) position.goDown(1)

  method frenarEnemigo() = false
  method recibeDanioEnemigo(_danio){return false}
  method recibeDanioMago(_danio){return false}

}
