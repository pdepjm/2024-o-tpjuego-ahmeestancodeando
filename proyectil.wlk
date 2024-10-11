import adminProyectiles.*
import game.*

class Proyectil {
    const tipo
    const position = new MutablePosition()
    method position() = position
    const danio = tipo.danio()
    const imagen = tipo.imagen()
    method image() = "bolaDeFuego2.png"
    method mover(){
      position.goRight(1)
        if (position.x() >= 12){
        game.removeVisual(self)
        administradorDeProyectiles.destruirProyectil(self)
      }
    }
    method queSoy() = "proyectil"
    method colisionar(){
    const posicionEnFrente = game.at(position.x() + 1 ,position.y())
    const objetosEnMiCelda = game.getObjectsIn(game.at(position.x(),position.y())).filter({objeto => objeto.queSoy() == "zombie"}) // para que impacte en los enemigos cuando el disparo aparece
    const objetosEnfrente = game.getObjectsIn(posicionEnFrente).filter({objeto => objeto.queSoy() == "zombie"}) // si no aplico el filter en ambas colecciones tira error diciendo que proyectil no entiende recibir danio
    objetosEnfrente.addAll(objetosEnMiCelda)
    if (!objetosEnfrente.isEmpty()) {
      const objetivo = objetosEnfrente.first()
      objetivo.recibeDanio(danio)
      // console.println("el objetivo: " + objetivo + " recibe daño: " + danio)
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
const imagen = "bolaDeFuego2.png"
method imagen() {return imagen} 
const danio = 50
method danio() = danio

method destruirse() = true
}

object proyectilPenetrante{
const imagen = "fedeValverde.png"
method imagen() {return imagen} 

const danio = 30
method danio() = danio

method destruirse() = false

}