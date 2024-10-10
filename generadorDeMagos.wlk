import magos.*
object generadorDeMagos {
    var nombreMago = 0 /*asigno el nombre  a los enemigos que voy creando segun numeros, asi puedo crear nombres nuevos
                            automaticamente*/

    const magos = #{}/*contiene cada enemigo que fue creando*/
    method magos() = magos

    var magoAGenerar = magoPiedraTienda
    method magoAGenerar() = magoAGenerar
    method magoAGenerar(mago){
        magoAGenerar = mago
        }


    method nombre() = nombreMago /*para poder consultar el ultimo nombre usado*/
    method sumarMago() { /*suma 1 a nombre mago para asi crear magos nuevos, luego hay que hacer la funcion para que reste 1 cuando maten a un enemigo*/
        nombreMago+=1
        }
        
    method generarMago(mago, posicion){/*segun el numero ingresado, se generara un tipo de enemigo distinto*/
        var nombreParaMago = self.nombre() /* esto esta hecho porque sino wollok se enoja,para poder crear un enemigo*/
        if (mago=="papa")
            nombreParaMago = new MagoEnojado(position= posicion)
        else if (mago=="guisante")
            nombreParaMago = new MagoEnojado(position= posicion)
        else if (mago=="cactus")
            nombreParaMago = new MagoEnojado(position= posicion)
        else if (mago=="girasol")
            nombreParaMago = new MagoEnojado(position= posicion)
        else if (mago=="zapallo enojado")
            nombreParaMago = new MagoEnojado(position= posicion)
        
        magos.add(nombreParaMago)/*se añade a la lista de magos activos*/

        self.sumarMago()

        return game.addVisual(nombreParaMago)/*muestra al enemigo en el juego*/
    }

    method generarMago2(magoSeleccionado,posicion){ // metodo para no usar los if anidados
        self.magoAGenerar(magoSeleccionado) //esto para cambiar la mago segun lo que se elija
        var nombreParaMago = self.nombre() 
        nombreParaMago = self.magoAGenerar().generarMago(posicion) //lama al objeto de la tienda para saber como generar una mago
        magos.add(nombreParaMago)
        magoSeleccionado.efectoDeInvocacion()
        self.sumarMago()
        return game.addVisual(nombreParaMago)
    }

    method siguenVivas(){
        magos.forEach({mago => mago.sigueViva()})
    }
}