import adminProyectiles.*
import game.*
import colisionExtra.*

class Proyectil inherits Colision{
    const tipo
    const position = new MutablePosition()
    method position() = position
    const property danio = tipo.danio()
    var imagen = tipo.imagen()
    
    method mover(){
      position.goRight(1)
        if (position.x() >= 12){
        game.removeVisual(self)
        administradorDeProyectiles.destruirProyectil(self)
      }
    }
    method queSoy() = "proyectil"
   
    method colisionar(){
      const objetoEnMiCelda = self.colisionEnFrente(self.position(),"zombie")
      const posicionEnFrente = game.at(position.x() + 1 ,position.y())
      const objetoEnFrente = self.colisionEnFrente(posicionEnFrente, "zombie")
      if (objetoEnMiCelda.queSoy() == "zombie") {
      imagen = tipo.imagenDestruido()
      objetoEnMiCelda.recibeDanio(danio)
      self.destruirse()
    } else if (objetoEnFrente.queSoy() == "zombie"){
      imagen = tipo.imagenDestruido()
      objetoEnFrente.recibeDanio(danio)
      self.destruirse()
    }
    }


    method destruirse(){
     if (tipo.destruirse()){
        
        //game.removeTickEvent("destruirBoladefuego")
        game.schedule(180,{game.removeVisual(self)  administradorDeProyectiles.destruirProyectil(self)  })
        }
    }

    method image() = imagen
}

object proyectilNormal{
const imagen = "bolaDeFuego2.png"
const imagenDestruido = "bolaDeFuegoDestruida.gif"
method imagen() {return imagen} 
method imagenDestruido() {return imagenDestruido} 
const danio = 75
method danio() = danio

method destruirse() = true
}

object proyectilPenetrante{
const imagen = "fedeValverde.png"
const imagenDestruido = "fedeValverde.png"
method imagen() {return imagen} 
method imagenDestruido(){return imagenDestruido} 
const danio = 30
method danio() = danio

method destruirse() = false

}