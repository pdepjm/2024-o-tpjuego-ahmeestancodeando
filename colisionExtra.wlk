import game.*

mixin Colision {
    method colisionEnFrente(posicion, filtro){
       const objetosEnFrente = game.getObjectsIn(posicion).filter({objeto => objeto.queSoy() == filtro})

    if (!objetosEnFrente.isEmpty()){
      const objeto = objetosEnFrente.first()
      return objeto
    }
    const objeto = object {method queSoy() = "nada"}
      return objeto
    }

    method colisionEnFrente(posicion, filtro1, filtro2){
       const objetosEnFrente = game.getObjectsIn(posicion).filter({objeto => objeto.queSoy() == filtro1 || objeto.queSoy() == filtro2})

    if (!objetosEnFrente.isEmpty()){
      const objeto = objetosEnFrente.first()
      return objeto
    }
    const objeto = object {method queSoy() = "nada"}
      return objeto
    }
}