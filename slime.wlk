// ===============================
// Revisado
// ===============================

import administradorDeEnemigos.*
import casa.*
import puntaje.puntaje

// ===============================
// Clase Base: Slime
// ===============================
class Slime {
    // Propiedades
    var property position
    const property tipo
    var property enMovimiento = true // Indica si el slime puede moverse
    var property vida = tipo.vida()
    const property danio = tipo.danio()
    var imagen = tipo.imagenesNormales().get(0)
    var frame = 0

    // Métodos de cambio de imagen
    method cambiarFrame() {
        imagen = tipo.imagenesNormales().get(frame)
        if (frame < 2) { frame += 1 }
    }

    // Métodos de visualización y estado
    method frenarEnemigo() = true
    method position() = position
    method image() = imagen
    method sePuedeSuperponer() = false
    var accion = tipo.moverse()

    method cambiarAccion(accionNueva) {
        accion = accionNueva
    }

    // Movimiento del Slime
    method movete() {
        imagen = tipo.imagenesNormales().get(0)
        self.estaMuerto()
        frame = 1
        accion.apply(self)
    }

    // Lógica para frenar el movimiento
    method meFreno() {
        const posicionEnFrente = new MutablePosition(x = self.position().x() - 1, y = self.position().y())
        const objetoEnCeldaEnFrente = game.getObjectsIn(posicionEnFrente)
        objetoEnCeldaEnFrente.forEach({ objeto => objeto.recibeDanioMago(danio, self) })
    }

    method meFreno(estado) { self.enMovimiento(estado); return true }

    // Métodos para recibir daño
    method recibeDanioMago(_danio, enemigo) {
        enemigo.cambiarAccion(enemigo.tipo().esperar())
        return false
    }

    method recibeDanioEnemigo(_danio, proyectil) {
        imagen = tipo.imagenesRecibeDanio().get(frame)
        self.vida(self.vida() - _danio)
        tipo.accionAlRecibirDanio().apply(self)
        proyectil.destruirse()
        return true
    }

    method combinarProyectil(_tipo) { return false }

    // Comprobación de estado de vida y eliminación
    method estaMuerto() { tipo.estaMuerto().apply(self) }

    method sinVida() = vida <= 0
    method llegoACasa() = self.position().x() == 0
    method matarSlime() { vida = 0 }

    // Eliminación del Slime
    method eliminar() {
        game.removeVisual(self)
        administradorDeEnemigos.eliminarEnemigo(self)
    }

    method proyectil() = false
    method mejorar(){}
}
// ===============================
// Tipos de Slime: Variantes
// ===============================

class Tipo{
     const property danio
    const property vida
    method desplazamiento() = 1
    const property imagenesNormales
    const property imagenesRecibeDanio
    const property imagen


    method esperar()={
        slime=>
            const posicionEnFrente = new MutablePosition(x = slime.position().x()-1, y = slime.position().y())
            const objetoEnCeldaSiguiente = game.getObjectsIn(posicionEnFrente)
            if(!objetoEnCeldaSiguiente.any({objeto=>objeto.frenarEnemigo()})) slime.cambiarAccion(self.moverse())
    }

    method moverse()={
        slime =>
            slime.position().goLeft(slime.tipo().desplazamiento())
            slime.meFreno()
    }

    method atacar()={
        slime=>
            const posicionEnFrente = new MutablePosition(x = slime.position().x()-1, y = slime.position().y())
            const objetoEnCeldaSiguiente = game.getObjectsIn(posicionEnFrente)
            if(!objetoEnCeldaSiguiente.any({objeto=>objeto.frenarEnemigo()})) slime.cambiarAccion(self.moverse())
            objetoEnCeldaSiguiente.forEach({objeto=>objeto.recibeDanioMago(danio,slime)})  
            
    }  

    method estaMuerto()= {
        slime=>

            if (slime.sinVida() || slime.llegoACasa()) {
                if (slime.llegoACasa()) {
                    const fila =  slime.position().y()
                    casa.recibirDanio(fila)
                } 
                slime.eliminar()
            }
            return slime.sinVida() || slime.llegoACasa()
    }

    method accionAlRecibirDanio() ={slime => return }
}

// ===============================
// Definición de los Slimes Específicos
// ===============================

object slimeBasico inherits Tipo(danio = 25, vida = 120, imagen = "s.slimeBase_01.png", 
    imagenesNormales = ["s.slimeBase_01.png", "s.slimeBase_02.png", "s.slimeBase_03.png"], 
    imagenesRecibeDanio = ["s.slimeBaseDanio_01.png", "s.slimeBaseDanio_02.png", "s.slimeBaseDanio_03.png"]) {}

object slimeGuerrero inherits Tipo(danio = 25, vida = 250, imagen = "s.slimeGuerrero_01.png", 
    imagenesNormales = ["s.slimeGuerrero_01.png", "s.slimeGuerrero_02.png", "s.slimeGuerrero_03.png"], 
    imagenesRecibeDanio = ["s.slimeGuerreroDanio_01.png", "s.slimeGuerreroDanio_02.png", "s.slimeGuerreroDanio_03.png"]) {}

