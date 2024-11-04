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
    var property enemigosGenerados = 0

    method position() = game.at(10, 5)
    method text() = "Oleada: " + numeroOleada.toString() +"     " + "Slimes Restantes: " + enemigosRestantes.toString() + tipoEnemigos.toString() + enemigosGenerados.toString()
    method textColor() = "#FA0770"

    method inicioOleada() = game.sound("m.inicioOleada.mp3")
    method finOleada() = game.sound("m.finOleada.mp3")

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
        if(cantidadEnemigos > enemigosGenerados && enemigosRestantes > 0){
            //Genera un nuevo enemigo de la lista y lo agrega a la cantidad de enemigos generados
            
            administradorDeEnemigos.generarEnemigo(tipoEnemigos.anyOne())
    
            //Decrementa la cantidad de enemigos restantes
            
        } else if (enemigosRestantes == 0 && enemigosGenerados == cantidadEnemigos){
            //Si se generaron todos los enemigos de la oleada, se llama a setear la proxima oleada
            //Limpia la lista de enemigos
            tipoEnemigos = []
            //Llama a setear la proxima oleada
            game.schedule(20000, {self.siguienteOleada()})
            //Decrementa la cantidad de enemigos generados
            enemigosGenerados = 0
            self.finOleada().volume(0.1)
            self.finOleada().play()
        } else if (enemigosRestantes == 0 && enemigosGenerados == 0){
            //Agrega un nuevo enemigo aleatorio de la lista
            if (tipoEnemigos.size() < 4) {tipoEnemigos.add(adminTipoOleada.agregarTipo(numeroOleada))}
        }
       }
    )
}

method siguienteOleada(){

    self.inicioOleada().volume(0.1)
    self.inicioOleada().play()
    // remuevo el evento que generaba enemigos en la oleada anterior
    game.removeTickEvent("agregar enemigo")
    // remuevo el evento que generaba el enemigo en la oleada anterior
    game.removeTickEvent("generar nuevo Enemigo")
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

    // inicio la siguiente oleada
    self.iniciarOleada()
}

method reducirEnemigos() { enemigosRestantes-=1}

method sumarEnemigo() {enemigosGenerados += 1}


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
