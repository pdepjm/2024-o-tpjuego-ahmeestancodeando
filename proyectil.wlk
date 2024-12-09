// ===============================
// Revisado
// ===============================

import adminProyectiles.*
import game.*
import administradorDeEnemigos.administradorDeEnemigos


// ===============================
// Proyectil: Clase base para proyectiles
// ===============================
class Proyectil {
    // Propiedades
    var property proyectil
    var position
    const y = position.y()
    const property danio = proyectil.danio()
    var frame = 0
    var imagen = proyectil.imagenes().get(0)

    // Métodos públicos
    method position() = position
    method image() = imagen
    method frenarEnemigo() = false
    method sePuedeSuperponer() = true

    // Método de movimiento
    method mover() {
        imagen=proyectil.imagenes().get(0)
        frame=1
        position.goRight(1)
        if (administradorDeEnemigos.noHayEnemigoFila(y) || self.llegueAlFinal()) { self.eliminar() }

    }
    // Método que revisa si llego al final
    method llegueAlFinal() = position.x() >= 14
    // Método de colisión
    method colisionar() {proyectil.colisionar().apply(self)}

    method combinar(){
        const posicionEnFrente = new MutablePosition(x = position.x()+1, y = position.y())

        const objetosEnPosicion = game.getObjectsIn(posicionEnFrente)

        const proyACombinar =  objetosEnPosicion.any({objeto => self.proyectil().puedeCombinarse() &&  objeto.proyectil() == self.proyectil()}) //aparentemente wollok tiene lazy evaluation, chad wollok ;)
        
        if (proyACombinar) {
            objetosEnPosicion.forEach({objeto => objeto.mejorar()})
            self.eliminar()
        }
    }

    method mejorar(){
        proyectil = self.proyectil().mejora()
    }

    // Métodos para recibir daño
    method recibeDanioEnemigo(_danio,proy){}
    method recibeDanioMago(_danio,enemigo) {proyectil.recibeDanioMago(_danio, enemigo)}

    // Método para destruir el proyectil
    method destruirse() {
        if (proyectil.destruirse()) { self.eliminar()}
    }

    // Método para eliminar el proyectil
    method eliminar() {
        game.removeVisual(self)
        administradorDeProyectiles.destruirProyectil(self)
    }

    method verificarEnemigosEnfrente() = !administradorDeEnemigos.enemigos().any({enemigo => enemigo.position().y() == self.position().y() && enemigo.position().x() >= self.position().x()-2})

    method cambiarFrame() {
        imagen=proyectil.imagenes().get(frame)
        if(frame<2) {frame+=1}
    }
    method matarSlime(){}

    method cambiarAccion(accionNueva){}
    method tipo()=descartable
}
object descartable{
    method esperar(){}
}

// ===============================
// Proyectil Normal: Implementación específica de un proyectil normal
// ===============================
object proyectilNormal {
    // Métodos públicos
    const property imagenes = ["p.proyectilFuego - frame1.png", "p.proyectilFuego - frame2.png", "p.proyectilFuego - frame3.png"]
    method danio() = 40
    method destruirse() = true
    method puedeCombinarse() = true
    method mejora() = proyectilPenetrante

    method colisionar() ={proyectil=>
        const posicionEnFrente = new MutablePosition(x = proyectil.position().x() + 1, y = proyectil.position().y())
        const objetosEnPosicion = game.getObjectsIn(proyectil.position()) + game.getObjectsIn(posicionEnFrente)
        objetosEnPosicion.forEach({objeto =>objeto.recibeDanioEnemigo(proyectil.danio(),proyectil)})
    }



    method recibeDanioMago(danio,enemigo) ={enemigo=>}
}


// ===============================
// Proyectil Penetrante: Implementación específica de un proyectil penetrante
// ===============================
object proyectilPenetrante {
    // Métodos públicos
    const property imagenes = ["p.proyectilHielo-frame1.png", "p.proyectilHielo-frame2.png", "p.proyectilHielo-frame3.png"]
    method danio() = 45
    method destruirse() = false

    method puedeCombinarse() = true
    method mejora() = superProyectil

    method colisionar() = proyectilNormal.colisionar()
    method recibeDanioMago(_danio,enemigo)=proyectilNormal.recibeDanioMago(_danio, enemigo)
}
// ===============================
// Super Proyectil: Implementación específica de un super proyectil
// ===============================
object superProyectil {
    // Métodos públicos
    const property imagenes = ["p.superProyectil-1.png", "p.superProyectil-2.png", "p.superProyectil-3.png"]
    method danio() = 100
    method destruirse() = false
    method puedeCombinarse() = false
    method mejora() = self
    method colisionar() = proyectilNormal.colisionar()
    method recibeDanioMago(_danio,enemigo)=proyectilNormal.recibeDanioMago(_danio, enemigo)
}

object proyectilDeStop{
    const property imagenes = ["p.proyectilDeStop-frame1.png", "p.proyectilDeStop-frame2.png", "p.proyectilDeStop-frame3.png"]
    method danio() = 20
    method destruirse() = true
    method puedeCombinarse() = false
    method mejora() = self
    method colisionar() ={proyectil=>
        const posicionEnFrente = new MutablePosition(x = proyectil.position().x() + 1, y = proyectil.position().y())
        const objetosEnPosicion = game.getObjectsIn(proyectil.position()) + game.getObjectsIn(posicionEnFrente)
        objetosEnPosicion.forEach({objeto => objeto.recibeDanioEnemigo(proyectil.danio(),proyectil) objeto.cambiarAccion(objeto.tipo().esperar())})
    }
    method recibeDanioMago(_danio,enemigo)={
        enemigo=> enemigo.cambiarAccion(enemigo.tipo().esperar())
    }
}