object slimeNinja inherits Tipo(danio = 200, vida = 120, imagen = "s.slimeNinja_01.png", 
    imagenesNormales = ["s.slimeNinja_01.png", "s.slimeNinja_02.png", "s.slimeNinja_03.png"], 
    imagenesRecibeDanio = ["s.slimeNinjaDanio_01.png", "s.slimeNinjaDanio_02.png", "s.slimeNinjaDanio_03.png"]) {
        override method desplazamiento() = 2
}

object slimeBlessed inherits Tipo(danio = 200, vida = 300, imagen = "s.slimeBlessed_01.png", 
    imagenesNormales = ["s.slimeBlessed_01.png", "s.slimeBlessed_02.png", "s.slimeBlessed_03.png"], 
    imagenesRecibeDanio = ["s.slimeBlessedDanio_01.png", "s.slimeBlessedDanio_02.png", "s.slimeBlessedDanio_03.png"]) {}

object slimeLadron inherits Tipo(danio= 25, vida=120, imagen="s.slimeLadron_01.png",imagenesNormales=["s.slimeLadron_01.png","s.slimeLadron_02.png","s.slimeLadron_03.png"],imagenesRecibeDanio=["s.slimeLadronDanio_01.png","s.slimeLadronDanio_02.png","s.slimeLadronDanio_03.png"]) {
    
    override method atacar()={
        slime=>
            const posicionEnFrente = new MutablePosition(x = slime.position().x() - 1, y = slime.position().y())
            const objetoEnCeldaEnFrente = game.getObjectsIn(posicionEnFrente)
            puntaje.restarPuntos(200)
            if(!objetoEnCeldaEnFrente.any({objeto=>objeto.frenarEnemigo()})) slime.cambiarAccion(self.moverse())
            objetoEnCeldaEnFrente.forEach({ objeto => objeto.recibeDanioMago(danio,slime)})
    }
  
}

object slimeDorado inherits Tipo(danio=0, vida=175, imagen="s.slimeDorado_01.png",imagenesNormales=["s.slimeDorado_01.png","s.slimeDorado_02.png","s.slimeDorado_03.png"],imagenesRecibeDanio=["s.slimeDoradoDanio_01.png","s.slimeDoradoDanio_02.png","s.slimeDoradoDanio_03.png"]){
    override method desplazamiento() = 2

    override method moverse()={
        slime =>
        slime.position().goLeft(slime.tipo().desplazamiento())
    }

    override method estaMuerto()={slime=>
         if (slime.sinVida()) {
            puntaje.puntos(puntaje.puntos()+1000)
            slime.eliminar()
        }
        if(slime.llegoACasa()){slime.eliminar()}
        return slime.sinVida() || slime.llegoACasa()
    }

}
object slimeBomba inherits Tipo(danio=250, vida=180, imagen="s.slimeMedioOriente_01.png",imagenesNormales=["s.slimeMedioOriente_01.png","s.slimeMedioOriente_02.png","s.slimeMedioOriente_03.png"],imagenesRecibeDanio=["s.slimeMedioOrienteDanio_01.png","s.slimeMedioOrienteDanio_02.png","s.slimeMedioOrienteDanio_03.png"]){
    
    override method atacar()={
        slime=>
            const posicionEnFrente = new MutablePosition(x = slime.position().x()-1, y = slime.position().y())
            const posicionArriba = new MutablePosition(x = slime.position().x()-1, y = slime.position().y()+1)
            const posicionAbajo = new MutablePosition(x = slime.position().x()-1, y = slime.position().y()-1)
            const objetosAmatar= game.getObjectsIn(posicionArriba)+game.getObjectsIn(posicionAbajo)+game.getObjectsIn(posicionEnFrente)  
            objetosAmatar.forEach({ objeto => objeto.recibeDanioMago(danio,slime) })
            slime.eliminar()
        }

  }

object slimeAgil inherits Tipo(danio=50, vida=200, imagen="s.slimeAgil_01.png",imagenesNormales=["s.slimeAgil_01.png","s.slimeAgil_02.png","s.slimeAgil_03.png"],imagenesRecibeDanio=["s.slimeAgilDanio_01.png","s.slimeAgilDanio_02.png","s.slimeAgilDanio_03.png"]){

    override method accionAlRecibirDanio() = {slime=>self.cambiarDeCarril().apply(slime)}

    method cambiarDeCarril()={
        slime=>
            const newPosicionY = (slime.position().y()+((-1).randomUpTo(2))).max(0).min(4)
            const newPosicion = new MutablePosition(x = slime.position().x(), y = newPosicionY )//
            const oldPoscionY = slime.position().y()
            const objetos = game.getObjectsIn(newPosicion)
            if(objetos.all({objeto => objeto.sePuedeSuperponer()})){
                administradorDeEnemigos.aumentarLinea(newPosicionY)  
                administradorDeEnemigos.decrementarLinea(oldPoscionY)  
                slime.position(newPosicion)
            }
    }
}