import game.*
import proyectil.*

object administradorDeProyectiles {
    var nombreProyectil = 10000 /*asigno el nombre  a los enemigos que voy creando segun numeros, asi puedo crear nombres nuevos
                            automaticamente*/

    const proyectiles = #{}/*contiene cada enemigo que fue creando*/
    method proyectiles() = proyectiles

    method nombre() = nombreProyectil /*para poder consultar el ultimo nombre usado*/
    method sumarProyectil() { /*suma 1 a nombre mago para asi crear magos nuevos, luego hay que hacer la funcion para que reste 1 cuando maten a un enemigo*/
        nombreProyectil += 1
        }

    method generarProyectil(posicion, tipoProyectil){ // metodo para no usar los if anidados
        var nombreParaProyectil = self.nombre() 
        //console.println("el nombre es: " + nombreParaProyectil)
        nombreParaProyectil = new Proyectil(position = posicion, tipo = tipoProyectil)
       // console.println("el objeto es: " + nombreParaProyectil)
        proyectiles.add(nombreParaProyectil)
        self.sumarProyectil()
       // console.println("proyectiles: " + proyectiles)
        return game.addVisual(nombreParaProyectil)
    }

    method moverProyectiles(){
        proyectiles.forEach({proyectil => proyectil.mover()})
    }
    method impactarProyectiles(){
        proyectiles.forEach({proyectil => proyectil.colisionar()})
    }
    method destruirProyectil(proyectil) {
      proyectiles.remove(proyectil)
    }
    
}