object pepita {
  var energy = 100
  const position = new MutablePosition(x=2, y=2)

  method image() = "golondrina.png"
  method position() = position

  method energy() = energy

  method fly(minutes) {
    energy = energy - minutes * 3
    position.goRight(minutes)
    position.goUp(minutes)
  }

}