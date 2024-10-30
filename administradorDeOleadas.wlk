import slime.*
import wollok.game.*
import administradorDeEnemigos.*

//Ver como hacer q llame a cada oleada
object oleada {
    var tipoEnemigos = [slimeNinja,slimeNinja,slimeNinja,slimeNinja]
    var cantidadEnemigos = 10
    var numeroOleada = 1
    var tiempoSpawn = 3000
    var property enemigosRestantes = 10
    method position() = game.at(10, 5)
    method text() = "Oleada: " + numeroOleada.toString() +"     " + "Slimes Restantes: " + enemigosRestantes.toString() + tipoEnemigos.toString()
    method textColor() = "#FA0770"

method iniciarOleada(){
    //Delay para generar enemigos constantemente sin cortar
    //Ver como hacer que genere constantemente sin cortar
    //Genera enemigos de la oleada actual mientras haya enemigos restantes
    //Si se generaron todos los enemigos de la oleada, se llama a setear la proxima oleada
    //Si no hay enemigos restantes, se agrega un nuevo enemigo aleatorio de la lista
    game.onTick(
      tiempoSpawn,
      "generar nuevo Enemigo",
      { 
        if(enemigosRestantes>1){
            //Genera un nuevo enemigo de la lista y lo agrega a la cantidad de enemigos restantes
            administradorDeEnemigos.sumarEnemigo()
            administradorDeEnemigos.generarEnemigo(tipoEnemigos.anyOne())
            //Decrementa la cantidad de enemigos restantes
            enemigosRestantes-= 1
        } else if (enemigosRestantes==1){
            //Si se generaron todos los enemigos de la oleada, se llama a setear la proxima oleada
            //Limpia la lista de enemigos
            tipoEnemigos = []
            //Llama a setear la proxima oleada
            game.schedule(10000, {self.siguienteOleada()})
            //Decrementa la cantidad de enemigos restantes
            enemigosRestantes-= 1
        } else {
             //Agrega un nuevo enemigo aleatorio de la lista
             game.onTick(2250,"agregar enemigo",{self.agregarEnemigos()})
        }
       }
    )
}

method siguienteOleada(){
    // remuevo el evento que generaba enemigos en la oleada anterior
    game.removeTickEvent("agregar enemigo")
    
    // aumento la cantidad de enemigos en la siguiente oleada
    cantidadEnemigos +=5 
    //definir escalado de oleadas (por ahora es 5 enemigos mas por oleada)
    
    // aumento el numero de oleada en 1
    numeroOleada +=1
    
    // reseteo el contador de enemigos restantes en la oleada
    enemigosRestantes = cantidadEnemigos
    
    // si el tiempo de spawn es mayor a 400, lo decreo en 400 para que se vayan spawnando mas rapido
    if (tiempoSpawn >400) 
        tiempoSpawn -= 400
    
    // remuevo el evento que generaba el enemigo en la oleada anterior
    game.removeTickEvent("generar nuevo Enemigo")
    
    // inicio la siguiente oleada
    self.iniciarOleada()
}

method agregarEnemigos(){
    tipoEnemigos.add(adminTipoOleada.agregarTipo(numeroOleada)) //Aca hay que pensar la relacion entre oleada y slimes utiles
}

}

object adminTipoOleada { //Añade los tipos de slime a posibles slimes de oleada
    //Este array contiene los posibles tipos de slimes que se pueden generar en una oleada
    //Los tipos de slimes se encuentran en el archivo "slime.wlk"
    const tipo = [slimeBasico,slimeBasico,slimeGuerrero,slimeNinja,slimeGuerrero,slimeNinja,slimeBlessed,slimeBlessed,slimeBlessed,slimeBlessed,slimeBlessed,slimeBlessed,slimeBlessed]

    //Este metodo devuelve un tipo de slime aleatorio
    //Recibe un numero de oleada y se utiliza para seleccionar los posibles slimes que se pueden generar en una oleada
    //Devuelve un tipo de slime "aleatorio" entre los disponibles en el array "tipo"
    method agregarTipo(numero){
        //Se utiliza el metodo "randomUpTo" para agarrar un numero random entre el indice Numero (equivalene a numero de oleada) y ese indice 3 posiciones adelante 
        //El metodo "round" se utiliza para redondear el numero
        //El resultado un tipo de slime tomado del array que tiene un 25% de tomarse
        return tipo.get(numero.randomUpTo(numero+3).round())
    }
}
