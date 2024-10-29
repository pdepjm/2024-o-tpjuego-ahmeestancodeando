import slime.*
import wollok.game.*
import administradorDeEnemigos.*

//Ver como hacer q llame a cada oleada
object oleada {
    var tipoEnemigos = [slimeBasico]
    var cantidadEnemigos = 10
    var numeroOleada = 1
    var tiempoSpawn = 3000
    var property enemigosRestantes = 10
    method position() = game.at(10, 5)
    method text() = "Oleada: " + numeroOleada.toString() +"     " + "Slimes Restantes: " + enemigosRestantes.toString() + tipoEnemigos.toString()
    method textColor() = "#FA0770"

method iniciarOleada(){
    //delay
    //ver como hacer que genere constantemente sin cortar
    game.onTick(
      tiempoSpawn,
      "generar nuevo Enemigo",
      { 
        if(enemigosRestantes>1){
            administradorDeEnemigos.sumarEnemigo()
            administradorDeEnemigos.generarEnemigo(tipoEnemigos.anyOne())
            enemigosRestantes-= 1
        }//checkea si se generaron todos los enemigos de la oleada
        else if (enemigosRestantes==1){
            tipoEnemigos = []
            game.schedule(10000, {self.siguienteOleada()})//Llama a setear la proxima oleada//Genera enemigo aleatorio de la Lista
            enemigosRestantes-= 1
        } else {
             game.onTick(2250,"agregar enemigo",{self.agregarEnemigos()})
        }
       }
    )
}

method siguienteOleada(){
    game.removeTickEvent("agregar enemigo")
    cantidadEnemigos +=5 //definir escalado de oleadas
    numeroOleada +=1
    enemigosRestantes = cantidadEnemigos
    if (tiempoSpawn >400) tiempoSpawn -= 400
    


}

method agregarEnemigos(){
    tipoEnemigos.add(adminTipoOleada.agregarTipo(numeroOleada)) //Aca hay que pensar la relacion entre oleada y slimes utiles
}

}

object adminTipoOleada { //Añade los tipos de slime a posibles slimes de oleada
    const tipo = [slimeBasico,slimeBasico,slimeGuerrero,slimeNinja,slimeGuerrero,slimeNinja,slimeBlessed,slimeBlessed,slimeBlessed,slimeBlessed,slimeBlessed,slimeBlessed,slimeBlessed]//[SlimeBasico, SlimeFuerte, SlimeDefensivo, SlimeBlessed]tipos de slimes

    method agregarTipo(numero){
        return tipo.get(numero.randomUpTo(numero+3).round())
    }
}