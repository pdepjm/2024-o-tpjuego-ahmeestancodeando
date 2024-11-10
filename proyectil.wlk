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
    var property tipo
    const position = new MutablePosition()
    const property danio = tipo.danio()
    var frame = 0
    var imagen = tipo.imagenes().get(0)
    var texto = ""
   
    // Métodos públicos
    method position() = position
    method image() = imagen
    method frenarEnemigo() = false
    method sePuedeSuperponer() = true
    method text() = texto

    // Método de movimiento
    method mover() {
        imagen=tipo.imagenes().get(0)
        frame=1
        //game.onTick(190, "frame", {self.cambiarFrame()})
        //game.schedule(600, {game.removeTickEvent("frame")}) ESTOS POR SI QUEREMOS QUE CREEN SUS PROPIOS TICK PARA LAS ANIMACIONES
        position.goRight(1)
        if (self.llegueAlFinal() || self.verificarEnemigosEnfrente()) { self.eliminar() }
        
    }
    // Método que revisa si llego al final
    method llegueAlFinal() = position.x() >= 14
    // Método de colisión
    method colisionar() {
        const objetoEnMiCelda = game.getObjectsIn(self.position())
        const posicionEnFrente = new MutablePosition(x = position.x() + 1, y = position.y())
        const objetoEnFrente = game.getObjectsIn(posicionEnFrente)
        const colisionFrente = objetoEnFrente.any({ objeto => objeto.recibeDanioEnemigo(danio) })
        const colisionCelda = objetoEnMiCelda.any({ objeto => objeto.recibeDanioEnemigo(danio) })

        if (colisionFrente || colisionCelda) {
            self.destruirse()
        }
    }

    method combinar(){
        const objetoEnMiCelda = game.getObjectsIn(self.position())
        const posicionEnFrente = new MutablePosition(x = position.x() + 1, y = position.y())
        const objetoEnFrente = game.getObjectsIn(posicionEnFrente)
        const colisionFrente = objetoEnFrente.any({ objeto => objeto.combinarProyectil(tipo) && objeto != self })
        const colisionCelda = objetoEnMiCelda.any({ objeto => objeto.recibeDanioEnemigo(danio) && objeto != self })
        if (tipo.puedeCombinarse() && (colisionFrente || colisionCelda) ) {
            self.eliminar()
        }
    }

    method combinarProyectil(_tipo){
        if (_tipo.identity()==tipo.identity() && tipo.puedeCombinarse()){ 
            tipo = tipo.combinar()
            return true
            }
        return _tipo.identity()==tipo.identity() && tipo.puedeCombinarse()
    }

    // Métodos para recibir daño
    method recibeDanioEnemigo(_danio) {return false}
    method recibeDanioMago(_danio) { }

    // Método para destruir el proyectil
    method destruirse() {
        if (tipo.destruirse()) { self.eliminar()}
    }

    // Método para eliminar el proyectil
    method eliminar() {
        game.removeVisual(self)
        administradorDeProyectiles.destruirProyectil(self)
    }

    method verificarEnemigosEnfrente() = !administradorDeEnemigos.enemigos().any({enemigo => enemigo.position().y() == self.position().y() && enemigo.position().x() >= self.position().x()-2})
    
    method cambiarFrame() {
        imagen=tipo.imagenes().get(frame)
        if(frame<2) {frame+=1}
        else frame=2
    }
    method matarSlime(){}
}


// ===============================
// Proyectil Normal: Implementación específica de un proyectil normal
// ===============================
object proyectilNormal {
    // Métodos públicos
    const property imagenes = ["p.proyectilFuego - frame1.png", "p.proyectilFuego - frame2.png", "p.proyectilFuego - frame3.png"]
    method danio() = 50
    method destruirse() = true
    method combinar() = proyectilPenetrante
    method puedeCombinarse() = true
}


// ===============================
// Proyectil Penetrante: Implementación específica de un proyectil penetrante
// ===============================
object proyectilPenetrante {
    // Métodos públicos
    const property imagenes = ["p.proyectilHielo-frame1.png", "p.proyectilHielo-frame2.png", "p.proyectilHielo-frame3.png"]
    method danio() = 25
    method destruirse() = false
    method combinar() = superProyectil
    method puedeCombinarse() = true

}
// ===============================
// Proyectil Penetrante: Implementación específica de un proyectil penetrante
// ===============================
object superProyectil {
    // Métodos públicos
    const property imagenes = ["p.superProyectil-1.png", "p.superProyectil-2.png", "p.superProyectil-3.png"]
    method danio() = 50
    method destruirse() = false
    method combinar() = self
    method puedeCombinarse() = false

}