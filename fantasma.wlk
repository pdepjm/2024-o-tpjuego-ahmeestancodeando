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
    const objeto = objetoEnfrente.first().queSoy()
    return objeto=="planta"
    }
    else return false
}
}