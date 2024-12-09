import game.*
import slime.*
import administradorDeOleadas.*


/* =======================================
   Administrador de Enemigos: Gestión de enemigos en el juego
   ======================================= */
object administradorDeEnemigos {
    // constantes
    const maxEnemigosEnPantalla = 8
    // Propiedades
    var nombreEnemigo = 10000
    var enemigos = #{}

    const property cantDeEnemigosPorLinea= [linea1,linea2,linea3,linea4,linea5]
    // Métodos de Consulta
    method enemigos() = enemigos
    method nombre() = nombreEnemigo
    method pocosEnemigosEnPantalla() = cantDeEnemigosPorLinea.sum({linea => linea.cantEnemigos()}) < maxEnemigosEnPantalla

    // Genera un nuevo nombre para los enemigos
    method sumarEnemigo() { nombreEnemigo += 1 }

    // Genera un nuevo enemigo del tipo especificado, si hay espacio en la columna
    method generarEnemigo(tipo) {
        if (self.pocosEnemigosEnPantalla()) {

            const y = 0.randomUpTo(4.9999).truncate(0)

            const posicionTemporal = new MutablePosition(x = 14, y=y)

            var nombreParaEnemigo = self.nombre()

            /* Solo genera el enemigo si la posición temporal está vacía */
            if (game.getObjectsIn(posicionTemporal).isEmpty()) {
                nombreParaEnemigo = new Slime(position = posicionTemporal, tipo = tipo)
                enemigos.add(nombreParaEnemigo) /* Añade el nuevo enemigo a la colección de enemigos activos */
                self.sumarEnemigo() /* Incrementa el contador de enemigos en el administrador */
                administradorDeOleadas.sumarEnemigo() /* Notifica al administrador de oleadas */
                self.aumentarLinea(y)  
                return game.addVisual(nombreParaEnemigo) /* Muestra al enemigo en el juego */
            } else {
                return /* No genera el enemigo si la posición está ocupada */
            }
        }
    }

    // Elimina un enemigo específico de la colección de enemigos activos
    method eliminarEnemigo(enemigo) {
        const y= enemigo.position().y()
        self.decrementarLinea(y)  
        administradorDeOleadas.reducirEnemigo()
        enemigos.remove(enemigo)
    }

    // Resetea el estado del administrador, eliminando todos los enemigos y reiniciando el contador
    method reset() {
        enemigos.forEach({ enemigo => enemigo.eliminar() })
        nombreEnemigo = 0
        enemigos = []
        self.resetLineas()
    }

    method resetLineas(){
        cantDeEnemigosPorLinea.forEach({linea => linea.cantEnemigos(0)})
    }

    // Verifica si los enemigos están muertos
    method estanMuertos() {
        enemigos.forEach({ enemigo => enemigo.estaMuerto() })
    }

    // Ordena a cada enemigo ejecutar la función de movimiento
    method moverEnemigos() {
        enemigos.forEach({ enemigo => enemigo.movete() })
    }
    method cambiarFrame(){
        enemigos.forEach({ enemigo => enemigo.cambiarFrame()})
    }

    method aumentarLinea(linea){
        cantDeEnemigosPorLinea.get(linea).aumentarCant()
    }

    method decrementarLinea(linea){
        cantDeEnemigosPorLinea.get(linea).restarCantidad()
    }

    method hayEnemigoFila(numeroFila) = cantDeEnemigosPorLinea.get(numeroFila).tieneEnemigos()

    method noHayEnemigoFila(numeroFila) = cantDeEnemigosPorLinea.get(numeroFila).noTieneEnemigos()

}

class Linea{


    const linea = 0

    method position() = new MutablePosition(x = 13, y = linea)
    method text() = cantEnemigos.toString()


    var property cantEnemigos = 0

    method reset(){
        cantEnemigos = 0
    }

    method tieneEnemigos() = cantEnemigos > 0

    method noTieneEnemigos() = cantEnemigos == 0 //nadie tiene enemigos

    method aumentarCant() {
        cantEnemigos+=1
    }
    method restarCantidad(){
        cantEnemigos-=1
    }
}

const linea1 = new Linea(linea=0)
const linea2 = new Linea(linea=1)
const linea3 = new Linea(linea=2)
const linea4 = new Linea(linea=3)
const linea5 = new Linea(linea=4)
