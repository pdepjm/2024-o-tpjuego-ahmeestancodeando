import generadorDeMagos.*
import magos.*
import cursor.*

object menu {
  const position = new MutablePosition(x = 0, y = 5)
  var property imagen = "marcosRojo.png"
  
  method position() = position
  
  method image() = imagen
  
  method accion() {
    keyboard.d().onPressDo({ self.moverseDerecha() })
    keyboard.a().onPressDo({ self.moverseIzquierda() })
    keyboard.enter().onPressDo({ self.generarMago2() })
    // cambiar aca para cambiar forma de generar enemigos
  }
  
  method moverseDerecha() = if (self.position().x() < 6) position.goRight(1)
  
  method moverseIzquierda() = if (self.position().x() > 0) position.goLeft(1)
  
  method generarMago() {
    const magoAGenerar = game.colliders(self)
    // no usamos uniqueColliders porque tira error si no hay ninguna
    const magoSeleccionado = magoAGenerar.first().tipo()
    const posicion = game.at(cursor.position().x(), cursor.position().y())
    generadorDeMagos.generarMago2(magoSeleccionado, posicion)
  }
  
  method generarMago2() {
    const magoAGenerar = game.colliders(self) // no usamos uniqueColliders porque tira error si no hay ninguna
    if (!magoAGenerar.isEmpty()){ // estaba tirando un error de que estaba aplicando un metodo a una lista vacia
    const magoSeleccionado = magoAGenerar.first()
    const posicion = game.at(cursor.position().x(), cursor.position().y())
    generadorDeMagos.generarMago2(magoSeleccionado, posicion)
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
    
    game.addVisual(magoHealerTienda)
    // const cactusTienda = new Cactus(position = game.at(3,5))
    
    game.addVisual(magoHieloTienda)
    //const zapalloTienda = new ZapalloEnojado(position = game.at(4,5))
    
    game.addVisual(magoEnojadoTienda)
  }
}