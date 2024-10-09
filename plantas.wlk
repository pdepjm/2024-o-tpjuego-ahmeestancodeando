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
  
  method queSoy() = "planta"
}

class Girasol {
  const position
  const property tipo = "girasol"
  var property vida = 100
  var property imagen = "magoHealer.png"
  
  method position() = position
  
  method image() = imagen
  
  method recibeDanio(danio) {
    self.vida(self.vida() - danio)
  }
  
  method queSoy() = "planta"
}

class ZapalloEnojado {
  const position
  const property tipo = "zapallo enojado"
  var property vida = 1
  var property imagen = "magoEnojado.png"
  
  method position() = position
  
  method image() = imagen
  
  method recibeDanio(danio) {
    self.vida(self.vida() - danio)
  }
  
  method queSoy() = "planta"
}

object papaTienda {
  const position = game.at(0, 5)
  var property imagen = "magoPiedra.png"
  
  method position() = position
  
  method image() = imagen
  
  method generarPlanta(posicionPlanta) = new Papa(position = posicionPlanta)
}

object guisanteTienda {
  const position = game.at(1, 5)
  var property imagen = "magoFuego.png"
  
  method position() = position
  
  method image() = imagen
  
  method generarPlanta(posicionPlanta) = new Guisante(position = posicionPlanta)
}

object girasolTienda {
  const position = game.at(2, 5)
  var property imagen = "magoHealer.png"
  
  method position() = position
  
  method image() = imagen
  
  method generarPlanta(posicionPlanta) = new Girasol(position = posicionPlanta)
}

object cactusTienda {
  const position = game.at(3, 5)
  var property imagen = "magoHielo.png"
  
  method position() = position
  
  method image() = imagen
  
  method generarPlanta(posicionPlanta) = new Cactus(position = posicionPlanta)
}

object zapalloEnojadoTienda {
  const position = game.at(4, 5)
  var property imagen = "magoEnojado.png"
  
  method position() = position
  
  method image() = imagen
  
  method generarPlanta(posicionPlanta) = new ZapalloEnojado(
    position = posicionPlanta
  )
}

const pepe = new Guisante(position = game.at(0, 0))