import administradorDeEnemigos.*
import casa.*
import puntaje.cantidadDeBajas


class Slime{
	const position 
  const tipo 
  var property puedeMoverse = true /*va  a servir para hacer que deje de avanzar*/
  var property vida = tipo.vida()
  method frenarEnemigo() = true
  method position() = position
  const imagen =  tipo.imagen()
  method image() = imagen
  var property danio = tipo.danio()

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

  method recibeDanioMago(_danio){return false}
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

object slimeBasico { 
  const property danio = 25
  const property vida= 150
  const  imagen="s.slimeBase.png"
  method imagen() {return imagen} 
  
}

object slimeNinja { 
  const property danio = 100
  const property vida= 50
  const imagen="s.slimeNinja.png"
  method imagen() {return imagen} 
}

object slimeGuerrero { 
  const property danio = 25
  const property vida= 150
  const imagen="s.slimeGuerrero.png"
  method imagen() {return imagen} 
}

object slimeBlessed { 
  const property danio = 150
  const property vida= 250
  const imagen="s.slimeBlessed.png"
  method imagen() {return imagen} 
}



