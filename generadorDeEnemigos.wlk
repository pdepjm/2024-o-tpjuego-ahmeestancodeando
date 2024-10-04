import zombie.*
object generadorDeEnemigos {
    var nombreEnemigo = 0 /*asigno el nombre  a los enemigos que voy creando segun numeros, asi puedo crear nombres nuevos
                            automaticamente*/
    
    const enemigo = #{}/*contiene cada enemigo que fue creando*/
   
    method nombre() = nombreEnemigo /*para poder consultar el ultimo nombre usado*/
    method sumarEnemigo() { /*suma 1 a nombre enemigo para asi crear enemigos nuevos, luego hay que hacer la funcion
                            para que reste 1 cuando maten a un enemigo*/
        nombreEnemigo+=1
        }
    method generarEnemigo(numero){/*segun el numero ingresado, se generara un tipo de enemigo distinto*/
        if (numero==1) {/*generara un zombie normal*/
            var nombreParaEnemigo = self.nombre() /* esto esta hecho porque sino wollok se enoja, 
                                                    para poder crear un enemigo*/
            nombreParaEnemigo = new ZombiesNormales(position= new MutablePosition(x=10, y=0.randomUpTo(5).truncate(0)))
            enemigo.add(nombreParaEnemigo)/*se añade a la lista de enemigos activos*/
            return game.addVisual(nombreParaEnemigo)/*muestra al enemigo en el juego*/
        }
        return 0
    }
    method moverEnemigos() {
        enemigo.forEach({zombie => zombie.movete()})/*aplica la funcion movete a cada enemigo de la coleccion*/
    }
}