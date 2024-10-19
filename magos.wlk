import generadorDeMagos.*
import puntaje.*
import proyectil.*
import adminProyectiles.*
import colisionExtra.*

class Mago inherits Colision{
  const position
  var property vida
  var property imagen
  method queSoy() = "mago"

  method position() = position
  
  method image() = imagen

  method disparar(){}
  
  method recibeDanio(_danio) {
    self.vida(self.vida() - _danio)
  }
  
  method estaMuerto(){
    if (vida <= 0 && game.hasVisual(self)) {
      game.removeVisual(self)
      generadorDeMagos.eliminarMago(self)
    }

    return vida <= 0
   // return vida <= 0
  }

}

class MagoFuego inherits Mago(vida=100,imagen="magoFuego.png"){

  override method disparar(){
    const posicionProyectil = new MutablePosition(x = self.position().x() + 1, y = self.position().y())
    administradorDeProyectiles.generarProyectil(posicionProyectil, proyectilNormal)
  }
  
}

class MagoIrlandes inherits Mago(vida=100, imagen="magoHealer.png") {
 
  override method estaMuerto(){

  if (vida <= 0 && game.hasVisual(self)){ // agregue el game.has visual porque sino restaba girasoles hasta que lo elimine el garbage collector
      game.removeVisual(self)
      puntaje.quitarMagoIrlandes()
      generadorDeMagos.eliminarMago(self)
    }

     return vida <= 0
    //return vida <= 0
  }
  
}

class MagoHielo inherits Mago(vida=100,imagen="magoHielo.png") {

  override method disparar(){
    const posicionProyectil = new MutablePosition(x = self.position().x() + 1, y = self.position().y())
    administradorDeProyectiles.generarProyectil(posicionProyectil, proyectilPenetrante)
  }

}

class MagoPiedra inherits Mago(vida=300,imagen="magoPiedra.png") {
  //nota de nico: es una nuez >:(
}

class MagoExplosivo inherits Mago(vida=30, imagen="magoExplosivo.png") {

override method estaMuerto(){

    if (vida <= 0 && game.hasVisual(self)){ // agregue el game.has visual porque sino restaba girasoles hasta que lo elimine el garbage collector
      const posicionEnFrente = game.at(position.x() + 1 ,position.y())
      const enemigoEnFrente = self.colisionEnFrente(posicionEnFrente, "zombie")
      self.imagen("sss.gif")
      game.schedule(200, {
        game.removeVisual(self)
        enemigoEnFrente.recibeDanio(1000)
        generadorDeMagos.eliminarMago(self)
        })
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
  method generarMago(posicionMago){}
  method efectoDeInvocacion(){}
}

object magoPiedraTienda inherits MagoTienda(position = game.at(0,5), imagen="magoPiedra.png", costo = 200) {

override method generarMago(posicionMago){
     if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta Mago")
    }
    puntaje.restarPuntos(costo)
    return new MagoPiedra(position = posicionMago)
  }

}

object magoFuegoTienda inherits MagoTienda(position = game.at(1,5), imagen="magoFuego.png", costo = 100) {

override method generarMago(posicionMago){
     if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta Mago")
    }
    puntaje.restarPuntos(costo)
    return new MagoFuego(position = posicionMago)
  }

}

object magoIrlandesTienda inherits MagoTienda(position = game.at(2,5), imagen="magoHealer.png", costo = 75) {

override method generarMago(posicionMago) {
    if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta Mago")
    }
    puntaje.restarPuntos(costo)
    return new MagoIrlandes(position = posicionMago)
   }

}

object magoHieloTienda inherits MagoTienda(position = game.at(3,5), imagen="magoHielo.png", costo = 125) {

override method generarMago(posicionMago){
     if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta Mago")
    }
    puntaje.restarPuntos(costo)
    return new MagoHielo(position = posicionMago)
  }

}

object magoExplosivoTienda inherits MagoTienda(position = game.at(4,5), imagen="magoExplosivo.png", costo = 200){

  
override method generarMago(posicionMago){
     if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta Mago")
    }
    puntaje.restarPuntos(costo)
    return new MagoExplosivo(position = posicionMago)
  }
 
}

// const pepe = new MagoFuego(position = game.at(0, 0))