import administradorDeMagos.*
import magos.*
import cursor.*
import wollok.game.*
object pala {
    const position = game.at(5,5)
    var property imagen = "pala.png"

    method image() = imagen

    method position() = position

    method eliminarMago(magoSeleccionado){
        game.removeVisual(magoSeleccionado)
        administradorDeMagos.eliminarMago(magoSeleccionado)
    }

}