import slime.*
import wollok.game.*
import administradorDeEnemigos.*
import administradorDeJuego.*


// ===============================
// Administrador de Oleadas: Control de las oleadas de enemigos
// ===============================
object administradorDeOleadas {
    const numOleadaFinal = 3
    const posiblesTipos = [slimeBasico, slimeBasico, slimeGuerrero, slimeNinja, slimeBlessed,slimeLadron]
    var oleadaActual = oleadaNormal
    var numeroOleada = 1
    const property oleadaInicial = game.tick(4000, {self.iniciarOleada() self.frenarTickInicial()},false)
    method frenarTickInicial()=oleadaInicial.stop()
    var property modoNiveles = false
    //cosas para funcionamiento con niveles
    const niveles = botonNiveles.niveles()
    var property numNivel = 1
    method nivel() = niveles.get(numNivel-1).nivel()
    method actualizarOleada(){if(modoNiveles) oleadaActual= self.nivel().oleadaActual()
    else oleadaActual=oleadaNormal}
    // Métodos de visualización y sonido
    method position() = new MutablePosition(x = 9, y = 5)
    method text() = "Oleada: " + numeroOleada.toString() + "     " + "Slimes Restantes: " + oleadaActual.enemigosRestantes().toString()
    method textColor() = "#FA0770"
    method enemigosVivos() = oleadaActual.enemigosVivos()
    const tickParaGenerarEnemigos=game.tick(oleadaActual.tiempoSpawn(),{self.spawnearOleada()},false)
    method spawnearOleada(){
            if (not administradorDeJuego.pausado()){
                    if (oleadaActual.ejecutando()) {
                        administradorDeEnemigos.generarEnemigo(oleadaActual.enemigos().anyOne())
                    } else if(oleadaActual.finalizo()){
                        if(modoNiveles){
                            self.siguienteOleadaNivel()
                        }
                        else{
                        self.siguienteOleada()}
                        tickParaGenerarEnemigos.stop()
                        
                    }
                } }
    // Inicia la oleada y gestiona enemigos
    method iniciarOleada() {
        oleadaActual.iniciarOleada()
        tickParaGenerarEnemigos.start()
    }

    // Pasa a la siguiente oleada
    method siguienteOleada() {
        // por ahora funciona , si intento mejorar la logica se rompe 
        numeroOleada += 1
        if (numeroOleada > numOleadaFinal){
            oleadaActual.terminarOleada()
        } else {
            oleadaActual.terminarOleada()
            if (numeroOleada == numOleadaFinal){ oleadaActual = oleadaFinal }
            oleadaInicial.interval(10000)
            oleadaInicial.start()
            /* game.schedule(10000, { self.iniciarOleada() }) */
        }
    }
    method siguienteOleadaNivel(){
        if(self.nivel().noTerminoNivel()){
            oleadaActual.terminarOleada()
            self.nivel().siguienteOleada()
            oleadaActual=self.nivel().oleadaActual()
            oleadaInicial.start()
        }
        else{
            self.nivel().resetearOleadas()
            numNivel+=1
            if(numNivel>niveles.size()){
                pantalla.nuevoEstado(victoria)
                administradorDeJuego.terminarJuego() 
            }
            else{
            oleadaActual=self.nivel().oleadaActual()
            oleadaInicial.start()}
        }
    }
    // Gestión de contadores de enemigos
    method reducirEnemigo() { oleadaActual.seMurioEnemigo()}
    method sumarEnemigo() { oleadaActual.seGeneroEnemigo() }

    // Selecciona un tipo de slime aleatorio en función de la oleada
    method agregarTipo(numero) { return posiblesTipos.get(0.randomUpTo(numero + 4).round())}

    // Resetea el administrador de oleadas
    method reset() {
        game.removeTickEvent("gestionar oleada")
        oleadaNormal.reset()
        oleadaFinal.reset()
        niveles.forEach({botonNivel=>botonNivel.nivel().resetearOleadas()})
        numeroOleada = 1
        numNivel=1
        self.actualizarOleada()
        self.frenarTickInicial()
        oleadaInicial.interval(4000)
        tickParaGenerarEnemigos.stop()
        //game.schedule(4000, { self.iniciarOleada() })
    }
    method recibeDanioMago(danio){}
    method frenarEnemigo()= true
}


