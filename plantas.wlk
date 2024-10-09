class Papa{ //nota de nico: es una nuez >:(
    const position 
    
    const  property tipo = "papa"
    var property vida=300
    method position() = position
    var property imagen = "magoPiedra.png"
    method image() = imagen

    method recibeDanio(danio) {
        self.vida(self.vida() - danio)
        }
    method queSoy()="planta"    
    
        // No realiza ninguna accion, es un "escudo" asi que deberia tener mucha vida
    }

class Guisante{
    const position 
    const  property tipo = "guisante"
    var property vida=100
    method position() = position
    var property imagen = "magoFuego.png"
    method image() = imagen

    method recibeDanio(danio) {
        self.vida(self.vida() - danio)
        }
    method queSoy()="planta"  

    // Dispara proyectiles normales
}

class Patapum{
    const position 
    const  property tipo = "patapum"
    var property vida=1
    method position() = position
    var property imagen = "magoEnojado.png" //hacer mago musulman
    method image() = imagen

    method recibeDanio(danio) {
        self.vida(self.vida() - danio)
        }
    method queSoy()="planta"  

    // Cuando colisiona deberia explotar y matar a los zombies que esten colisionando con el

}

class Cactus{
    const position 
    const  property tipo = "cactus"
    var property vida=100
    method position() = position
    var property imagen = "magoHielo.png"
    method image() = imagen

    method recibeDanio(danio) {
        self.vida(self.vida() - danio)
        }
    method queSoy()="planta"  

        //Dispara proyectiles perforantes (no hacer la mecanica del cactus que sube y baja)
}

class Girasol{
    const position 
    const  property tipo = "girasol"
    var property vida=100
    method position() = position
    var property imagen = "magoHealer.png"
    method image() = imagen

    method recibeDanio(danio) {
        self.vida(self.vida() - danio)
        }
    method queSoy()="planta"  

        //Aumenta la generacion de soles x segundo
}

class ZapalloEnojado{
    const position 
    const  property tipo = "zapallo enojado"
    var property vida=1
    method position() = position
    var property imagen = "magoEnojado.png"
    method image() = imagen

    method recibeDanio(danio) {
        self.vida(self.vida() - danio)
        }
    method queSoy()="planta"  

        //OH NO ES EL LANZACOHETES DAVE! HAGAN ALGO CON ESE SUJETO!!! Tranquilos... yo me encargo. Soy el Zapallo Enojado >:)
}

object papaTienda {
    const position = game.at(0,5) 
    method position() = position
    var property imagen = "magoPiedra.png"
    method image() = imagen

    method generarPlanta(posicionPlanta){
        return (new Papa(position = posicionPlanta))
    }
}


const pepe = new Guisante (position=game.at(0,0))