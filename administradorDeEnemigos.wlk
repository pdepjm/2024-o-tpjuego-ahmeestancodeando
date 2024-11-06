import game.*
import slime.*
import administradorDeOleadas.*

// REVISADO POR NICO

object administradorDeEnemigos {
    var nombreEnemigo = 0 /*asigno el nombre  a los enemigos que voy creando segun tipos, asi puedo crear nombres nuevos automaticamente*/
    var enemigos = #{}/*contiene cada enemigo que fue creando*/

    method enemigos() = enemigos
  
    method columnaOcupada() = enemigos.filter({enemigo => enemigo.position().x()==14}).size() == 5
    
    method nombre() = nombreEnemigo /*para poder consultar el ultimo nombre usado*/

    method sumarEnemigo() {  nombreEnemigo+=1  }

    method generarEnemigo(tipo){/*segun el tipo ingresado, se generara un tipo de enemigo distinto*/
                                /*generara un slime normal*/
      if (not self.columnaOcupada()){
        const posicionTemporal = new MutablePosition(x=14, y=0.randomUpTo(5).truncate(0))
            var nombreParaEnemigo = self.nombre() /* esto esta hecho porque sino wollok se enoja, para poder crear un enemigo*/

            if (game.getObjectsIn(posicionTemporal).isEmpty()){ // el if es para que no genere enemigos sobre otros
            nombreParaEnemigo = new Slime(position = posicionTemporal, tipo=tipo)
            enemigos.add(nombreParaEnemigo)/*se añade a la lista de enemigos activos*/
            self.sumarEnemigo()
            administradorDeOleadas.sumarEnemigo()
            return game.addVisual(nombreParaEnemigo)/*muestra al enemigo en el juego*/
            } else return
      }
    }
    method estanMuertos(){
        enemigos.forEach({enemigo => enemigo.estaMuerto()})
    }

    method moverEnemigos() {
        enemigos.forEach({enemigo => enemigo.movete()})/*aplica la funcion movete a cada enemigo de la coleccion*/
    }

    method eliminarEnemigo(enemigo) {
      administradorDeOleadas.reducirEnemigo()
      enemigos.remove(enemigo)
    }

    method reset() {
        enemigos.map({enemigo => enemigo.eliminar() game.removeVisual(enemigo)})
        nombreEnemigo = 0 
        enemigos = []
    }

}