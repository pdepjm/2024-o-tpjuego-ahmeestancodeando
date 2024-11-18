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
    method movete() {tipo.moverse().apply(self)}/* {
        self.estaMuerto()
        self.meFreno()
        if (self.enMovimiento()) 
            return position.goLeft(tipo.desplazamiento())
        else 
            self.enMovimiento(false)
    } */

    // Lógica para frenar el movimiento
     method meFreno() {tipo.meFreno().apply(self)}
     method meFreno(estado) {self.enMovimiento(estado) return true}/*{
        const posicionEnFrente = new MutablePosition(x = self.position().x() - 1, y = self.position().y())
        const objetoEnCeldaEnFrente = game.getObjectsIn(posicionEnFrente)

        if (objetoEnCeldaEnFrente.any({ objeto => objeto.frenarEnemigo() })) { 
            self.enMovimiento(false)
            objetoEnCeldaEnFrente.forEach({ objeto => objeto.recibeDanioMago(danio) })
        } else {
            self.enMovimiento(true)
        }
    } */

    // Métodos para recibir daño
    method recibeDanioMago(_danio){}

    method recibeDanioEnemigo(_danio) {
        self.vida(self.vida() - _danio)
        tipo.accionAlRecibirDanio().apply(self)
        return true 
    }

    method combinarProyectil(_tipo){return false}


    // Comprobación de estado de vida y eliminación
    method estaMuerto() {tipo.estaMuerto().apply(self)
      /*   if (self.llegoACasa()) {
            casa.recibirDanio(self.position().y())
            self.eliminar()
        } else if (self.sinVida()) {
            self.eliminar()
        }
        return self.sinVida() || self.llegoACasa() */
    }

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
  object slimeBasico { 
    const property danio = 25
    const property vida= 100
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
            game.sound("m.deathScreen.mp3").play()
            casa.recibirDanio(slime.position().y())
            slime.eliminar()
        } else if (slime.sinVida()) {
            game.sound("m.explosion.mp3").play()
            slime.eliminar()
        }
        return slime.sinVida() || slime.llegoACasa()
    }
     method accionAlRecibirDanio() ={slime => return }
  }

  object slimeNinja { 
    const property danio = 200
    const property vida= 120
    method desplazamiento() = 2
    const imagen="s.slimeNinja.png"
    method imagen() {return imagen} 
    method moverse()= slimeBasico.moverse()
    method meFreno()=slimeBasico.meFreno()
    method estaMuerto()=slimeBasico.estaMuerto()
    method recibeDanioEnemigo(_danio) = slimeBasico.accionAlRecibirDanio()
  }

  object slimeGuerrero { 
    const property danio = 25
    const property vida= 200
    method desplazamiento() = 1
    const imagen = "s.slimeGuerrero.png"
    method imagen() {return imagen} 
    method moverse()= slimeBasico.moverse()
    method meFreno()=slimeBasico.meFreno()
    method estaMuerto()=slimeBasico.estaMuerto()
    method recibeDanioEnemigo(_danio) = slimeBasico.accionAlRecibirDanio()
  }

  object slimeBlessed { 
    const property danio = 200
    const property vida= 300
    method desplazamiento() = 1
    const imagen="s.slimeBlessed.png"
    method imagen() {return imagen} 
    method moverse()= slimeBasico.moverse()
    method meFreno()=slimeBasico.meFreno()
    method estaMuerto()=slimeBasico.estaMuerto()
    method recibeDanioEnemigo(_danio) = slimeBasico.accionAlRecibirDanio()
  }


object  slimeLadron {
    const property danio = 25
    const property vida= 160
    method desplazamiento() = 1
    const imagen="s.slimeLadron.png"
    method imagen() {return imagen} 
    method moverse()= slimeBasico.moverse()
    method meFreno()={slime=> 
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
    method estaMuerto()=slimeBasico.estaMuerto()
    method recibeDanioEnemigo(_danio) = slimeBasico.accionAlRecibirDanio()
}

object  slimeDorado {
    const property danio = 0
    const property vida= 175
    method desplazamiento() = 2
    const imagen="s.slimeDorado.png"
    method imagen() {return imagen} 
    method moverse()= slimeBasico.moverse()
    method meFreno()={slime=>slime.enMovimiento(true)}
    method estaMuerto()={slime=>
        if (slime.llegoACasa()) {
            slime.eliminar()
        } else if (slime.sinVida()) {
            puntaje.puntos(puntaje.puntos()+1000)
            slime.eliminar()
        }
        return slime.sinVida() || slime.llegoACasa()  
    }
    method recibeDanioEnemigo(_danio) = slimeBasico.accionAlRecibirDanio()
}

object slimeDeMedioOriente{ 
    const property danio = 250
    const property vida= 180
    method desplazamiento() = 1
    const imagen="s.slimeMedioOriente.png"
    method imagen() {return imagen} 
    method moverse()= slimeBasico.moverse()
    method meFreno()={slime=> 
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
    method estaMuerto()=slimeBasico.estaMuerto()
    method recibeDanioEnemigo(_danio) = slimeBasico.accionAlRecibirDanio()
  }

object slimeAgil{
    const property danio = 50
    const property vida= 450
    method desplazamiento() = 1
    const imagen="s.slimeAgil.png"
    method imagen() {return imagen} 
    method moverse()= slimeBasico.moverse()
    method meFreno()=slimeBasico.meFreno()
    method estaMuerto()= slimeBasico.estaMuerto()
    method accionAlRecibirDanio() = {slime=>
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