import administradorDeMagos.*
import magos.*
import cursor.*
import wollok.game.*
import pala.*
object menu {
  method pop() = game.sound("m.pop.mp3")
  method pff() = game.sound("m.pff.mp3")
  
  const position = new MutablePosition(x = 0, y = 5)
  var property imagen = "marcosRojo.png"
  
  method position() = position
  
  method image() = imagen
  
  method accion() {
    keyboard.d().onPressDo({ self.moverseDerecha() })
    keyboard.a().onPressDo({ self.moverseIzquierda() })
    keyboard.enter().onPressDo({self.generarMago()})
    keyboard.p().onPressDo({ self.eliminarMago() })
    // cambiar aca para cambiar forma de generar enemigos
  }
  
  method moverseDerecha() = if (self.position().x() < 5) position.goRight(1)
  
  method moverseIzquierda() = if (self.position().x() > 0) position.goLeft(1)
  
  method generarMago() {
    const magoAGenerar = game.colliders(self) // no usamos uniqueColliders porque tira error si no hay ninguna
    const objetoCelda = game.colliders(cursor)
    const posicionCelda = game.at(cursor.position().x(), cursor.position().y())

    if (!magoAGenerar.isEmpty() && objetoCelda.all({objeto => objeto.sePuedeSuperponer()}) && self.position().x() != 5){ // estaba tirando un error de que estaba aplicando un metodo a una lista vacia
        const magoSeleccionado = magoAGenerar.first()
        administradorDeMagos.generarMago(magoSeleccionado, posicionCelda)
        self.pop().volume(0.2)
        self.pop().play()
    } else  if (self.position().x() == 5){
        const magoSeleccionado = objetoCelda.find({objeto => not objeto.sePuedeSuperponer()})
        pala.eliminarMago(magoSeleccionado)
        self.pff().volume(0.4)
        self.pff().play()
    }

  }
  method eliminarMago() {
    const objetoCelda = game.colliders(cursor).find({objeto => not objeto.sePuedeSuperponer()})
    if (!objetoCelda.isEmpty()){ // estaba tirando un error de que estaba aplicando un metodo a una lista vacia
      pala.eliminarMago(objetoCelda)
      self.pff().volume(0.4)
      self.pff().play()
    }
  }
  // Borre las instanciaciones porque las hice objetos en magos.wlk
  // Para usar la 2da forma de generar magos
  method iniciarTienda() {
    // const papaTienda = new Papa(position = game.at(0,5))
    game.addVisual(magoPiedraTienda)
    
    // const guisanteTienda = new Guisante(position = game.at(1,5))
    
    game.addVisual(magoFuegoTienda)
    //const girasolTIenda = new Girasol(position = game.at(2,5))
    
    game.addVisual(magoIrlandesTienda)
    // const cactusTienda = new Cactus(position = game.at(3,5))
    
    game.addVisual(magoHieloTienda)
    //const zapalloTienda = new ZapalloEnojado(position = game.at(4,5))
    
    game.addVisual(magoExplosivoTienda)

    game.addVisual(pala)
  }
}