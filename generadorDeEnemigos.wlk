import zombie.*
object generadorDeEnemigos {
    var nombreEnemigo = 0
    const enemigo = #{}
   
    method nombre() = nombreEnemigo
    method sumarEnemigo() {
        nombreEnemigo+=1
        }
    method generarEnemigo(numero){
        if (numero==1) {
            var nombreParaEnemigo = self.nombre() 
            nombreParaEnemigo = new ZombiesNormales()
            enemigo.add(nombreParaEnemigo)
            return game.addVisual(nombreParaEnemigo)
        }
        return 0
    }
    method moverEnemigos() {
        enemigo.forEach({zombie => zombie.movete()})
    }
}