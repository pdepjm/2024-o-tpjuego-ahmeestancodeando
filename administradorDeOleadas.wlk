import slime.*
import wollok.game.*
import administradorDeEnemigos.*
import administradorDeJuego.*


// ===============================
// Administrador de Oleadas: Control de las oleadas de enemigos
// ===============================
object administradorDeOleadas {
    const numOleadaFinal = 3
    var nivelActual = nivelInfinito
    var numeroOleada = 1
    const property oleadaInicial = game.tick(4000, {self.frenarTickInicial() self.iniciarOleada()},false)
    method frenarTickInicial()=oleadaInicial.stop()
    var property modoNiveles = false
    //cosas para funcionamiento con niveles
    const niveles = botonNiveles.niveles()
    var property numNivel = 1
    method nivel() = niveles.get(numNivel-1).nivel()
    method actualizarOleada(){if(modoNiveles) nivelActual= self.nivel()
    else nivelActual=nivelInfinito}
    // Métodos de visualización y sonido
    method position() = new MutablePosition(x = 9, y = 5)
    method text() = "Oleada: " + numeroOleada.toString() + "     " + "Slimes Restantes: " + nivelActual.enemigosRestantes().toString()
    method textColor() = "#FA0770"
    method enemigosVivos() = nivelActual.enemigosVivos()
    const tickParaGenerarEnemigos=game.tick(nivelActual.tiempoSpawn(),{self.spawnearOleada()},false)
    method spawnearOleada(){
            if (not administradorDeJuego.pausado()){
                    if (nivelActual.ejecutando()) {
                        administradorDeEnemigos.generarEnemigo(nivelActual.enemigos().anyOne())
                    } else if(nivelActual.finalizo()){
                        self.siguienteOleadaNivel()
                        tickParaGenerarEnemigos.stop()
                    }
                } }
    // Inicia la oleada y gestiona enemigos
    method iniciarOleada() {
        nivelActual.iniciarOleada()
        tickParaGenerarEnemigos.start()
    }

    method siguienteOleadaNivel(){
        if(nivelActual.noTerminoNivel()){
            nivelActual.siguienteOleada()
            oleadaInicial.start()
        }
        else{
            nivelActual.reset()
            numNivel+=1
            if(numNivel>niveles.size()){
                pantalla.nuevoEstado(victoria)
                administradorDeJuego.terminarJuego() 
            }
            else{
            nivelActual=self.nivel()
            oleadaInicial.start()}
        }
    }
    // Gestión de contadores de enemigos
    method reducirEnemigo() { nivelActual.seMurioEnemigo()}
    method sumarEnemigo() { nivelActual.seGeneroEnemigo() }

    // Selecciona un tipo de slime aleatorio en función de la oleada
    //method agregarTipo(numero) { return posiblesTipos.get(0.randomUpTo(numero + 4).round())}

    // Resetea el administrador de oleadas
    method reset() {
        self.frenarTickInicial()
        oleadaInicial.interval(4000)
        tickParaGenerarEnemigos.stop()
        nivelActual.reset()
        niveles.forEach({botonNivel=>botonNivel.nivel().resetearOleadas()})
        numeroOleada = 1
        numNivel=1
        self.actualizarOleada()
        //game.schedule(4000, { self.iniciarOleada() })
    }
    method recibeDanioMago(danio){}
    method frenarEnemigo()= true
}


class Nivel{
    const oleadas
    const property cantidadEnemigos
    var property enemigosRestantes = cantidadEnemigos 
    var property enemigosGenerados = 0
    const property tiempoSpawn

    method enemigos()=oleadas.get(numOleada)
    var numOleada=0
    method oleadaActual()= oleadas.get(numOleada)
    method noTerminoNivel()=numOleada!=oleadas.size()-1
    method siguienteOleada(){numOleada+=1 self.reset()}
    method resetearOleadas(){
        numOleada=0
    }
    method inicioOleada() = game.sound("m.iOleada.mp3")
    method finOleada() = game.sound("m.fOleada.mp3")
    // Verifica si la oleada final está en ejecución
    method ejecutando() = cantidadEnemigos > enemigosGenerados && enemigosRestantes > 0

    method seGeneroEnemigo() {enemigosGenerados+=1}

    method seMurioEnemigo() {enemigosRestantes-=1}

    method enemigosVivos() =  enemigosGenerados - (cantidadEnemigos - enemigosRestantes) 

    // Termina la oleada final y concluye el juego
    method terminarOleada() {
        self.finOleada().volume(0.1)
        self.finOleada().play()

    }

        method iniciarOleada(){
        self.inicioOleada().volume(0)
        //self.inicioOleada().play()
        enemigosRestantes = cantidadEnemigos
    }



    method cargarSlimesRestantes () {enemigosRestantes = cantidadEnemigos }
    // Verifica si la oleada final ha finalizado
    method finalizo() = enemigosRestantes == 0 && enemigosGenerados == cantidadEnemigos

    // Resetea la oleada final
    method reset() {
        enemigosGenerados = 0
        enemigosRestantes = cantidadEnemigos
    }

} 

const nivel1 = new Nivel(oleadas=[[slimeDeMedioOriente,slimeBasico,slimeBasico],[slimeBasico,slimeGuerrero,slimeGuerrero],[slimeLadron,slimeBasico]],tiempoSpawn=4000, cantidadEnemigos=5)
const nivel2 = new Nivel(oleadas=[[slimeBasico,slimeDorado],[slimeAgil,slimeBasico,slimeBasico]],tiempoSpawn=4000, cantidadEnemigos=4)

//algo asi deberia ser nivefinal
object nivelInfinito inherits Nivel(oleadas = [slimeBasico],tiempoSpawn=4000,cantidadEnemigos=3){
    const posiblesEnemigos=[slimeBasico, slimeGuerrero, slimeNinja, slimeBlessed,slimeLadron]
    const oleadaAleatoria=[slimeBasico]
     method cambiarEnemigosOleada(){
        oleadaAleatoria.clear()
        
        oleadaAleatoria.add(posiblesEnemigos.get(0.randomUpTo(posiblesEnemigos.size()-1).round()))
        oleadaAleatoria.add(posiblesEnemigos.get(0.randomUpTo(posiblesEnemigos.size()-1).round()))
        oleadaAleatoria.add(posiblesEnemigos.get(0.randomUpTo(posiblesEnemigos.size()-1).round()))
        oleadaAleatoria.add(posiblesEnemigos.get(0.randomUpTo(posiblesEnemigos.size()-1).round())) 
    } 
    override method siguienteOleada(){self.cambiarEnemigosOleada()  self.reset()}
    override method enemigos()=oleadaAleatoria
    override method oleadaActual()= oleadaAleatoria
    override method noTerminoNivel()=true
}
//algo asi deberia ser nive Infinito
// nivel = new Nivel(enemigos=[[basico, basico, gerrero], [guerrero, ladron]])