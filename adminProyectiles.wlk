import game.*
import proyectil.*

object administradorDeProyectiles {
    var nombreproyectil = 0
    method nombreproyectil() = nombreproyectil
    method sumarProyectil() { /*suma 1 a nombre enemigo para asi crear enemigos nuevos, luego hay que hacer la funcion
                            para que reste 1 cuando maten a un enemigo*/
        nombreproyectil+=1
        }

    const proyectiles = #{}/*contiene cada enemigo que fue creando*/
    method proyectiles() = proyectiles


    method moverProyectil(){
        proyectiles.forEach({proyectil => proyectil.mover()})
    }
}