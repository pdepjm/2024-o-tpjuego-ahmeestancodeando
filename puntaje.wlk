import game.*
object puntaje {

method position() = game.at(7, 5)

var property puntos = 50

var property cantidadDeMagosHealer = 0

method sumarPuntos(){
    self.puntos(puntos + 10 * (1 + cantidadDeMagosHealer))
}

method restarPuntos(costo){
    self.puntos(puntos - costo)
}

method sumarMagoHealer(){
    cantidadDeMagosHealer += 1
}

method quitarMagoHealer(){
    cantidadDeMagosHealer -= 1
    if (cantidadDeMagosHealer <=0) cantidadDeMagosHealer = 0
}


method text() = puntos.toString() + "$"
method textColor() = "#FA0770"

// Faltaria ver si se puede agrandar el tamaño de letra

}