import game.*
object puntaje {

method position() = new MutablePosition(x=7, y=5)

var property puntos = 50

var property cantidadDeMagosIrlandeses = 0

method sumarPuntos(){
    self.puntos(puntos + 10 * (1 + cantidadDeMagosIrlandeses))
}

method restarPuntos(costo){
    self.puntos(puntos - costo)
}

method sumarMagoIrlandes(){
    cantidadDeMagosIrlandeses += 1
}

method quitarMagoIrlandes(){
    cantidadDeMagosIrlandeses -= 1
    if (cantidadDeMagosIrlandeses <=0) cantidadDeMagosIrlandeses = 0
}


method text() = puntos.toString() + "$"
method textColor() = "#FA0770"

// Faltaria ver si se puede agrandar el tamaño de letra
method reset() { puntos=50 cantidadDeMagosIrlandeses = 0}

}

object cantidadDeBajas {
    var property bajas = 0
    method position()=  new MutablePosition(x=12, y=5)
    method agregarBaja() {
        self.bajas(self.bajas()+1)
        }
    method reset(){bajas=0}
    //method text() = bajas.toString() + " slimes asesinados"
    //method textColor() = "#FA0770"
}