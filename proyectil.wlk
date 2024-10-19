import adminProyectiles.*
import game.*
import colisionExtra.*

class Proyectil inherits Colision{
    const tipo
    const position = new MutablePosition()
    method position() = position
    const imagen = tipo.imagen()
    method image() = imagen
    method mover(){
      position.goRight(1)
        if (position.x() >= 12){
        game.removeVisual(self)
        administradorDeProyectiles.destruirProyectil(self)
      }
    }
    method queSoy() = "proyectil"
   
    method colisionar(){
      var danio = tipo.danio()
      const objetoEnMiCelda = self.colisionEnFrente(self.position(),"zombie")
      const posicionEnFrente = game.at(position.x() + 1 ,position.y())
      const objetoEnFrente = self.colisionEnFrente(posicionEnFrente, "zombie")
      if (objetoEnMiCelda.queSoy() == "zombie") {
      objetoEnMiCelda.recibeDanio(danio)
      self.destruirse()
      
    } else if (objetoEnFrente.queSoy() == "zombie"){
      objetoEnFrente.recibeDanio(danio)
      self.destruirse()
    }
    danio = 0
    }


    method destruirse(){
     if (tipo.destruirse()){
        game.removeVisual(self)
        administradorDeProyectiles.destruirProyectil(self)
        }
    }


}

object proyectilNormal{
const imagen = "bolaDeFuego2.png"
const imagenDestruido = "bolaDeFuegoDestruida.gif"
method imagen() {return imagen} 
method imagenDestruido() {return imagenDestruido} 
const danio = 50
method danio() = danio

method destruirse() = true
}

object proyectilPenetrante{
const imagen = "fedeValverde.png"
const imagenDestruido = "fedeValverde.png"
method imagen() {return imagen} 
method imagenDestruido() {return imagenDestruido} 
const danio = 25
method danio() = danio

method destruirse() = false

}