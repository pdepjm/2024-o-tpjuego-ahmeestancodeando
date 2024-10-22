import administradorDeEnemigos.*
import casa.*
import puntaje.cantidadDeBajas
class SlimeBasico{
	const position 
  var property puedeMoverse = true /*va  a servir para hacer que deje de avanzar*/
  var property vida = 100
  method frenarEnemigo() = true
  method position() = position
  var property imagen = "slime base.png"
  method image() = imagen
  method movete() {
    self.meFreno()
    if(self.puedeMoverse())
      return position.goLeft(1)
    else self.puedeMoverse(false)
  }

  method meFreno(){
    const posicionEnFrente = game.at(self.position().x()-1, self.position().y())
    const objetoEnCeldaEnFrente = game.getObjectsIn(posicionEnFrente)
    if (objetoEnCeldaEnFrente.any({objeto => objeto.frenarEnemigo()})){ // solo frena cuando se choca contra un enemigo o una planta
      self.puedeMoverse(false)
      objetoEnCeldaEnFrente.map({objeto => objeto.recibeDanioMago(danio)})
    }
    else{self.puedeMoverse(true)} //Agregue el self.moverse(true) para que cuando maten la planta se sigan moviendo
  }

  var property danio = 50

  method recibeDanioMago(_danio){return false}
  method recibeDanioProyectil(_danio){return false}
  method recibeDanioEnemigo(_danio){
    self.vida(self.vida() - _danio)
    return true
  }

  method estaMuerto(){
    if (self.position().x() < 0){
      casa.recibirDanio()
      casa.terminarJuego()
      game.removeVisual(self)
      administradorDeEnemigos.eliminarEnemigo(self)
    }
    else if (self.vida()<=0){
      cantidadDeBajas.agregarBaja()
      game.removeVisual(self)
      administradorDeEnemigos.eliminarEnemigo(self)
      } 
    return vida <= 0 || position.x() <= 0
  }
}



//const jose = new SlimeBasico(position= new MutablePosition(x=10, y=0.randomUpTo(5).truncate(0)))

//const otroZombie = new SlimeBasico(position= new MutablePosition(x=3, y=3))

//const grupo = [jose,otroZombie]