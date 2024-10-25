import administradorDeOleadas.*
import adminProyectiles.*
import administradorDeMagos.*
import wollok.game.*
import cursor.*
import slime.*
import casa.*
import menu.*
import administradorDeEnemigos.*
import puntaje.*

object configuracion {
var property sonido = "m.pvz8bit.mp3"
const musica = game.sound(sonido) // el reproductor es constante, lo unico que cambiamos es la referencia al mp3
  method agregarVisuals() {
    game.addVisual(cursor)
    game.addVisual(menu)
    game.addVisual(puntaje)
    menu.accion()
    cursor.accion()
    menu.iniciarTienda()
    game.addVisual(cantidadDeBajas)
  }
  
  method crearTicks() {
/*     game.onTick(
      3000,
      "generar nuevo Enemigo",
      { 
        administradorDeEnemigos.sumarEnemigo()
        return administradorDeEnemigos.generarEnemigo(slimeBasico)
      }
    ) */
    game.schedule(4000, {oleada.iniciarOleada()})//espera un tiempo e inicia la primer oleada

    game.onTick(
      1500,
      "mover enemigo",
      { administradorDeEnemigos.moverEnemigos() }
    )
    game.onTick(
      1000,
      "matar enemigos",
      { administradorDeEnemigos.estanMuertos() }
    )
    
    
    game.onTick(1000, "matar plantas", { administradorDeMagos.estanMuertos() })
    game.onTick(500, "aumentar dinerro", { puntaje.sumarPuntos() })
    game.onTick(3000, "disparar", { administradorDeMagos.disparar() })
    game.onTick(1000,"moverDisparos",{ administradorDeProyectiles.moverProyectiles() })
    game.onTick(1000,"impactarDisparos",{ administradorDeProyectiles.impactarProyectiles() })
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