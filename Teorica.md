# Magos Vs Slime

El juego consiste en defender la base de los ataques de slimes, utilizando una variedad de magos con habilidades únicas.

---

## Elementos del Juego

### Slimes (Atacantes)
- **Slime Básico**: Movimiento uniforme hacia la base, 100 puntos de vida y 50 puntos de daño.
- **Slime Ninja**: Se mueve 2 casillas por turno (puede saltar unidades), tiene daño considerable pero vida baja.
- **Slime Guerrero**: Movimiento uniforme hacia la base, vida alta y daño bajo.
- **Slime Blessed**: Movimiento uniforme hacia la base, con vida y daño altos.
- **Slime Agil**: Se mueve a la casilla superior o inferior de manera aleatoria cuando recibe un disparo
- **Slime Ladron**: Quita dinero disponible
- **Slime dorado**: Otorga plata al matarlo, se mueve de a dos casillas y no genera daño al llegar a la "casa"
- **Slime Explosivo**: Explota al chocarse con un mago eliminandose el junto al mago.

### Magos (Defensores)
- **Mago de Fuego**: Lanza proyectiles con 75 puntos de daño que se destruyen al impactar enemigos o alcanzar el final del mapa. Vida: 100 puntos.
- **Mago Irlandés**: Incrementa la generación de dinero en $10 por mago. Vida: 100 puntos. No realiza daño a enemigos.
- **Mago de Hielo**: Lanza proyectiles penetrantes con 30 puntos de daño, que continúan dañando enemigos hasta alcanzar el final del mapa.
- **Mago de Piedra**: Unidad con 300 puntos de vida. No realiza daño a enemigos.
- **Mago Explosivo**: Explota al entrar en contacto con un slime.
- **Mago Stop**: Lanza un proyectil capaz de detener al slime durante un tick

### Recursos del Juego
- **Puntos**: Utilizados para comprar magos. La generación es automática y depende de la cantidad de magos irlandeses en el campo. Producción base: $10 por segundo.
- **Pala**: Permite eliminar magos del juego.
- **Tienda**: Sirve para comprar magos o seleccionar la pala para eliminarlos.
- **Base**: Ubicada en el extremo izquierdo de la pantalla. No se debe permitir que más de 3 slimes lleguen a ella. Si un slime alcanza la base, se eliminan todos los enemigos en su fila.

### Objetivo del Juego
Evitar que los slimes lleguen a la base mediante la compra y ubicación estratégica de los magos.

---

## Conceptos de Programación

### Polimorfismo
Se utiliza polimorfismo para definir comportamientos comunes entre los objetos del juego. Ejemplos:
- **Método `recibeDanioEnemigo(_danio)`**: Todos los objetos en los carriles (magos, slimes, cursor) tienen este método. Sin embargo, solo los slimes son afectados por el daño, mientras que los demás retornan `false`.
- **Método `recibeDanioMago(_danio)`**: Idem enemigo. Sin embargo, solo los magos son afectados por el daño, mientras que los demás retornan `false` (los slimes aprovechan esta llamada para efectuar la accion detenerse).
- **Método `disparar()`**: Implementado en todos los magos, incluso aquellos que no disparan.
- **Método `sePuedeSuperponer()`**: Indica cuales objetos se pueden superponer con el cursor, tambien es utilizado por el slime agil para saber donde ubicarse



### Comunicación entre Objetos
- El la tienda envía instrucciones al objeto `generadorDeMagos` para determinar qué tipo de mago generar y en qué posición.

### Uso de Clases
- Los slimes se instancian a partir de una clase base. El `administradorDeEnemigos` crea slimes periódicamente, asignando su tipo según lo que le envie el adminsitrador de oleadas.

---

## Diagrama de Clases
![Diagrama](https://github.com/user-attachments/assets/f98b45cf-0f3e-408f-a662-3a588bf05337)


> **Aclaracion**: Este diagrama está desactualizado debido a la complejidad del proyecto y la cercanía de la presentación con las fechas de parciales y finales. No tuvimos tiempo de rearmar el diagrama de clases pero ejemplifica lo mas esencial del proyecto, mostrando a los administradoes y como interactuan entre si para generar objetos.





