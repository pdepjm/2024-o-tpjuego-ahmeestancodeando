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
    var property enemigosRestantes = niveles.get(numNivel-1).nivel().cantidadEnemigos()

    // Métodos de visualización y sonido
    method position() = new MutablePosition(x = 9, y = 5)
    method text() = "Nivel: " + numNivel.toString() + "     " + "Slimes Restantes: " + enemigosRestantes.toString()
    method textColor() = "#FA0770"
    method enemigosVivos() = self.nivel().enemigosVivos()
    const property oleadaInicial = game.tick(4000, {self.iniciarOleada() self.frenarTickInicial()},false)
    method frenarTickInicial() { oleadaInicial.stop()}
    // Inicia la oleada y gestiona enemigos
    const tickParaGenerarEnemigos= game.tick(self.nivel().tiempoSpawn(),
            {self.spawnearOleada()} 
            ,false)
    method iniciarOleada() {
        self.nivel().iniciarOleada()
        tickParaGenerarEnemigos.start()      
    }
    method spawnearOleada(){ if (not administradorDeJuego.pausado()){
                    if (self.nivel().ejecutando()) {
                        administradorDeEnemigos.generarEnemigo(self.nivel().enemigos().anyOne())
                    } else if(self.nivel().finalizo()){
                        self.siguienteOleada()
                        tickParaGenerarEnemigos.stop()
                    }}}
    // Pasa a la siguiente oleada
    method siguienteOleada() {
        // por ahora funciona , si intento mejorar la logica se rompe 
        
        self.nivel().terminarOleada()
        if (numNivel == niveles.size()){
            pantalla.estado(victoria) game.addVisual(pantalla) 
        return}
        else {numNivel += 1 
        enemigosRestantes = niveles.get(numNivel-1).nivel().cantidadEnemigos()
        tickParaGenerarEnemigos.interval(self.nivel().tiempoSpawn())
        oleadaInicial.interval(10000)
        oleadaInicial.start()
        /* game.schedule(10000, { self.iniciarOleada()} )*/}   
    }
    
    // Gestión de contadores de enemigos
    method reducirEnemigo() { self.nivel().seMurioEnemigo() 
    enemigosRestantes-=1}
    method sumarEnemigo() { self.nivel().seGeneroEnemigo()}


    // Resetea el administrador de oleadas
    method reset() {
        
        niveles.forEach({nivelAResetear=>nivelAResetear.nivel().reset()})
        numNivel = 1
        tickParaGenerarEnemigos.stop()
        oleadaInicial.interval(4000)
        enemigosRestantes = niveles.get(numNivel-1).nivel().cantidadEnemigos()
        //game.schedule(4000, { self.iniciarOleada() })
        self.frenarTickInicial()
    }
    method recibeDanioMago(danio){}
    method frenarEnemigo()= true
}

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