// ===============================
// Oleada Normal: Configuración y gestión de una oleada estándar
// ===============================
object oleadaNormal {
    var property enemigos =  [slimeAgil]
    var property cantidadEnemigos = 10
    var property enemigosRestantes = cantidadEnemigos 
    var property enemigosGenerados = 0
    var property tiempoSpawn = 3000
    const cantSlimesPosibles = 4

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
        cantidadEnemigos += 5
        enemigosGenerados = 0
        if (tiempoSpawn > 400) tiempoSpawn -= 400
        enemigos = []
        game.onTick(100, "agregar slimes posibles", { self.agregarSlimes() })
        self.finOleada().volume(0.1)
        self.finOleada().play()
    }

    method iniciarOleada(){
        self.inicioOleada().volume(0)
        //self.inicioOleada().play()
        enemigosRestantes = cantidadEnemigos
    }


    // Agrega slimes a la oleada hasta alcanzar el límite
    method agregarSlimes() { 
        if (enemigos.size() < cantSlimesPosibles) {
            enemigos.add(administradorDeOleadas.agregarTipo(0))
        } else {
            game.removeTickEvent("agregar slimes posibles")
        }
    }

    // Resetea la oleada a su configuración inicial
    method reset() {
        enemigos = [slimeBasico]
        cantidadEnemigos = 10
        enemigosRestantes = cantidadEnemigos 
        enemigosGenerados = 0
        tiempoSpawn = 3000
    }
    
}


// ===============================
// Oleada Final: Configuración y gestión de la oleada final
// ===============================
object oleadaFinal {
    const property enemigos = [slimeBlessed]
    const property cantidadEnemigos = 20
    var property enemigosRestantes = cantidadEnemigos 
    var property enemigosGenerados = 0
    const property tiempoSpawn = 400

    // Verifica si la oleada final está en ejecución
    method ejecutando() = cantidadEnemigos > enemigosGenerados && enemigosRestantes > 0

    method seGeneroEnemigo() {enemigosGenerados+=1}

    method seMurioEnemigo() {enemigosRestantes-=1}

    method inicioOleada() = game.sound("m.iOleada.mp3")

    method enemigosVivos() =  enemigosGenerados - (cantidadEnemigos - enemigosRestantes) 

    // Termina la oleada final y concluye el juego
    method terminarOleada() {
        pantalla.nuevoEstado(victoria)
        administradorDeJuego.terminarJuego()

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

class OleadaDeNivel{
    const property enemigos
    const property cantidadEnemigos
    var property enemigosRestantes = cantidadEnemigos 
    var property enemigosGenerados = 0
    const property tiempoSpawn

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

class Nivel{
    const oleadas
    var numOleada=0
    method oleadaActual()= if (numOleada<oleadas.size())oleadas.get(numOleada) else return oleadaNormal
    method noTerminoNivel()=numOleada!=oleadas.size()-1
    method siguienteOleada(){numOleada+=1}
    method resetearOleadas(){
        oleadas.forEach({oleada=> oleada.reset()})
        numOleada=0
    }
} 

const oleadaUnoUno = new OleadaDeNivel(enemigos=[slimeBasico,slimeGuerrero,slimeGuerrero],tiempoSpawn=4000,cantidadEnemigos=5)
const oleadaUnoDos = new OleadaDeNivel(enemigos=[slimeLadron,slimeBasico],tiempoSpawn=4000,cantidadEnemigos=6)
const oleadaDosUno = new OleadaDeNivel(enemigos=[slimeBasico,slimeDorado],tiempoSpawn=4000,cantidadEnemigos=3)
const oleadaDosDos = new OleadaDeNivel(enemigos=[slimeAgil,slimeBasico,slimeBasico],tiempoSpawn=4000,cantidadEnemigos=4)

const nivelUno=new Nivel(oleadas=[oleadaUnoUno,oleadaUnoDos])
const nivelDos=new Nivel(oleadas=[oleadaDosUno,oleadaDosDos])