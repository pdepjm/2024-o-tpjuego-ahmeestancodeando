import slime.*
import wollok.game.*
import administradorDeEnemigos.*
import administradorDeJuego.*


// ===============================
// Administrador de Oleadas: Control de las oleadas de enemigos
// ===============================

class Nivel {
    const property enemigos 
    const property cantidadEnemigos
    const property tiempoSpawn
    var  enemigosRestantes = cantidadEnemigos 
    var property enemigosGenerados = 0
    
    method inicioOleada() = game.sound("m.iOleada.mp3")
    method finOleada() = game.sound("m.fOleada.mp3")

    method enemigosVivos() = enemigosGenerados - (cantidadEnemigos - enemigosRestantes) 
    // Verifica si la oleada está en ejecución
    method ejecutando() = cantidadEnemigos > enemigosGenerados && enemigosRestantes > 0

    // Verifica si la oleada ha finalizado
    method finalizo() = enemigosRestantes == 0 && enemigosGenerados == cantidadEnemigos

    method seGeneroEnemigo() {enemigosGenerados+=1}

    method seMurioEnemigo() {enemigosRestantes-=1}

    // Termina la oleada y configura la siguiente
    method terminarOleada() {
        self.finOleada().volume(0.1)
        self.finOleada().play()
    }

    method iniciarOleada(){
        self.inicioOleada().volume(0)
        //self.inicioOleada().play()
        enemigosRestantes = cantidadEnemigos
    }


    // Resetea la oleada a su configuración inicial
    method reset() {
        enemigosRestantes = cantidadEnemigos 
        enemigosGenerados = 0
    } 
}




const nivel1= new Nivel(enemigos=[slimeBasico],cantidadEnemigos=2,tiempoSpawn=4000)
const nivel2= new Nivel(enemigos=[slimeGuerrero,slimeGuerrero,slimeBasico],cantidadEnemigos=4,tiempoSpawn=4000)