import game.*
import slime.*

object administradorDeEnemigos {
    var nombreEnemigo = 2000 /*asigno el nombre  a los enemigos que voy creando segun tipos, asi puedo crear nombres nuevos
                            automaticamente*/
    
    const enemigos = #{}/*contiene cada enemigo que fue creando*/
   
    method nombre() = nombreEnemigo /*para poder consultar el ultimo nombre usado*/
    method sumarEnemigo() { /*suma 1 a nombre enemigo para asi crear enemigos nuevos, luego hay que hacer la funcion
                            para que reste 1 cuando maten a un enemigo*/
        nombreEnemigo+=1
        }
    method generarEnemigo(tipo){/*segun el tipo ingresado, se generara un tipo de enemigo distinto*/
      /*generara un slime normal*/

        const posicionTemporal = new MutablePosition(x=12, y=0.randomUpTo(5).truncate(0))
            var nombreParaEnemigo = self.nombre() /* esto esta hecho porque sino wollok se enoja, para poder crear un enemigo*/

            if (game.getObjectsIn(posicionTemporal).isEmpty()){ // el if es para que no genere enemigos sobre otros
            nombreParaEnemigo = new Slime(position = posicionTemporal, tipo=tipo)
            enemigos.add(nombreParaEnemigo)/*se añade a la lista de enemigos activos*/
            self.sumarEnemigo()
            return game.addVisual(nombreParaEnemigo)/*muestra al enemigo en el juego*/
            } else return
      
    }
    method estanMuertos(){
        enemigos.forEach({enemigo => enemigo.estaMuerto()})
    }

    method moverEnemigos() {
        enemigos.forEach({slime => slime.movete()})/*aplica la funcion movete a cada enemigo de la coleccion*/
    }
    method eliminarEnemigo(enemigo) {
      enemigos.remove(enemigo)
    }

}