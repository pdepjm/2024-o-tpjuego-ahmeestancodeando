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

    // Métodos de visualización y estado
    method frenarEnemigo() = true
    method position() = position
    method image() = tipo.imagen()
    method sePuedeSuperponer() = false

    // Movimiento del Slime
    method movete() {tipo.moverse().apply(self)}

    // Lógica para frenar el movimiento
     method meFreno() {tipo.meFreno().apply(self)}
     method meFreno(estado) {self.enMovimiento(estado) return true}

    // Métodos para recibir daño
    method recibeDanioMago(_danio){}

    method recibeDanioEnemigo(_danio) {
        self.vida(self.vida() - _danio)
        tipo.accionAlRecibirDanio().apply(self)
        return true 
        tipo.accionAlRecibirDanio().apply(self)
        return true 
    }

    method combinarProyectil(_tipo){return false}

    // Comprobación de estado de vida y eliminación
    method estaMuerto() {tipo.estaMuerto().apply(self)}

    method sinVida() = vida <= 0
    method llegoACasa() = self.position().x() == 0
    method matarSlime() { vida = 0 }

    // Eliminación del Slime
    method eliminar() {
        game.removeVisual(self)
        administradorDeEnemigos.eliminarEnemigo(self)
    }
    method tipoProyectil()=false
}
// ===============================
// Tipos de Slime: Variantes
// ===============================

class Tipo{
    const property danio
    const property vida
    method desplazamiento() = 1
    const  imagen="s.slimeBase.png"
    method imagen() {return imagen} 
    method moverse()={slime=> slime.estaMuerto()
        if (slime.enMovimiento()) 
            slime.position().goLeft(slime.tipo().desplazamiento())
        else 
            slime.enMovimiento(false)
        slime.meFreno()    
            }
    method meFreno()={slime=> 
        const posicionEnFrente = new MutablePosition(x = slime.position().x() - 1, y = slime.position().y())
        const objetoEnCeldaEnFrente = game.getObjectsIn(posicionEnFrente)

        if (objetoEnCeldaEnFrente.any({ objeto => objeto.frenarEnemigo()})) { 
            slime.enMovimiento(false)
            objetoEnCeldaEnFrente.forEach({ objeto => objeto.recibeDanioMago(danio) })
        } else {
            slime.enMovimiento(true)
        }
    }
    method estaMuerto()= {slime=>
        if (slime.llegoACasa()||slime.position().y()>4||slime.position().y()<0) {
            casa.recibirDanio(slime.position().y())
            slime.eliminar()
        } else if (slime.sinVida()) {
            slime.eliminar()
        }
        return slime.sinVida() || slime.llegoACasa()
    }
     method accionAlRecibirDanio() ={slime => return }
}

  object slimeBasico inherits Tipo(danio= 25, vida=100, imagen="s.slimeBase.png") { 
  }

  object slimeGuerrero inherits Tipo(danio= 25, vida=200, imagen="s.slimeGuerrero.png"){ 
  }

  object slimeNinja inherits Tipo(danio= 200, vida=120, imagen="s.slimeNinja.png") { 
    override method desplazamiento() = 2
  }

  object slimeBlessed inherits Tipo(danio= 200, vida=300, imagen="s.slimeBlessed.png"){ 
  }

object slimeLadron inherits Tipo(danio= 25, vida=160, imagen="s.slimeLadron.png") {

   override method meFreno()={slime=> 
        const posicionEnFrente = new MutablePosition(x = slime.position().x() - 1, y = slime.position().y())
        const objetoEnCeldaEnFrente = game.getObjectsIn(posicionEnFrente)
        if (objetoEnCeldaEnFrente.any({ objeto => objeto.frenarEnemigo() })) { 
            slime.enMovimiento(false)
            puntaje.restarPuntos(200)
            objetoEnCeldaEnFrente.forEach({ objeto => objeto.recibeDanioMago(danio) })
        } else {
            slime.enMovimiento(true)
        }
    }
   
}

object slimeDorado inherits Tipo(danio=0, vida=175, imagen="s.slimeDorado.png"){
    override method desplazamiento() = 2
    override method meFreno()={slime=>slime.enMovimiento(true)}
    override method estaMuerto()={slime=>
         if (slime.sinVida()) {
            puntaje.puntos(puntaje.puntos()+1000)
        }
        slime.eliminar()
        return slime.sinVida() || slime.llegoACasa()  
    }
}

object slimeDeMedioOriente inherits Tipo(danio=250, vida=180, imagen="s.slimeMedioOriente.png"){ 

    override method meFreno()={slime=> 
        const posicionEnFrente = new MutablePosition(x = slime.position().x(), y = slime.position().y())
        const objetoEnCeldaSiguiente = game.getObjectsIn(posicionEnFrente)

        if (objetoEnCeldaSiguiente.any({ objeto => objeto.frenarEnemigo() && !objeto.recibeDanioEnemigo(0)})) { 
            slime.enMovimiento(false)
            const posicionArriba = new MutablePosition(x = slime.position().x(), y = slime.position().y()+1)
            const posicionAbajo = new MutablePosition(x = slime.position().x(), y = slime.position().y()-1)
            const objetosAmatar= game.getObjectsIn(posicionArriba)+game.getObjectsIn(posicionAbajo)+objetoEnCeldaSiguiente
            objetosAmatar.forEach({ objeto => objeto.recibeDanioMago(danio) })
            slime.eliminar()
        } else {
            slime.enMovimiento(true)
        }}
   
  }

object slimeAgil inherits Tipo(danio=50, vida=450, imagen="s.slimeAgil.png"){

    override method accionAlRecibirDanio() = {slime=>
       if(slime.vida()<=self.vida()*0.5){
        self.cambiarDeCarril().apply(slime)
        }
    }
    method cambiarDeCarril()={slime=>
        const posicionArriba= new MutablePosition(x = slime.position().x(), y = slime.position().y()+1)
        const posicionAbajo= new MutablePosition(x = slime.position().x(), y = slime.position().y()-1)
        const celA=game.getObjectsIn(posicionArriba)
        const celAB=game.getObjectsIn(posicionAbajo)
        const celdaArriba= [celA,posicionArriba]
        const celdaAbajo= [celAB,posicionAbajo]
        const posiciones = [celdaArriba,celdaAbajo]
        posiciones.any({ celda => celda.get(0).all({objeto=>!objeto.frenarEnemigo()})    &&  self.moverAcarrilAledanio(slime, celda.get(1))})
    }
    method moverAcarrilAledanio(slime,carril){
        if(carril.y()<5 && carril.y()>=0 ){
        slime.position(carril)
        }
    }
}