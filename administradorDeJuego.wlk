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
import proyectil.*
// =======================================
// Administrador de Juego: Control central del juego, reseteo y fin del juego
// =======================================
object administradorDeJuego {
    var property pausado = false
    var property usuarioEnMenu = false
  // Método para finalizar el juego y resetear el estado
  method terminarJuego() {
    usuarioEnMenu = true
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

    method pausar(){
        if (usuarioEnMenu == false){
            if (pausado == false){
                configuracion.eliminarTicks()
                pausado = true
            } else {
                configuracion.iniciarTicks()
                pausado = false
            }
        }
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
object portada {
    method position() = new MutablePosition(x = 0, y = 0)
    method imagen() = "portada3.png"
    method sonido() = game.sound("m.deathScreen.mp3")
}

// =======================================
// Pantalla de Estado Actual del Juego
// =======================================
object pantalla {
    method position() = new MutablePosition(x = 0, y = 0)
    method image() = estado.imagen()
    
    var estado = portada
    var sonido = estado.sonido()

    method estado(estadoNuevo) {
        estado = estadoNuevo
    }
}

// =======================================
// Configuración del Juego: Música, Visuales y Eventos
// =======================================
object configuracion {
    const tiemposProyectiles = 600
    const tiempoDisparo = 3000
    const tiempoDinero = 750
    const tiempoMuerte = 1000
    const tiempoMoverEnemigo = 1000


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
            administradorDeJuego.usuarioEnMenu(false)
            administradorDeJuego.pausado(false)
            game.removeVisual(pantalla)
            self.crearTicks()
            puntaje.reset()
            
        })

        // Tecla "I" para detener el juego
        keyboard.i().onPressDo({ game.stop() })

        keyboard.o().onPressDo({administradorDeJuego.pausar()})
    }   

    // Método para programar eventos de actualización periódicos (ticks)
    method crearTicks() {
        game.schedule(4000, { administradorDeOleadas.iniciarOleada() }) // Inicia la primera oleada tras 4 segundos
        self.iniciarTicks()
    }

    method iniciarTicks() {
        game.onTick(tiempoMoverEnemigo, "mover enemigo", { administradorDeEnemigos.moverEnemigos() })
        game.onTick(tiempoMuerte, "matar enemigos", { administradorDeEnemigos.estanMuertos() })
        game.onTick(tiempoMuerte, "matar magos", { administradorDeMagos.matarMagos() })
        game.onTick(tiempoDinero, "aumentar dinero", { puntaje.sumarPuntos() })
        game.onTick(tiempoDisparo, "disparar", { administradorDeMagos.disparar() })
        game.onTick(tiemposProyectiles, "moverDisparos", { administradorDeProyectiles.moverProyectiles() })
        game.onTick(tiemposProyectiles, "impactarDisparos", { 
                                                                administradorDeProyectiles.impactarProyectiles() 
                                                                administradorDeProyectiles.combinarProyectiles()
                                                            })
        game.onTick((tiemposProyectiles/3)-5, "frame", {administradorDeProyectiles.cambiarFrame()})
    }

    // Método para iniciar la música de fondo en bucle
    method iniciarMusica() {
        musica.shouldLoop(true)
        game.schedule(1500, { musica.play() })
        musica.volume(1)
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
        game.removeTickEvent("frame")
        game.removeTickEvent("Iniciar Oleada")
    }
}
