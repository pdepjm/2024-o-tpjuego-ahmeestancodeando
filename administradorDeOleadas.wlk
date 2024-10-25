import wollok.game.*
import administradorDeEnemigos.*

//Ver como hacer q llame a cada oleada
object oleada {
    const tipoEnemigos = #{}
    var cantidadEnemigos = 10
    var numeroOleada = 1
    var enemigosRestantes = 0

method iniciarOleada(){
    
    //delay
    //ver como hacer que genere constantemente sin cortar
    game.onTick(
      3000,
      "generar nuevo Enemigo",
      { 
        enemigosRestantes-=1
        administradorDeEnemigos.sumarEnemigo()
        return administradorDeEnemigos.generarEnemigo(tipoEnemigos.anyOne())//Genera enemigo aleatorio de la Lista
      }
    )

    if(enemigosRestantes == 0) self.siguienteOleada() //Llama a setear la proxima oleada
    
}

method siguienteOleada(){
    cantidadEnemigos +=10 //definir escalado de oleadas
    numeroOleada +=1
    tipoEnemigos.add(adminTipoOleada.agregarTipo(numeroOleada+2)) //Aca hay que pensar la relacion entre oleada y slimes utiles
    enemigosRestantes = cantidadEnemigos
}



}

object adminTipoOleada { //Añade los tipos de slime a posibles slimes de oleada
    const tipo = [] //tipos de slimes

    method agregarTipo(numero){
        return tipo.get(1.randomUpTo(numero))
    }
}