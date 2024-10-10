import puntaje.*

class Papa {
  //nota de nico: es una nuez >:(
  const position
  const property tipo = "papa"
  var property vida = 300
  var property imagen = "magoPiedra.png"
  
  method position() = position
  
  method image() = imagen
  
  method recibeDanio(danio) {
    self.vida(self.vida() - danio)
  }

    method sigueViva(){
    if (vida <= 0) game.removeVisual(self)
  }
  
  method queSoy() = "planta"
}

class Guisante {
  const position
  const property tipo = "guisante"
  var property vida = 100
  var property imagen = "magoFuego.png"
  
  method position() = position
  
  method image() = imagen
  
  method recibeDanio(danio) {
    self.vida(self.vida() - danio)
  }
  
  method sigueViva(){
    if (vida <= 0) game.removeVisual(self)
  }

  method queSoy() = "planta"
}

class Patapum {
  const position
  const property tipo = "patapum"
  var property vida = 1
  var property imagen = "magoEnojado.png" //hacer mago musulman
  
  method position() = position
  
  method image() = imagen
  
  method recibeDanio(danio) {
    self.vida(self.vida() - danio)
  }

    method sigueViva(){
    if (vida <= 0) game.removeVisual(self)
  }
  
  method queSoy() = "planta"
}

class Cactus {
  const position
  const property tipo = "cactus"
  var property vida = 100
  var property imagen = "magoHielo.png"
  
  method position() = position
  
  method image() = imagen
  
  method recibeDanio(danio) {
    self.vida(self.vida() - danio)
  }

    method sigueViva(){
    if (vida <= 0) game.removeVisual(self)
  }
  
  method queSoy() = "planta"
}

class Girasol {
  const position
  const property tipo = "girasol"
  var property vida = 50
  var property imagen = "magoHealer.png"
  
  method position() = position
  
  method image() = imagen
  
  method recibeDanio(danio) {
    self.vida(self.vida() - danio)
  }

    method sigueViva(){
    if (vida <= 0) game.removeVisual(self)
  }
  
  method queSoy() = "planta"
}

class ZapalloEnojado {
  const position
  const property tipo = "zapallo enojado"
  var property vida = 125
  var property imagen = "magoEnojado.png"
  
  method position() = position
  
  method image() = imagen
  
  method recibeDanio(danio) {
    self.vida(self.vida() - danio)
  }

    method sigueViva(){
    if (vida <= 0) game.removeVisual(self)
  }
  
  method queSoy() = "planta"
}

object papaTienda {
  const position = game.at(0, 5)
  var property imagen = "magoPiedra.png"
  
  const costo = 200

  method position() = position
  
  method image() = imagen
  
  method generarPlanta(posicionPlanta){
     if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta planta")
    }
    puntaje.restarPuntos(costo)
    return new Papa(position = posicionPlanta)
  }

method efectoDeInvocacion(){}
}

object guisanteTienda {
  const position = game.at(1, 5)
  var property imagen = "magoFuego.png"
  
  const costo = 200

  method position() = position
  
  method image() = imagen
  
  method generarPlanta(posicionPlanta){
     if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta planta")
    }
    puntaje.restarPuntos(costo)
    return new Guisante(position = posicionPlanta)
  }

method efectoDeInvocacion(){}
}

object girasolTienda {
  const position = game.at(2, 5)
  var property imagen = "magoHealer.png"

  const costo = 200

  method position() = position
  
  method image() = imagen
  
  method generarPlanta(posicionPlanta) {
    if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta planta")
    }
    puntaje.restarPuntos(costo)
    return new Girasol(position = posicionPlanta)
   }

  method efectoDeInvocacion(){
    puntaje.sumarGirasol()
  }

}

object cactusTienda {
  const position = game.at(3, 5)
  var property imagen = "magoHielo.png"
  
  const costo = 200

  method position() = position
  
  method image() = imagen
  
  method generarPlanta(posicionPlanta){
     if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta planta")
    }
    puntaje.restarPuntos(costo)
    return new Cactus(position = posicionPlanta)
  }

method efectoDeInvocacion(){}
}

object zapalloEnojadoTienda {
  const position = game.at(4, 5)
  var property imagen = "magoEnojado.png"
  
  const costo = 200

  method position() = position
  
  method image() = imagen
  
  method generarPlanta(posicionPlanta){
     if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta planta")
    }
    puntaje.restarPuntos(costo)
    return new ZapalloEnojado(position = posicionPlanta)
  }

  method efectoDeInvocacion(){}
}

const pepe = new Guisante(position = game.at(0, 0))