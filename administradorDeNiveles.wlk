import slime.*
import wollok.game.*
import administradorDeEnemigos.*
import administradorDeJuego.*


// ===============================
// Administrador de Oleadas: Control de las oleadas de enemigos
// ===============================
object administradorDeNiveles {
    const niveles = botonNiveles.niveles()
    var property numNivel = 1
    method nivel() = niveles.get(numNivel-1).nivel()

    // Métodos de visualización y sonido
    method position() = new MutablePosition(x = 9, y = 5)
    method text() = "Nivel: " + numNivel.toString() + "     " + "Slimes Restantes: " + self.nivel().enemigosRestantes().toString()
    method textColor() = "#FA0770"
    method enemigosVivos() = self.nivel().enemigosVivos()

    // Inicia la oleada y gestiona enemigos
    method iniciarOleada() {
        self.nivel().iniciarOleada()
        game.onTick(
            self.nivel().tiempoSpawn(),
            "gestionar oleada",
            { 
               if (not administradorDeJuego.pausado()){
                    if (self.nivel().ejecutando()) {
                        administradorDeEnemigos.generarEnemigo(self.nivel().enemigos().anyOne())
                    } else if(self.nivel().finalizo()){
                        self.siguienteOleada()
                        game.removeTickEvent("gestionar oleada")

                    }
                } 
            }
        )
    }

    // Pasa a la siguiente oleada
    method siguienteOleada() {
        // por ahora funciona , si intento mejorar la logica se rompe 
        
        self.nivel().terminarOleada()
        if (numNivel == niveles.size()){
            pantalla.estado(victoria) game.addVisual(pantalla) 
        return}
        else {numNivel += 1 game.schedule(10000, { self.iniciarOleada() })}   
    }

    // Gestión de contadores de enemigos
    method reducirEnemigo() { self.nivel().seMurioEnemigo()}
    method sumarEnemigo() { self.nivel().seGeneroEnemigo()}


    // Resetea el administrador de oleadas
    method reset() {
        game.removeTickEvent("gestionar oleada")
        niveles.forEach({nivelAResetear=>nivelAResetear.nivel().reset()})
        numNivel = 1
        game.schedule(4000, { self.iniciarOleada() })
    }
    method recibeDanioMago(danio){}
    method frenarEnemigo()= true
}

class Nivel {
    const property enemigos 
    var property cantidadEnemigos
    const property tiempoSpawn
    var property enemigosRestantes = cantidadEnemigos 
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

const nivel1= new Nivel(enemigos=[slimeBasico],cantidadEnemigos=5,tiempoSpawn=4000)
const nivel2= new Nivel(enemigos=[slimeGuerrero,slimeGuerrero,slimeBasico],cantidadEnemigos=10,tiempoSpawn=4000)