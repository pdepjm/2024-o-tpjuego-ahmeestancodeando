import administradorDeMagos.*
import puntaje.*
import proyectil.*
import adminProyectiles.*
import slime.*
import administradorDeEnemigos.*
class Mago {
  const position
  var property vida
  var property imagen

  method frenarEnemigo() = true

  method enemigoEnSuFila() = administradorDeEnemigos.enemigos().any({enemigo => enemigo.position().y()==self.position().y()})


  method position() = position
  
  method image() = imagen

  method disparar(){}
  
  method recibeDanioEnemigo(_danio){return false}
  method recibeDanioMago(_danio) {
    self.vida(self.vida() - _danio)
    return false
  }

  method sePuedeSuperponer() = false
  
  method estaMuerto(){
    if (vida <= 0 && game.hasVisual(self)) {
      game.removeVisual(self)
      administradorDeMagos.eliminarMago(self)
    }

    return vida <= 0
  }

    method eliminar(){
      game.removeVisual(self)
      administradorDeMagos.eliminarMago(self)
    }


}

class MagoFuego inherits Mago(vida=100,imagen="magoFuego.png"){

  override method disparar(){
    const posicionProyectil = new MutablePosition(x = self.position().x() + 1, y = self.position().y())
    if (self.enemigoEnSuFila()){
      administradorDeProyectiles.generarProyectil(posicionProyectil, proyectilNormal) 
    }
  }
  
}
class MagoIrlandes inherits Mago(vida=100, imagen="magoHealer.png") {
 
  override method estaMuerto(){

  if (vida <= 0 && game.hasVisual(self)){ // agregue el game.has visual porque sino restaba girasoles hasta que lo elimine el garbage collector
    self.eliminar()
    }
     return vida <= 0
  }

  override method eliminar(){
      game.removeVisual(self)
      puntaje.quitarMagoIrlandes()
      administradorDeMagos.eliminarMago(self)
  }
  
}

class MagoHielo inherits Mago(vida=100,imagen="magoHielo.png") {

  override method disparar(){
    const posicionProyectil = new MutablePosition(x = self.position().x() + 1, y = self.position().y())
    if (self.enemigoEnSuFila()){
      administradorDeProyectiles.generarProyectil(posicionProyectil, proyectilPenetrante)
    }
  }
}

class MagoPiedra inherits Mago(vida=300,imagen="magoPiedra.png"){}

class MagoExplosivo inherits Mago(vida=30, imagen="magoExplosivo.png"){

override method estaMuerto(){
    if (vida <= 0 && game.hasVisual(self)){ // agregue el game.has visual porque sino restaba girasoles hasta que lo elimine el garbage collector
      const posicionEnFrente = new MutablePosition(x=position.x() + 1, y=position.y())
      const enemigoEnFrente = game.getObjectsIn(posicionEnFrente)
      self.imagen("p.allahu.gif")
      const explosion = game.sound("m.explosion.mp3")
      game.schedule(50,{explosion.play()})
        explosion.volume(0.2) 
      enemigoEnFrente.map({objeto => objeto.recibeDanioEnemigo(1000)})
      game.schedule(300, { self.eliminar() })
    } 
     return vida <= 0
}
}


class MagoTienda{
  const position
  var property imagen
  const costo
  method position() = position
  method image() = imagen
  method text() = costo.toString() + "$"
  method textColor() = "ffec00ff"
  method puedeGenerarMago(){
    if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta Mago")
    }
  }
  method generarMago(posicionMago){}

  method efectoDeInvocacion(){}
}
object magoPiedraTienda inherits MagoTienda(position = new MutablePosition(x=0, y=5), imagen="magoPiedra.png", costo = 200) {

override method generarMago(posicionMago){
    self.puedeGenerarMago()
    puntaje.restarPuntos(costo)
    return new MagoPiedra(position = posicionMago)
  }
}

object magoFuegoTienda inherits MagoTienda(position = new MutablePosition(x=1, y=5), imagen="magoFuego.png", costo = 100) {

override method generarMago(posicionMago){
    self.puedeGenerarMago()
    puntaje.restarPuntos(costo)
    return new MagoFuego(position = posicionMago)
  }

}
object magoIrlandesTienda inherits MagoTienda(position = new MutablePosition(x=2, y=5), imagen="magoHealer.png", costo = 75) {

override method generarMago(posicionMago) {
    self.puedeGenerarMago()
    puntaje.restarPuntos(costo)
    puntaje.sumarMagoIrlandes()
    return new MagoIrlandes(position = posicionMago)
   }

}

object magoHieloTienda inherits MagoTienda(position = new MutablePosition(x=3, y=5), imagen="magoHielo.png", costo = 125) {

override method generarMago(posicionMago){
    self.puedeGenerarMago()
    puntaje.restarPuntos(costo)
    return new MagoHielo(position = posicionMago)
  }

}
object magoExplosivoTienda inherits MagoTienda(position = new MutablePosition(x=4, y=5), imagen="magoExplosivo.png", costo = 200){

override method generarMago(posicionMago){
    self.puedeGenerarMago()
    puntaje.restarPuntos(costo)
    return new MagoExplosivo(position = posicionMago)
  }
}

// const pepe = new MagoFuego(position = game.at(0, 0))