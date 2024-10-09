class Fantasmas {
  const position 
  var property estado= "movil"
  method queSoy() = "fantasma"
  method position() = position
  method moveteDerecha() {
    position.goRight(1)
  }
  method colision(){
    const objetoEnfrente = game.colliders(self)
    if (!objetoEnfrente.isEmpty()){
    const objeto = objetoEnfrente.first()
    return objeto
    }
    const objeto = object {method queSoy() = "nada"}
    return objeto

    //Hice que devuelva el objeto en vez del tipo para que el enemigo sepa que hacer

}
}
