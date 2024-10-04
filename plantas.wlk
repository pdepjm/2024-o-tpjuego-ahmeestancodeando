class Papa{
    const position 
    const  property tipo = "papa"
    var property vida=100
    method position() = position
    var property imagen = "golondrina.png"
    method image() = imagen

    method recibeDanio(danio) {
        self.vida(self.vida() - danio)
        }
}

class Guisante{
    const position 
    const  property tipo = "guisante"
    var property vida=100
    method position() = position
    var property imagen = "zombie.png"
    method image() = imagen

    method recibeDanio(danio) {
        self.vida(self.vida() - danio)
        }
}
const pepe = new Guisante (position=game.at(0,0))