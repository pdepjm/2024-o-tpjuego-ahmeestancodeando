
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

object administradorDeJuego {
  var property hayPantalla = false
  var pantallita = derrota
  method terminarJuego(pantalla){
    hayPantalla = true 
    pantallita = pantalla
    game.removeTickEvent("gestionar oleada")
    //const musica2 = game.sound("m.deathScreen.mp3")
    //configuracion.detenerMusica()
    //game.schedule(100,{musica2.play()})
    //musica2.volume(0.4) 
    game.addVisual(pantalla)
    //game.schedule(500,{game.stop()})
    keyboard.r().onPressDo({self.resetGame()})
    keyboard.backspace().onPressDo({game.stop()})

   }
/* No funca sin musica
  SE ROMPE TODO POR LA MUSICA DE MIERDA >:(
method perder() {
        const sonido = game.sound("m.deathScreen.mp3")
        configuracion.detenerMusica()
        game.schedule(100,{sonido.play()})
        sonido.volume(0.4) 
        game.addVisual(derrota)
        game.schedule(500,{sonido.stop()})
        keyboard.enter().onPressDo({self.resetGame()})
        }

method ganar() {
        const sonido = game.sound("m.deathScreen.mp3")
        configuracion.detenerMusica()
        game.schedule(100,{sonido.play()})
        sonido.volume(0.4) 
        game.addVisual(victoria)
        game.schedule(500,{sonido.stop()})
        keyboard.enter().onPressDo({self.resetGame()})
        }
*/
    

  method resetGame() {
    //game.clear()
    hayPantalla = false
    game.removeVisual(pantallita)
    administradorDeEnemigos.reset()
    administradorDeMagos.reset()
    administradorDeProyectiles.reset()
    administradorDeOleadas.reset()
    casa.reset()
    puntaje.reset()
    cantidadDeBajas.reset()
    configuracion.primeraOleada()


    //configuracion.iniciarMusica()
  }
}

object derrota {
    method position() = new MutablePosition(x=0, y=0)
    method image() = "fin.jpg"
}


object victoria {
    method position() = new MutablePosition(x=0, y=0)
    method image() = "victoria.jpg"
}
/*class Pantalla {
    method position() = new MutablePosition(x=0, y=0)
    method image()
    const sonido
}*/
object configuracion {
  
    var property sonido = "pvz8bit.mp3"
    const musica = game.sound(self.sonido()) // el reproductor es constante, lo unico que cambiamos es la referencia al mp3

method agregarVisuals() {
    game.addVisual(cursor)
    game.addVisual(menu)
    game.addVisual(puntaje)
    game.addVisual(administradorDeOleadas)
    menu.accion()
    cursor.accion()
    menu.iniciarTienda()
    game.addVisual(cantidadDeBajas)
  }
method crearTicks(){
    self.primeraOleada()

    game.onTick(
      1000,
      "mover enemigo",
      { administradorDeEnemigos.moverEnemigos() }
    )
    game.onTick(
      1000,
      "matar enemigos",
      { administradorDeEnemigos.estanMuertos() }
    )
    
    
    game.onTick(1000, "matar magos", { administradorDeMagos.estanMuertos() })
    game.onTick(500, "aumentar dinero", { puntaje.sumarPuntos() })
    game.onTick(3000, "disparar", { administradorDeMagos.disparar() })
    game.onTick(1000,"moverDisparos",{ administradorDeProyectiles.moverProyectiles() })
    game.onTick(1000,"impactarDisparos",{ administradorDeProyectiles.impactarProyectiles() })
}
method primeraOleada(){
      game.onTick(4000,"generar primera oleada", { administradorDeOleadas.iniciarOleada() })//espera un tiempo e inicia la primer oleada
}

method iniciarMusica(){
    
   musica.shouldLoop(true)
   game.schedule(1500,{musica.play()})
   musica.volume(0.4)
  }

  method detenerMusica(){
    musica.stop() // despues veo como lo implemento para que cambie o se detenga cuando moris
  }



}
