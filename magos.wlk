// ===============================
// Revisado
// ===============================

import administradorDeMagos.*
import puntaje.*
import proyectil.*
import adminProyectiles.*
import administradorDeEnemigos.*
// ===============================
// Clase Base: Mago
// ===============================
class Mago {
  // Propiedades
  const position
  var property vida
  var property imagen

  // Métodos
  method frenarEnemigo() = true

  method enemigoEnSuFila() = administradorDeEnemigos.enemigos().any({enemigo => enemigo.position().y() == self.position().y()})

  method position() = position
  method image() = imagen

  method disparar() {}

  method recibeDanioEnemigo(_danio) { return false }
  
  method recibeDanioMago(_danio) {
    self.vida(self.vida() - _danio)
    return false
  }

  method sePuedeSuperponer() = false

  method doyPlata() = 0

  method estaMuerto() {
    if (vida <= 0) {self.eliminar()}
    return vida <= 0
  }

  method eliminar() {
    game.removeVisual(self)
    administradorDeMagos.eliminarMago(self)
  }
}


// ===============================
// Subclases de Mago: Tipos de magos
// ===============================

// Mago de Fuego
class MagoFuego inherits Mago(vida = 100, imagen = "magoFuego.png") {
  override method disparar() {
    const posicionProyectil = new MutablePosition(x = self.position().x() + 1, y = self.position().y())
    if (self.enemigoEnSuFila()) {
      administradorDeProyectiles.generarProyectil(posicionProyectil, proyectilNormal)
    }
  }
}

// Mago Irlandés (sanador)
class MagoIrlandes inherits Mago(vida = 100, imagen = "magoHealer.png") {
  override method doyPlata() = 10
}

// Mago de Hielo
class MagoHielo inherits Mago(vida = 100, imagen = "magoHielo.png") {
  override method disparar() {
    const posicionProyectil = new MutablePosition(x = self.position().x() + 1, y = self.position().y())
    if (self.enemigoEnSuFila()) {
      administradorDeProyectiles.generarProyectil(posicionProyectil, proyectilPenetrante)
    }
  }
}

// Mago de Piedra
class MagoPiedra inherits Mago(vida = 300, imagen = "magoPiedra.png") {}

// Mago Explosivo
class MagoExplosivo inherits Mago(vida = 30, imagen = "magoExplosivo.png") {
  const explosion = game.sound("m.explosion.mp3")
  const posicionEnFrente = new MutablePosition(x = position.x() + 1, y = position.y())
  va enemigoEnFrente = game.getObjectsIn(posicionEnFrente)


  override method estaMuerto() {

    if (vida <= 0 ) {
      explosion.volume(0.2)
      explosion.play()
      enemigoEnFrente.map({ objeto => objeto.matar() })
      self.eliminar()
    }
    return vida <= 0
  }
}




// ===============================
// Tiendas de Magos: Creación de Magos desde la tienda
// ===============================

class MagoTienda{
  const position
  const costo

  method position() = position

  method image() = ""

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

// Mago de Piedra en Tienda
object magoPiedraTienda inherits MagoTienda(position = new MutablePosition(x = 0, y = 5), costo = 200) {
  override method generarMago(posicionMago) {
    self.puedeGenerarMago()
    puntaje.restarPuntos(costo)
    return new MagoPiedra(position = posicionMago)
  }

  
  override method image() = "magoPiedra.png"
}

// Mago de Fuego en Tienda
object magoFuegoTienda inherits MagoTienda(position = new MutablePosition(x = 1, y = 5), costo = 100) {
  
  override method generarMago(posicionMago) {
    self.puedeGenerarMago()
    puntaje.restarPuntos(costo)
    return new MagoFuego(position = posicionMago)
  }

  override method image() = "magoFuego.png"
}

// Mago Irlandés en Tienda
object magoIrlandesTienda inherits MagoTienda(position = new MutablePosition(x = 2, y = 5), costo = 75) {
  override method generarMago(posicionMago) {
    self.puedeGenerarMago()
    puntaje.restarPuntos(costo)
    return new MagoIrlandes(position = posicionMago)
  }

  
  override method image() = "magoHealer.png"
}

// Mago de Hielo en Tienda
object magoHieloTienda inherits MagoTienda(position = new MutablePosition(x = 3, y = 5), costo = 125) {
  override method generarMago(posicionMago) {
    self.puedeGenerarMago()
    puntaje.restarPuntos(costo)
    return new MagoHielo(position = posicionMago)
  }
  
  override method image() = "magoHielo.png"
}

// Mago Explosivo en Tienda
object magoExplosivoTienda inherits MagoTienda(position = new MutablePosition(x = 4, y = 5), costo = 200) {
  override method generarMago(posicionMago) {
    self.puedeGenerarMago()
    puntaje.restarPuntos(costo)
    return new MagoExplosivo(position = posicionMago)
  }

  override method image() = "magoExplosivo.png"
}
