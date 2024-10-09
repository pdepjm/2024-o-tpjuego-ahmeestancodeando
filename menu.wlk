import generadorDePlantas.*
import plantas.*
import cursor.*

object menu {
    const position = new MutablePosition(x=0, y=5)
    method position() = position  

    var property imagen = "marcosRojo.png"
    method image() = imagen
  
    method accion(){
        keyboard.d().onPressDo({self.moverseDerecha()})
        keyboard.a().onPressDo({self.moverseIzquierda()})
        keyboard.enter().onPressDo({self.generarPlanta2()})
    }
    method moverseDerecha() = if (self.position().x()<6) position.goRight(1)
    method moverseIzquierda() = if (self.position().x()>0) position.goLeft(1)
    method generarPlanta(){
        const plantaAGenerar = game.colliders(self) // no usamos uniqueColliders porque tira error si no hay ninguna
        const plantaSeleccionada = plantaAGenerar.first().tipo()
        const posicion = game.at(cursor.position().x(),cursor.position().y())
        generadorDePlantas.generarPlanta(plantaSeleccionada,posicion)
    }

        method generarPlanta2(){
        const plantaAGenerar = game.colliders(self) // no usamos uniqueColliders porque tira error si no hay ninguna
        const plantaSeleccionada = plantaAGenerar.first()
        const posicion = game.at(cursor.position().x(),cursor.position().y())
        generadorDePlantas.generarPlanta2(plantaSeleccionada,posicion)
        
    }

    method iniciarTienda(){
        //const papaTienda = new Papa(position = game.at(0,5))
        game.addVisual(papaTienda)
        const guisanteTienda = new Guisante(position = game.at(1,5))
        game.addVisual(guisanteTienda)
        const girasolTIenda = new Girasol(position = game.at(2,5))
        game.addVisual(girasolTIenda)
        const cactusTienda = new Cactus(position = game.at(3,5))
        game.addVisual(cactusTienda)
        const zapalloTienda = new ZapalloEnojado(position = game.at(4,5))
        game.addVisual(zapalloTienda)
    }
}

