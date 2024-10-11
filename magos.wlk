import generadorDeMagos.*
import puntaje.*
import proyectil.*
import adminProyectiles.*
class MagoFuego {
  const position
  const property tipo = "fuego"
  var property vida = 100
  var property danio = 40
  var property imagen = "magoFuego.png"
  
  method position() = position
  
  method image() = imagen

  method disparar(){
    const posicionProyectil = new MutablePosition(x = self.position().x() + 1, y = self.position().y())
    administradorDeProyectiles.generarProyectil(posicionProyectil, proyectilNormal)
  }
  
  method recibeDanio(_danio) {
    self.vida(self.vida() - _danio)
  }
  
  method sigueViva(){
    if (vida <= 0) {
      game.removeVisual(self)
      generadorDeMagos.eliminarMago(self)
    }
  }

  method queSoy() = "mago"
}

class MagoHealer {
  const position
  const property tipo = "girasol"
  var property vida = 100
  var property imagen = "magoHealer.png"
  
  method position() = position

  method danio() = 0
  
  method image() = imagen
  
  method disparar(){}

  method recibeDanio(_danio) {
    self.vida(self.vida() - _danio)
  }

  method sigueViva(){

    if (vida <= 0 && game.hasVisual(self)){ // agregue el game.has visual porque sino restaba girasoles hasta que lo elimine el garbage collector
      game.removeVisual(self)
      puntaje.quitarMagoHealer()
    }
  }
  
  method queSoy() = "mago"
}

class MagoHielo {
  const position
  const property tipo = "cactus"
  var property vida = 100
  var property imagen = "magoHielo.png"
  
  method position() = position
  
  method image() = imagen
  
  method disparar(){
    const posicionProyectil = new MutablePosition(x = self.position().x() + 1, y = self.position().y())
    administradorDeProyectiles.generarProyectil(posicionProyectil, proyectilPenetrante)
  }

  method recibeDanio(_danio) {
    self.vida(self.vida() - _danio)
  }

  method sigueViva(){
    if (vida <= 0) {
      game.removeVisual(self)
      generadorDeMagos.eliminarMago(self)
    }
  }

  method queSoy() = "mago"
}

class MagoPiedra {
  //nota de nico: es una nuez >:(
  const position
  const property tipo = "piedra"
  var property vida = 300
  var property imagen = "magoPiedra.png"

  method danio() = 0
  
  method position() = position
  
  method image() = imagen
  
  method disparar(){}

  method recibeDanio(danio) {
    self.vida(self.vida() - danio)
  }

    method sigueViva(){
    if (vida <= 0) game.removeVisual(self)
  }
  
  method queSoy() = "mago"
}

class Patapum {
  const position
  const property tipo = "patapum"
  var property vida = 1
  var property imagen = "magoEnojado.png" //hacer mago musulman
  
  method position() = position
  
  method image() = imagen
  
  method recibeDanio(_danio) {
    self.vida(self.vida() - _danio)
  }

    method sigueViva(){
    if (vida <= 0) game.removeVisual(self)
  }
  
  method queSoy() = "mago"
}

class MagoEnojado {
  const position
  const property tipo = "zapallo enojado"
  var property vida = 125
  var property imagen = "magoEnojado.png"
  
  method position() = position
  
  method image() = imagen
  
  method disparar(){}

  method recibeDanio(_danio) {
    self.vida(self.vida() - _danio)
  }

    method sigueViva(){
    if (vida <= 0) game.removeVisual(self)
  }
  
  method queSoy() = "mago"
}

object magoPiedraTienda {
  const position = game.at(0, 5)
  var property imagen = "magoPiedra.png"
  
  const costo = 200

  method position() = position
  
  method image() = imagen
  
  method generarMago(posicionMago){
     if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta Mago")
    }
    puntaje.restarPuntos(costo)
    return new MagoPiedra(position = posicionMago)
  }

method efectoDeInvocacion(){}
}

object magoFuegoTienda {
  const position = game.at(1, 5)
  var property imagen = "magoFuego.png"
  
  const costo = 0

  method position() = position
  
  method image() = imagen
  
  method generarMago(posicionMago){
     if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta Mago")
    }
    puntaje.restarPuntos(costo)
    return new MagoFuego(position = posicionMago)
  }

method efectoDeInvocacion(){}
}

object magoHealerTienda {
  const position = game.at(2, 5)
  var property imagen = "magoHealer.png"

  const costo = 200

  method position() = position
  
  method image() = imagen
  
  method generarMago(posicionMago) {
    if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta Mago")
    }
    puntaje.restarPuntos(costo)
    return new MagoHealer(position = posicionMago)
   }

  method efectoDeInvocacion(){
    puntaje.sumarMagoHealer()
  }

}

object magoHieloTienda {
  const position = game.at(3, 5)
  var property imagen = "magoHielo.png"
  
  const costo = 0

  method position() = position
  
  method image() = imagen
  
  method generarMago(posicionMago){
     if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta Mago")
    }
    puntaje.restarPuntos(costo)
    return new MagoHielo(position = posicionMago)
  }

method efectoDeInvocacion(){}
}

object magoEnojadoTienda {
  const position = game.at(4, 5)
  var property imagen = "magoEnojado.png"
  
  const costo = 200

  method position() = position
  
  method image() = imagen
  
  method generarMago(posicionMago){
     if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta Mago")
    }
    puntaje.restarPuntos(costo)
    return new MagoEnojado(position = posicionMago)
  }

  method efectoDeInvocacion(){}
}

// const pepe = new MagoFuego(position = game.at(0, 0))