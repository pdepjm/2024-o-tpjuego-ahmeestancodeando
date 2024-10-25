import slime.*
import wollok.game.*
import administradorDeEnemigos.*

//Ver como hacer q llame a cada oleada
object oleada {
    const tipoEnemigos = [slimeBasico]
    var cantidadEnemigos = 10
    var numeroOleada = 1
    var enemigosRestantes = 10

method iniciarOleada(){
    //delay
    //ver como hacer que genere constantemente sin cortar
    game.onTick(
      3000,
      "generar nuevo Enemigo",
      { 
        if(enemigosRestantes>0){administradorDeEnemigos.sumarEnemigo()
        administradorDeEnemigos.generarEnemigo(tipoEnemigos.anyOne())}//checkea si se generaron todos los enemigos de la oleada
        else if (enemigosRestantes == 0 ) game.schedule(10000, {self.siguienteOleada()})//Llama a setear la proxima oleada//Genera enemigo aleatorio de la Lista
        else {return}//agregado por las dudas. revisar
        enemigosRestantes-=1
       }
    )
}

method siguienteOleada(){
    cantidadEnemigos +=5 //definir escalado de oleadas
    numeroOleada +=1
    enemigosRestantes = cantidadEnemigos
    if(numeroOleada>2){
        tipoEnemigos.add(adminTipoOleada.agregarTipo(3)) //Aca hay que pensar la relacion entre oleada y slimes utiles
    }

    //game.schedule(8000, {self.iniciarOleada()})
   /* if(numeroOleada==10){ oleada final
        tipoEnemigos.clear()
        tipoEnemigos.add()
    }*/
}



}

object adminTipoOleada { //Añade los tipos de slime a posibles slimes de oleada
    const tipo = [slimeBasico,slimeGuerrero,slimeNinja,slimeBlessed]//[SlimeBasico, SlimeFuerte, SlimeDefensivo, SlimeBlessed]tipos de slimes

    method agregarTipo(numero){
        
        return tipo.get(1.randomUpTo(numero))
    }
}