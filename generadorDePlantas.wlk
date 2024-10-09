import plantas.*
object generadorDePlantas {
    var nombrePlanta = 0 /*asigno el nombre  a los enemigos que voy creando segun numeros, asi puedo crear nombres nuevos
                            automaticamente*/

    const plantas = #{}/*contiene cada enemigo que fue creando*/
    method plantas() = plantas

    var plantaAGenerar = papaTienda
    method plantaAGenerar() = plantaAGenerar
    method plantaAGenerar(planta){
        plantaAGenerar = planta
        }


    method nombre() = nombrePlanta /*para poder consultar el ultimo nombre usado*/
    method sumarPlanta() { /*suma 1 a nombre planta para asi crear plantas nuevos, luego hay que hacer la funcion para que reste 1 cuando maten a un enemigo*/
        nombrePlanta+=1
        }
        
    method generarPlanta(planta, posicion){/*segun el numero ingresado, se generara un tipo de enemigo distinto*/
        var nombreParaPlanta = self.nombre() /* esto esta hecho porque sino wollok se enoja,para poder crear un enemigo*/
        if (planta=="papa")
            nombreParaPlanta = new Papa(position= posicion)
        else if (planta=="guisante")
            nombreParaPlanta = new Guisante(position= posicion)
        else if (planta=="cactus")
            nombreParaPlanta = new Cactus(position= posicion)
        else if (planta=="girasol")
            nombreParaPlanta = new Girasol(position= posicion)
        else if (planta=="zapallo enojado")
            nombreParaPlanta = new ZapalloEnojado(position= posicion)
        

        plantas.add(nombreParaPlanta)/*se añade a la lista de plantas activos*/

        self.sumarPlanta()

        return game.addVisual(nombreParaPlanta)/*muestra al enemigo en el juego*/
    }

    method generarPlanta2(plantaSeleccionada,posicion){ // metodo para no usar los if anidados
        self.plantaAGenerar(plantaSeleccionada) //esto para cambiar la planta segun lo que se elija
        var nombreParaPlanta = self.nombre() 
        nombreParaPlanta = self.plantaAGenerar().generarPlanta(posicion) //lama al objeto de la tienda para saber como generar una planta
        plantas.add(nombreParaPlanta)
        plantaSeleccionada.efectoDeInvocacion()
        self.sumarPlanta()
        return game.addVisual(nombreParaPlanta)
    }

    method siguenVivas(){
        plantas.forEach({planta => planta.sigueViva()})
    }
}