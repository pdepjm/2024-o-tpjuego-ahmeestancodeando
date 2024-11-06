import administradorDeMagos.*
import magos.*
import cursor.*
import wollok.game.*
object pala {
    const position = new MutablePosition(x=5, y=5)
    var property imagen = "pala.png"

    method image() = imagen

    method position() = position

    method eliminarMago(magoSeleccionado){
        magoSeleccionado.eliminar()
    }

}