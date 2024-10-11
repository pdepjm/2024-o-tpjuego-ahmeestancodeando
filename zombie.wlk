import generadorDeEnemigos.*
import adminProyectiles.*

import fantasma.Fantasmas
class ZombiesNormales {
	const position 
  var property moverse = true /*va  a servir para hacer que deje de avanzar*/
  var property vida = 100
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

  method meFreno(){
    const posicionFantasma = game.at(self.position().x()-1, self.position().y())
    const fantasma = new Fantasmas(position=posicionFantasma)
    game.addVisual(fantasma)
    if (fantasma.colision().queSoy() == "mago" || fantasma.colision().queSoy() == "zombie"){ // solo frena cuando se choca contra un enemigo o una planta
      self.moverse(false)
      game.removeVisual(fantasma)
      if (fantasma.colision().queSoy() == "mago") fantasma.colision().recibeDanio(danio)
    }
    else {
      game.removeVisual(fantasma)
      self.moverse(true) //Agregue el self.moverse(true) para que cuando maten la planta se sigan moviendo
      }
  }

  var property danio = 50

  method recibeDanio(_danio) {
    self.vida(self.vida() - _danio)
  }
  
  method sigueVivo(){
    if (vida <= 0 || position.x() <= 0){
      game.removeVisual(self)
      generadorDeEnemigos.eliminarEnemigo(self)
      }


  }

}

//const jose = new ZombiesNormales(position= new MutablePosition(x=10, y=0.randomUpTo(5).truncate(0)))

//const otroZombie = new ZombiesNormales(position= new MutablePosition(x=3, y=3))