import game.*
import zombie.*

object generadorDeEnemigos {
    var nombreEnemigo = 0 /*asigno el nombre  a los enemigos que voy creando segun numeros, asi puedo crear nombres nuevos
                            automaticamente*/
    
    const enemigos = #{}/*contiene cada enemigo que fue creando*/
   
    method nombre() = nombreEnemigo /*para poder consultar el ultimo nombre usado*/
    method sumarEnemigo() { /*suma 1 a nombre enemigo para asi crear enemigos nuevos, luego hay que hacer la funcion
                            para que reste 1 cuando maten a un enemigo*/
        nombreEnemigo+=1
        }
    method generarEnemigo(numero){/*segun el numero ingresado, se generara un tipo de enemigo distinto*/
        if (numero==1) {/*generara un zombie normal*/

        const posicionTemporal = new MutablePosition(x=12, y=0.randomUpTo(5).truncate(0))
            var nombreParaEnemigo = self.nombre() /* esto esta hecho porque sino wollok se enoja, para poder crear un enemigo*/

            if (game.getObjectsIn(posicionTemporal).isEmpty()){ // el if es para que no genere enemigos sobre otros
            nombreParaEnemigo = new ZombiesNormales(position = posicionTemporal )
            enemigos.add(nombreParaEnemigo)/*se añade a la lista de enemigos activos*/
            self.sumarEnemigo()
            return game.addVisual(nombreParaEnemigo)/*muestra al enemigo en el juego*/
            } else return
        }
        return 0
    }
    method siguenVivos(){
        enemigos.forEach({enemigo => enemigo.sigueVivo()})
    }

    method moverEnemigos() {
        enemigos.forEach({zombie => zombie.movete()})/*aplica la funcion movete a cada enemigo de la coleccion*/
    }
    method eliminarEnemigo(enemigo) {
      enemigos.remove(enemigo)
    }

}