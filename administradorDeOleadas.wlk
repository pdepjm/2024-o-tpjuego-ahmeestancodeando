import slime.*
import wollok.game.*
import administradorDeEnemigos.*
import administradorDeJuego.*

// Ver cómo hacer que llame a cada oleada correctamente
object administradorDeOleadas {
    var oleadaActual = oleadaNormal
    var property numeroOleada = 1
    const numOleadaFinal = 3
    

    const posiblesTipos = [slimeBasico, slimeBasico, slimeGuerrero, slimeNinja, slimeBlessed]

    method position() = new MutablePosition(x=10, y=5)
    method text() = "Oleada: " + numeroOleada.toString() + "     " + "Slimes Restantes: " + oleadaActual.enemigosRestantes().toString() + oleadaActual.enemigos().toString() + oleadaActual.enemigosGenerados().toString()
    method textColor() = "#FA0770"

    method inicioOleada() = game.sound("m.inicioOleada.mp3")
    method finOleada() = game.sound("m.finOleada.mp3")

    
    method iniciarOleada() {
        
        game.onTick(
            oleadaActual.tiempoSpawn(),
            "gestionar oleada",
            { 
                if (oleadaActual.ejecutando()) {
                    // Genera un nuevo enemigo de la lista y lo agrega a la cantidad de enemigos generados
                    administradorDeEnemigos.generarEnemigo(oleadaActual.enemigos().anyOne())
                } else if (oleadaActual.finalizo()) {
                    self.siguienteOleada()
                    game.removeTickEvent("gestionar oleada")
                    //self.finOleada().volume(0.1)
                    //self.finOleada().play()
                }
            }
        )
        
    }

    method siguienteOleada() {
        numeroOleada+=1
        //self.inicioOleada().volume(0.0001)
        //self.inicioOleada().play()
        oleadaActual.terminarOleada()
        if(numeroOleada==(numOleadaFinal)) oleadaActual = oleadaFinal
        game.schedule(20000, { self.iniciarOleada() })
        

        // Remueve eventos anteriores de generación de enemigos
        
    }

    method reducirEnemigo() { oleadaActual.enemigosRestantes(oleadaActual.enemigosRestantes()-1) }
    method sumarEnemigo() { oleadaActual.enemigosGenerados(oleadaActual.enemigosGenerados()+1) }

        

    // Devuelve un tipo de slime aleatorio en base al número de oleada
    method agregarTipo(numero) {
        return posiblesTipos.get(0.randomUpTo(numero+4).round())
    }

    method reset (){
        game.removeTickEvent("gestionar oleada")
        oleadaNormal.reset()
        oleadaFinal.reset()
        numeroOleada = 1
        oleadaActual = oleadaNormal
    }


}

object oleadaNormal { //base
    var property enemigos = [slimeBasico]
    var property cantidadEnemigos = 10
    var property enemigosRestantes = cantidadEnemigos 
    var property enemigosGenerados = 0
    var property tiempoSpawn = 3000

    const cantSlimesPosibles = 4

    method ejecutando() = cantidadEnemigos > enemigosGenerados && enemigosRestantes > 0

    method finalizo () = enemigosRestantes == 0 && enemigosGenerados == cantidadEnemigos

    method terminarOleada(){
        cantidadEnemigos+=5
        enemigosGenerados = 0
        enemigosRestantes = cantidadEnemigos 
        
        if (tiempoSpawn > 400) tiempoSpawn -= 400
        enemigos = []
         //Dejo en 0 en caso de querer cambiar dificualtad
         game.onTick(100,"agregar bichos", {self.agregarSlimes()})
    }

    method agregarSlimes(){ 
    if (enemigos.size() < cantSlimesPosibles){enemigos.add(administradorDeOleadas.agregarTipo(0))}
    else game.removeTickEvent("agregar bichos")
    }

    method reset(){
        enemigos = [slimeBasico]
        cantidadEnemigos = 10
        enemigosRestantes = cantidadEnemigos 
        enemigosGenerados = 0
        tiempoSpawn = 3000
    }
    
}
//return tipo.get(numero.randomUpTo(numero+3).round())
object oleadaFinal{

    const property enemigos = [slimeBlessed]
    const property cantidadEnemigos = 5
    var property enemigosRestantes = cantidadEnemigos 
    var property enemigosGenerados = 0
    const property tiempoSpawn = 400

    method ejecutando() = cantidadEnemigos > enemigosGenerados && enemigosRestantes > 0
    method terminarOleada() {
        pantalla.estado(victoria)
        administradorDeJuego.terminarJuego()
        }
    method finalizo () = enemigosRestantes == 0 && enemigosGenerados == cantidadEnemigos

    method reset() {enemigosGenerados=0}
    
}

/*
class Oleada { //base
    var property enemigos = []
    var property cantidadEnemigos = 10
    var property enemigosRestantes = cantidadEnemigos 
    var property enemigosGenerados = 0
    var property tiempoSpawn = 3000

    method ejecutando() = cantidadEnemigos > enemigosGenerados && enemigosRestantes > 0

    method termino () = enemigosRestantes == 0 && enemigosGenerados == cantidadEnemigos
    
}

object oleadaFinal inherits Oleada(enemigos={slimeBlessed},cantidadEnemigos=10,enemigosRestantes=10,tiempoSpawn=10) {
    method resetOleada() {
        tipoEnemigos = [slimeBasico]
        cantidadEnemigos = 10
        numeroOleada = 1
        tiempoSpawn = 3000
        enemigosRestantes = 10
        enemigosGenerados = 0
    }
    
}*/

