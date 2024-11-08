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
    const property tipo
    const position = new MutablePosition()
    const property danio = tipo.danio()
    var frame = 0
    var imagen = tipo.imagenes().get(0)
   
    // Métodos públicos
    method position() = position
    method image() = imagen
    method frenarEnemigo() = false
    method sePuedeSuperponer() = true

    // Método de movimiento
    method mover() {
        imagen=tipo.imagenes().get(0)
        frame=0
        //game.onTick(190, "frame", {self.cambiarFrame()})
        //game.schedule(600, {game.removeTickEvent("frame")}) ESTOS POR SI QUEREMOS QUE CREEN SUS PROPIOS TICK PARA LAS ANIMACIONES
        if (self.llegueAlFinal() || self.verificarEnemigosEnfrente()) { self.eliminar() }
        self.colisionar()
        position.goRight(1)
    }
    // Método que revisa si llego al final
    method llegueAlFinal() = position.x() >= 14
    // Método de colisión
    method colisionar() {
        const objetoEnMiCelda = game.getObjectsIn(self.position())
        const posicionEnFrente = new MutablePosition(x = position.x() + 1, y = position.y())
        const objetoEnFrente = game.getObjectsIn(posicionEnFrente)
        const colisionFrente = objetoEnFrente.any({ objeto => objeto.recibeDanioEnemigo(danio)   /*  */})
        const colisionEntreProyectiles = objetoEnFrente.any({objeto => objeto.combinarProyectil(self)})
        const colisionCelda = objetoEnMiCelda.any({ objeto => objeto.recibeDanioEnemigo(danio)})
        if (colisionFrente || colisionCelda) {
            self.destruirse()
        }
        else return false
        
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
        else {self.mover()}
        //game.schedule(150, {self.colisionar()})}
    }
    method matarSlime(){}
   ///////////MAGIA MAROCA///////////////
    method combinarProyectil(proyectil){
    if(self.tipo()==proyectil.tipo()){
        const superProyectil = object {
            var property imagenes = proyectilNormal.imagenes()
            var property danioCombinado = 150
            method danio() = danioCombinado
            var property valorDeDestruirse = true
            method destruirse() = valorDeDestruirse
        }
        superProyectil.danioCombinado(self.danio()+proyectil.danio())
        superProyectil.valorDeDestruirse(self.tipo().destruirse())
        superProyectil.imagenes(self.tipo().imagenes())
        administradorDeProyectiles.generarProyectil(new MutablePosition(x = proyectil.position().x()+1, y = proyectil.position().y()), superProyectil)
        proyectil.eliminar()
        self.eliminar()
    }
   
   }
    /////////////////////////////////////

}
class MyException inherits wollok.lang.Exception {}
/* object superProyectil {
    var property tipo = proyectilNormal
    const property imagenes = tipo.imagenes()
    var property proyectilACombinar = proyectilNormal
    const danio =  proyectilACombinar.danio() + tipo.danio()
    method danio() = danio
    method destruirse() = tipo.destruirse()
} */

class SuperProyectil{
    const tipo
    var property proyectilACombinar
    const property imagenes = tipo.imagen()
    method danio() = proyectilACombinar.danio() + tipo.danio()
    method destruirse() = tipo.destruirse()
}

// ===============================
// Proyectil Normal: Implementación específica de un proyectil normal
// ===============================
object proyectilNormal {
    // Métodos públicos
    const property imagenes = ["p.proyectilFuego - frame1.png", "p.proyectilFuego - frame2.png", "p.proyectilFuego - frame3.png"]
    method danio() = 50
    method destruirse() = true
 
}


// ===============================
// Proyectil Penetrante: Implementación específica de un proyectil penetrante
// ===============================
object proyectilPenetrante {
    // Métodos públicos
    const property imagenes = ["p.proyectilHielo-frame1.png", "p.proyectilHielo-frame2.png", "p.proyectilHielo-frame3.png"]
    method danio() = 25
    method destruirse() = false
}


/* object superProyectilNormal(){
    const danioSumado
    const property imagenes
    method danio()= danioSumado + proyectilNormal.danio()
    } */