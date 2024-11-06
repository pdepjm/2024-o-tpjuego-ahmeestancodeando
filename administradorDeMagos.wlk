import magos.*
object administradorDeMagos {
    var nombreMago = 0 /*asigno el nombre  a los enemigos que voy creando segun numeros, asi puedo crear nombres nuevos
                            automaticamente*/

    const magos = #{}/*contiene cada mago que fue creando*/
    method magos() = magos

    var property  magoAGenerar  = magoPiedraTienda

    method nombre() = nombreMago /*para poder consultar el ultimo nombre usado*/
    method sumarMago() { /*suma 1 a nombre mago para asi crear magos nuevos, luego hay que hacer la funcion para que reste 1 cuando maten a un enemigo*/
        nombreMago+=1
        }
        
    method generarMago(magoSeleccionado,posicion){ // metodo para no usar los if anidados
        self.magoAGenerar(magoSeleccionado) //esto para cambiar la mago segun lo que se elija
        var nuevoMago = self.nombre() 
        nuevoMago = self.magoAGenerar().generarMago(posicion) //lama al objeto de la tienda para saber como generar una mago
        magos.add(nuevoMago)
        magoSeleccionado.efectoDeInvocacion()
        self.sumarMago()
        return game.addVisual(nuevoMago)
    }

    method estanMuertos(){
        magos.forEach({mago => mago.estaMuerto()})
    }

    method disparar() {
      magos.forEach({mago => mago.disparar()})
    }

    method eliminarMago(mago){
        magos.remove(mago)
    }
    
    method reset() {
        magos.forEach({mago => mago.eliminar()})
        nombreMago = 0 
    }

}