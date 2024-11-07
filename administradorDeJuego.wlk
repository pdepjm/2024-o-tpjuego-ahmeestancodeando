import administradorDeOleadas.*
import adminProyectiles.*
import administradorDeMagos.*
import wollok.game.*
import cursor.*
import slime.*
import menu.*
import administradorDeEnemigos.*
import puntaje.*
import pala.*
import casa.casa

// =======================================
// Administrador de Juego: Control central del juego, reseteo y fin del juego
// =======================================
object administradorDeJuego {
  
  // Método para finalizar el juego y resetear el estado
  method terminarJuego() {
    puntaje.reset()
    game.addVisual(pantalla)
    self.resetGame()
  }

  // Método para resetear todos los administradores y configuraciones del juego
  method resetGame() {
    configuracion.eliminarTicks()
    administradorDeEnemigos.reset()
    administradorDeMagos.reset()
    administradorDeProyectiles.reset()
    administradorDeOleadas.reset()
    casa.reset()
    puntaje.reset()
    // configuracion.iniciarMusica() // Iniciar música (opcional)
  }
}

// =======================================
// Pantallas de Estado del Juego (Derrota y Victoria)
// =======================================
object derrota {
    method position() = new MutablePosition(x = 0, y = 0)
    method imagen() = "fin.jpg"
    method sonido() = game.sound("m.deathScreen.mp3")
    
}

object victoria {
    method position() = new MutablePosition(x = 0, y = 0)
    method imagen() = "victoria.jpg"
    method sonido() = game.sound("m.deathScreen.mp3")
}

// =======================================
// Pantalla de Estado Actual del Juego
// =======================================
object pantalla {
    method position() = new MutablePosition(x = 0, y = 0)
    method image() = estado.imagen()
    
    var estado = derrota
    var sonido = estado.sonido()

    method estado(estadoNuevo) {
        estado = estadoNuevo
    }
}

// =======================================
// Configuración del Juego: Música, Visuales y Eventos
// =======================================
object configuracion {
  
    var property sonido = "pvz8bit.mp3"
    const musica = game.sound(self.sonido()) // El reproductor de música es constante; solo cambia el archivo de sonido

    // Método para agregar elementos visuales y configurar teclas de control
    method agregarVisuals() {
        game.addVisual(cursor)
        game.addVisual(menu)
        game.addVisual(puntaje)
        game.addVisual(administradorDeOleadas)
        game.addVisual(casa)

        menu.accion()
        cursor.accion()
        menu.iniciarTienda()

        // Tecla "P" para reiniciar el juego
        keyboard.p().onPressDo({
            administradorDeJuego.resetGame()
            game.removeVisual(pantalla)
            self.crearTicks()
            puntaje.reset()
        })

        // Tecla "I" para detener el juego
        keyboard.i().onPressDo({ game.stop() })
    }

    // Método para programar eventos de actualización periódicos (ticks)
    method crearTicks() {
        game.schedule(4000, { administradorDeOleadas.iniciarOleada() }) // Inicia la primera oleada tras 4 segundos
        
        game.onTick(1000, "mover enemigo", { administradorDeEnemigos.moverEnemigos() })
        game.onTick(1000, "matar enemigos", { administradorDeEnemigos.estanMuertos() })
        game.onTick(1000, "matar magos", { administradorDeMagos.matarMagos() })
        game.onTick(500, "aumentar dinero", { puntaje.sumarPuntos() })
        game.onTick(3000, "disparar", { administradorDeMagos.disparar() })
        game.onTick(1000, "moverDisparos", { administradorDeProyectiles.moverProyectiles() })
        game.onTick(1000, "impactarDisparos", { administradorDeProyectiles.impactarProyectiles() })
    }

    // Método para iniciar la música de fondo en bucle
    method iniciarMusica() {
        musica.shouldLoop(true)
        game.schedule(1500, { musica.play() })
        musica.volume(0.4)
    }

    // Método para detener la música de fondo
    method detenerMusica() {
        musica.stop()
    }

    // Método para eliminar todos los eventos programados de actualización (ticks)
    method eliminarTicks() {
        game.removeTickEvent("mover enemigo")
        game.removeTickEvent("matar enemigos")
        game.removeTickEvent("matar magos")
        game.removeTickEvent("aumentar dinero")
        game.removeTickEvent("disparar")
        game.removeTickEvent("moverDisparos")
        game.removeTickEvent("impactarDisparos")
        game.removeTickEvent("Iniciar Oleada")
    }
}
