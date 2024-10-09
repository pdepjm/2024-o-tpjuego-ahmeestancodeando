import game.*
object puntaje {

method position() = game.at(7, 5)

var property puntos = 50

var property cantidadDeGirasoles = 0

method sumarPuntos(){
    self.puntos(puntos + 10 * (1 + cantidadDeGirasoles))
}

method sumarGirasol(){
    self.cantidadDeGirasoles(cantidadDeGirasoles + 1)
}

method quitarGirasol(){
    self.cantidadDeGirasoles(cantidadDeGirasoles - 1)
}


method text() = puntos.toString() + "$"
method textColor() = "#FA0770"

// Faltaria ver si se puede agrandar el tamaño de letra

}