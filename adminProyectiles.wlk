// ===============================
// Revisado
// ===============================

import game.*
import proyectil.*
// ===============================
// Administrador de Proyectiles: Controla la creación y gestión de proyectiles
// ===============================
object administradorDeProyectiles {
    // Propiedades
    var nombreProyectil = 20000 // Identificador único para cada proyectil creado
    var property proyectiles = #{} // Almacena los proyectiles creados

    method nombre() = nombreProyectil // Obtiene el último nombre usado

    // Incrementa el contador de nombreProyectil para nombrar proyectiles de manera única
    method sumarProyectil() { nombreProyectil += 1 }

    // Genera un nuevo proyectil en la posición y tipo especificado
    method generarProyectil(posicion, tipoProyectil) {
        var nombreParaProyectil = self.nombre()
        nombreParaProyectil = new Proyectil(position = posicion, tipo = tipoProyectil)
        proyectiles.add(nombreParaProyectil)
        self.sumarProyectil()
        return game.addVisual(nombreParaProyectil)
    }

    // Mueve cada proyectil en la lista
    method moverProyectiles() {
        proyectiles.forEach({ proyectil => proyectil.mover() })
    }

    // Activa la colisión para cada proyectil en la lista
    method impactarProyectiles() {
        proyectiles.forEach({ proyectil => proyectil.colisionar() })
    }

    // Elimina un proyectil de la lista
    method destruirProyectil(proyectil) {
        proyectiles.remove(proyectil)
    }

    // Restablece el administrador, eliminando todos los proyectiles y reiniciando el contador de nombres
    method reset() {
        proyectiles.forEach({ proyectil => proyectil.eliminar() })
        nombreProyectil = 0
        proyectiles = []
    }
}
