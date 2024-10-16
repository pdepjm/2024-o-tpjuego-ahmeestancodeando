import generadorDeEnemigos.*
import adminProyectiles.*
import casa.*
import colisionExtra.Colision
class SlimeBasico inherits Colision{
	const position 
  var property moverse = true /*va  a servir para hacer que deje de avanzar*/
  var property vida = 200
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
    const posicionEnFrente = game.at(self.position().x()-1, self.position().y())
    const objeto = self.colisionEnFrente(posicionEnFrente, "mago", "zombie")
    if (objeto.queSoy() != "nada"){ // solo frena cuando se choca contra un enemigo o una planta
      self.moverse(false)
      if (objeto.queSoy() == "mago") objeto.recibeDanio(danio)
    }
    else{self.moverse(true)} //Agregue el self.moverse(true) para que cuando maten la planta se sigan moviendo
  }

  var property danio = 50

  method recibeDanio(_danio) {
    self.vida(self.vida() - _danio)
  }

  method estaMuerto(){
    if (vida <= 0 || position.x() < 0){
      game.removeVisual(self)
      generadorDeEnemigos.eliminarEnemigo(self)
      }
    return vida <= 0 || position.x() <= 0

  }

  method daniarCasa(){
    casa.recibirDanio()
    casa.terminarJuego()
  }
}

//const jose = new SlimeBasico(position= new MutablePosition(x=10, y=0.randomUpTo(5).truncate(0)))

//const otroZombie = new SlimeBasico(position= new MutablePosition(x=3, y=3))