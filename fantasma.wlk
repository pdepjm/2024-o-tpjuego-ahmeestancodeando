class Fantasmas {
  const position
  
  method queSoy() = "fantasma"
  
  method position() = position
  
  method moveteDerecha() {
    position.goRight(1)
  }
  
  method colision() {
    // Filtro los objetos que son fantasmas, si no esta vacio tambien saco al cursor
    const objetoEnfrente = game.getObjectsIn(self.position()).filter(
      { objeto => objeto.queSoy() != "fantasma" }
    )
    // Use getObjectsIn pero podemos cambiarlo a game.collides de ser necesario
    if (!objetoEnfrente.isEmpty()) {
      if (objetoEnfrente.first().queSoy() == "cursor") objetoEnfrente.remove(
          objetoEnfrente.first()
        )
    }
    if (!objetoEnfrente.isEmpty()) {
      const objeto = objetoEnfrente.first()
      return objeto
    }
    const objeto = object {
      method queSoy() = "nada"
    }
    return objeto
    //Hice que devuelva el objeto en vez del tipo para que el enemigo sepa que hacer
  }
}