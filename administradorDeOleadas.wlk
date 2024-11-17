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
    

    // Métodos de visualización y sonido
    method position() = new MutablePosition(x = 9, y = 5)
    method text() = "Oleada: " + numeroOleada.toString() + "     " + "Slimes Restantes: " + oleadaActual.enemigosRestantes().toString()
    method textColor() = "#FA0770"
    method enemigosVivos() = oleadaActual.enemigosVivos()

    // Inicia la oleada y gestiona enemigos
    method iniciarOleada() {
        oleadaActual.iniciarOleada()
        game.onTick(
            oleadaActual.tiempoSpawn(),
            "gestionar oleada",
            { 
               if (not administradorDeJuego.pausado()){
                    if (oleadaActual.ejecutando()) {
                        administradorDeEnemigos.generarEnemigo(oleadaActual.enemigos().anyOne())
                    } else if(oleadaActual.finalizo()){
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
        numeroOleada += 1
        if (numeroOleada > numOleadaFinal){
            oleadaActual.terminarOleada()
        } else {
            oleadaActual.terminarOleada()
            if (numeroOleada == numOleadaFinal){ oleadaActual = oleadaFinal }
            game.schedule(10000, { self.iniciarOleada() })
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
        numeroOleada = 1
        oleadaActual = oleadaNormal
    }
    method recibeDanioMago(danio){}
}


// ===============================
// Oleada Normal: Configuración y gestión de una oleada estándar
// ===============================
object oleadaNormal {
    var property enemigos =  [/* slimeBasico */slimeDeMedioOriente]
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
