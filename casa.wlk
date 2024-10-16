object casa {
    var property vida = 3
    method recibirDanio() {
      self.vida(self.vida()-1)
    }
    method terminarJuego() = if (self.vida()==0) {
        
        game.addVisual(pantallaFinal)
        game.schedule(500,{game.stop()})
        }
}

class HitboxCasa {
   const position
   method position() = position
   method queSoy() = "casa"
}

const hitbox1 = new HitboxCasa(position = game.at(0, 0))
const hitbox2 = new HitboxCasa(position = game.at(0, 1))
const hitbox3 = new HitboxCasa(position = game.at(0, 2))
const hitbox4 = new HitboxCasa(position = game.at(0, 3))
const hitbox5 = new HitboxCasa(position = game.at(0, 4)) 

object pantallaFinal {
    method position()=game.at(0,0)
    method image()= "fin.jpg"
}
/* game.addVisual(hitbox1)
game.addVisual(hitbox2)
game.addVisual(hitbox3)
game.addVisual(hitbox4)
game.addVisual(hitbox5)
game.onCollideDo(hitbox1, {elemento => elemento.daniarCasa()})
game.onCollideDo(hitbox2, {elemento => elemento.daniarCasa()}) 
game.onCollideDo(hitbox3, {elemento => elemento.daniarCasa()}) 
game.onCollideDo(hitbox4, {elemento => elemento.daniarCasa()})
game.onCollideDo(hitbox5, {elemento => elemento.daniarCasa()})  */
