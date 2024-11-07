import slime.*
import wollok.game.*
import administradorDeEnemigos.*
import administradorDeJuego.*


// ===============================
// Administrador de Oleadas: Control de las oleadas de enemigos
// ===============================
object administradorDeOleadas {
    const numOleadaFinal = 3
    const posiblesTipos = [slimeBasico, slimeBasico, slimeGuerrero, slimeNinja, slimeBlessed]

    var oleadaActual = oleadaNormal
    var numeroOleada = 1
    

    // Métodos de visualización y sonido
    method position() = new MutablePosition(x = 9, y = 5)
    method text() = "Oleada: " + numeroOleada.toString() + "     " + "Slimes Restantes: " + oleadaActual.enemigosRestantes().toString()
    method textColor() = "#FA0770"
    method inicioOleada() = game.sound("m.inicioOleada.mp3")
    method finOleada() = game.sound("m.finOleada.mp3")

    // Inicia la oleada y gestiona enemigos
    method iniciarOleada() {
        game.removeTickEvent("Iniciar Oleada")
        oleadaActual.cargarSlimesRestantes()
        self.inicioOleada().volume(0.0001)
       self.inicioOleada().play()
        game.onTick(
            oleadaActual.tiempoSpawn(),
            "gestionar oleada",
            { 
                if (oleadaActual.ejecutando()) {
                    administradorDeEnemigos.generarEnemigo(oleadaActual.enemigos().anyOne())
                } else if (oleadaActual.finalizo()) {
                    self.siguienteOleada()
                    game.removeTickEvent("gestionar oleada")
                    self.finOleada().volume(0.1)
                    self.finOleada().play()
                }
            }
        )
    }

    // Pasa a la siguiente oleada
    method siguienteOleada() {
        numeroOleada += 1
        game.onTick(10000,"Iniciar Oleada", { self.iniciarOleada() })
        oleadaActual.terminarOleada()
        if (numeroOleada == numOleadaFinal) oleadaActual = oleadaFinal
        
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
}


// ===============================
// Oleada Normal: Configuración y gestión de una oleada estándar
// ===============================
object oleadaNormal {
    var property enemigos = [slimeBasico]
    var property cantidadEnemigos = 10
    var property enemigosRestantes = cantidadEnemigos 
    var property enemigosGenerados = 0
    var property tiempoSpawn = 3000
    const cantSlimesPosibles = 4

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
    }

    method cargarSlimesRestantes () {enemigosRestantes = cantidadEnemigos }


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
    const property cantidadEnemigos = 30
    var property enemigosRestantes = cantidadEnemigos 
    var property enemigosGenerados = 0
    const property tiempoSpawn = 400

    // Verifica si la oleada final está en ejecución
    method ejecutando() = cantidadEnemigos > enemigosGenerados && enemigosRestantes > 0

    method seGeneroEnemigo() {enemigosGenerados+=1}

    method seMurioEnemigo() {enemigosRestantes-=1}


    // Termina la oleada final y concluye el juego
    method terminarOleada() {
        pantalla.estado(victoria)
        administradorDeJuego.terminarJuego()
        game.removeTickEvent("Iniciar Oleada")
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
