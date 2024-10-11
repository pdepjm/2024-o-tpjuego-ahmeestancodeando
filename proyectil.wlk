import adminProyectiles.*
import game.*

class Proyectil {
    const tipo
    const position = new MutablePosition()
    method position() = position
    const danio = tipo.danio()
    //const imagen = tipo.imagen()
    method image() = "golondrina.png"
    method mover(){
      position.goRight(1)
        if (position.x() >= 12){
        game.removeVisual(self)
        administradorDeProyectiles.destruirProyectil(self)
      }
    }
    method queSoy() = "proyectil"
    method colisionar(){
    const posicionEnFrente = game.at(position.x() +1 ,position.y())
    const objetoEnfrente = game.getObjectsIn(posicionEnFrente).filter({ objeto => objeto.queSoy() == "zombie" })
    if (!objetoEnfrente.isEmpty()) {
      if (objetoEnfrente.first().queSoy() == "cursor") objetoEnfrente.remove(objetoEnfrente.first())
    }
    if (!objetoEnfrente.isEmpty()) {
      const objetivo = objetoEnfrente.first()
      objetivo.recibeDanio(danio)
      console.println("el objetivo: " + objetivo + " recibe daño: " + danio)
      self.destruirse()
    }
    }

    method destruirse(){
     if (tipo.destruirse()){
        game.removeVisual(self)
        administradorDeProyectiles.destruirProyectil(self)
        }
    }

}

object proyectilNormal{
var property imagen = "bolaDeFuego.png"
method imagen() = imagen
const danio = 50
method danio() = danio

method destruirse() = true
}

object proyectilPenetrante{
var property imagen = "proyecticDeMetal.png"
method imagen() = imagen

const danio = 30
method danio() = danio

method destruirse() = false

}