import adminProyectiles.*
import game.*

class Proyectil{
    const tipo
    const position = new MutablePosition()
    const danio = tipo.danio()
    const imagen = tipo.imagen()
    
    method position() = position

    method image() = imagen

    method frenarEnemigo() = false

    method mover(){
      position.goRight(1)
        if (position.x() >= 12){
        game.removeVisual(self)
        administradorDeProyectiles.destruirProyectil(self)
      }
    }
   
    method colisionar(){
      const objetoEnMiCelda = game.getObjectsIn(position)
      const posicionEnFrente = game.at(position.x() + 1 ,position.y())
      const objetoEnFrente = game.getObjectsIn(posicionEnFrente)

    const choco1 = objetoEnFrente.map({objeto => objeto.recibeDanioEnemigo(danio)})
    const choco2 = objetoEnMiCelda.map({objeto => objeto.recibeDanioEnemigo(danio)})

    if ((!choco1.isEmpty() && choco1.contains(true)) || (!choco2.isEmpty() && choco2.contains(true))){
      self.destruirse()
    }  
    }

    method recibeDanioEnemigo(_danio){return false}
    method recibeDanioMago(_danio){return false}

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