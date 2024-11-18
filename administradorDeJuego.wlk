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

class MyException inherits wollok.lang.Exception {}
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
    configuracion.resetTicks()
    administradorDeEnemigos.reset()
    administradorDeMagos.reset()
    administradorDeProyectiles.reset()
    administradorDeOleadas.reset()
    casa.reset()
    puntaje.reset()
    //pantalla.reproducirSonido()
   // configuracion.iniciarMusica() // Iniciar música (opcional)
  }

    method pausar(){
        if (usuarioEnMenu==false){
            if (pausado==false){
                configuracion.frenarTicks()
                pausado = true
                pantalla.estado(pausa)
                game.addVisual(pantalla)
                return pausado
            } else {
                configuracion.iniciarTicks()
                game.removeVisual(pantalla)
                pausado = false
                return pausado
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
    method sonido() = game.sound("m.inicio.mp3")
}
object pausa{
    method position() = new MutablePosition(x = 0, y = 0)
    method imagen() = "pantallaPausa.png"
    method sonido() = game.sound("")
}

// =======================================
// Pantalla de Estado Actual del Juego
// =======================================
object pantalla {
    method position() = new MutablePosition(x = 0, y = 0)
    method image() = estado.imagen()
    
    var  property estado = portada
    var sonido = estado.sonido()
    method estado()=estado

    method reproducirSonido(){
        estado.sonido().volume(0.1)
        estado.sonido().play()
    }
    method detenerSonido(){
        estado.sonido().stop()
    }
    method nuevoEstado(estadoNuevo) {
        estado=estadoNuevo
        
        self.reproducirSonido()
        
    }
    method frenarEnemigo()= true
}

// =======================================
// Configuración del Juego: Música, Visuales y Eventos
// =======================================

object sonidoPartida{
    var property sonido = "pvz8bit.mp3"
    const musica = game.sound(sonido)
    method iniciarMusica() {
        musica.shouldLoop(true)
        game.schedule(1500, { musica.play() })
        musica.volume(0.5)
    }
    method detenerMusica(){
        musica.stop()
    }
}
object configuracion {
    const tiemposProyectiles = 600
    const tiempoDisparo = 3000
    const tiempoDinero = 750
    const tiempoMuerte = 1000
    const tiempoMoverEnemigo = 1000

    //ticks que usa el juego
    const tickParaMoverEnemigos = game.tick(tiempoMoverEnemigo,{administradorDeEnemigos.moverEnemigos()},false)
    const tickParaAumentarDinero = game.tick(tiempoDinero, { puntaje.sumarPuntos() },false)
    const tickParaDisparar= game.tick(tiempoDisparo,  { administradorDeMagos.disparar()},false)
    const tickParaMoverYColisionarDisparos= game.tick(tiemposProyectiles,  { administradorDeProyectiles.moverProyectiles() administradorDeProyectiles.impactarProyectiles() },false)
    const tickParaCambiarFrames= game.tick((tiemposProyectiles/3)-5, {administradorDeProyectiles.cambiarFrame()},false)
    //game.onTick(tiempoMuerte, "matar enemigos", { administradorDeEnemigos.estanMuertos() })
    //game.onTick(tiempoMuerte, "matar magos", { administradorDeMagos.matarMagos() })
    
    /* game.onTick(tiemposProyectiles, "impactarDisparos", { 
                                                                administradorDeProyectiles.impactarProyectiles() 
                                                                administradorDeProyectiles.combinarProyectiles()
                                                            }) */
    


    var property sonido = "pvz8bit.mp3"
    const musica = game.sound(self.sonido()) // El reproductor de música es constante; solo cambia el archivo de sonido
    method iniciarMusica() {sonidoPartida.iniciarMusica()} 
    // Método para detener la música de fondo
    method detenerMusica() {
        musica.stop()
    }
    // Método para agregar elementos visuales y configurar teclas de control
    method agregarVisuals() {  

        game.addVisual(cursor)
        game.addVisual(menu)
        game.addVisual(puntaje)
        game.addVisual(administradorDeOleadas)
        game.addVisual(casa)


/*         menu.accion()
        cursor.accion() */
        menu.iniciarTienda()
        //administradorDeJuego.pausar()   

        menu.accion()
        cursor.accion()
        
        
        // Tecla "P" para reiniciar el juego
        keyboard.p().onPressDo({
            /* try self.iniciarMusica()
            catch e: MyException {"YA ESTA INICIADA LA MUSICA"}
            then always{ */
            administradorDeJuego.resetGame()
            administradorDeJuego.usuarioEnMenu(false)
            administradorDeJuego.pausado(false)
            //administradorDeJuego.pausado(false)
            game.removeVisual(pantalla)
            self.frenarTicks()
            self.crearTicks()
            puntaje.reset()
           // }
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
        tickParaAumentarDinero.start()
        tickParaCambiarFrames.start()
        tickParaDisparar.start()
        tickParaMoverYColisionarDisparos.start()
        tickParaMoverEnemigos.start()
    }
    method frenarTicks() {
            tickParaAumentarDinero.stop()
            tickParaCambiarFrames.stop()
            tickParaDisparar.stop()
            tickParaMoverYColisionarDisparos.stop()
            tickParaMoverEnemigos.stop()
        }
    method resetTicks(){
        tickParaAumentarDinero.reset()
        tickParaCambiarFrames.reset()
        tickParaDisparar.reset()
        tickParaMoverYColisionarDisparos.reset()
        tickParaMoverEnemigos.reset()
    }
    // Método para iniciar la música de fondo en bucle
    

   

    // Método para eliminar todos los eventos programados de actualización (ticks)
    
}
