object adminVisuales{
    const tablero=[
        [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
        [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
        [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
        [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
        [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
    ]
    method asignarposicion(objeto){
    const x = objeto.position().x()
    const y=  objeto.position().y()
    tablero.get(y).get(x).add(objeto)
    }
    method sacarObjeto(objeto){
    const x=objeto.position().x()
    const y=objeto.position().y()
    tablero.get(y).get(x).remove(objeto)
    }
    method objetosEnPosicion(x,y){
        if (x!=-1){return tablero.get(y).get(x)}
        else return tablero.get(y).get(15)
    }
    method eliminarSlime(slime){
    const x=slime.position().x()
    const y=slime.position().y()
    tablero.get(y).get(x+1).remove(slime)
    }
}
