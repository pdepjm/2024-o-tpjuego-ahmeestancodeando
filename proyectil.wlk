import adminProyectiles.*
import game.*


class Proyectil {
    const tipo
    var property position
    const danio = tipo.danio()
    const imagen = tipo.imagen()
    method imagen() = imagen
    method mover(){
      self.position().goRight(1)
      if (self.position().x() > 12) game.removeVisual(self)
    }
    method queSoy() = "proyectil"
    method colisionar(){ 
    const objetoEnfrente = game.getObjectsIn(self.position()).filter({ objeto => objeto.queSoy() != "fantasma" })
    objetoEnfrente.filter({objeto => objeto.queSoy() != "mago"})
    objetoEnfrente.filter({objeto => objeto.queSoy() != "proyectil"})
    if (!objetoEnfrente.isEmpty()) {
      if (objetoEnfrente.first().queSoy() == "cursor") objetoEnfrente.remove(objetoEnfrente.first())
    }
    if (!objetoEnfrente.isEmpty()) {
      const objetivo = objetoEnfrente.first()
      objetivo.recibeDanio(danio)
      tipo.destruirse()
    }
    }

    method destruirse(){
     if (tipo.destruirse()){
        game.removeVisual(self)
        administradorDeProyectiles.proyectiles.remove(self)
        }
    }

}

object proyectilNormal{
var property imagen = "bolaDeFuego.png"
method imagen() = imagen
const danio = 50
method danio() = danio

method destruirse(proyectil){
    game.removeVisual(proyectil)
}
}

object proyectilPenetrante{
var property imagen = "proyecticDeMetal.png"
method imagen() = imagen

const danio = 30
method danio() = danio

method destruirse(){}

}