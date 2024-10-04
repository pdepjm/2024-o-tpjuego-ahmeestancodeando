import plantas.*
object generadorDePlantas {
    var nombrePlanta = 0 /*asigno el nombre  a los enemigos que voy creando segun numeros, asi puedo crear nombres nuevos
                            automaticamente*/

    const plantas = #{}/*contiene cada enemigo que fue creando*/
   
    method nombre() = nombrePlanta /*para poder consultar el ultimo nombre usado*/
    method sumarPlanta() { /*suma 1 a nombre enemigo para asi crear enemigos nuevos, luego hay que hacer la funcion               para que reste 1 cuando maten a un enemigo*/
        nombrePlanta+=1
        }
    method generarPlanta(planta, posicion){/*segun el numero ingresado, se generara un tipo de enemigo distinto*/
        var nombreParaPlanta = self.nombre() /* esto esta hecho porque sino wollok se enoja,para poder crear un enemigo*/
        if (planta=="papa")
            nombreParaPlanta = new Papa(position= posicion)
        else if (planta=="guisante")
            nombreParaPlanta = new Guisante(position= posicion)
        plantas.add(nombreParaPlanta)/*se añade a la lista de enemigos activos*/
        return game.addVisual(nombreParaPlanta)/*muestra al enemigo en el juego*/

    }
}