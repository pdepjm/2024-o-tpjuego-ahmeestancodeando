Magos Vs Slime
    El juego consiste en defender la base de slimes Atacantes, a partir de una variedad de Magos. 

Elementos:

Slimes: Enemigo básico, movimiento uniforme en dirección a la Base, 100 puntos de vida y 50 puntos de daño.

Magos: Encargadas de defender la base, su vida, daño y atributos varían según el mago:
    -Mago de Fuego: Lanza proyectiles con 75 puntos de daño que se destruyen al alcanzar a los enemigos o alcanzar el final del mapa.100 puntos de vida.
    -Mago irlandes: Aumenta la generación de dinero, $10 por mago. 100 puntos de vida, no realiza daño a enemigos.
    -Mago de Hielo: Lanza proyectiles penetrantes con 30 puntos de daño que continúa dañando enemigos hasta alcanzar el final del mapa.
    -Mago Piedra: Unida con 300 puntos de vida, no realiza daño a enemigos.
    -Mago Explosivo: Al entrar en contacto con un slime, explota.

Puntos: Utilizado para comprar magos, su generación es automática y la cantidad dependerá de la cantidad de magos irlandes que haya en el campo. La producción base es de $10/s.

El objetivo del juego es evitar que los slimes lleguen a la base, a partir de la compra y ubicación estratégica de los magos.

Se utiliza polimorfismo para por ejemplo, cuando los slimes detectan las colisiones contra plantas u otros slimes. Todos los objetos que pueden aparecer en los carriles(plantas, el cursor,slimes) tienen el método queSoy(), con el cual retornan qué clase de objeto son.
Otro ejemplo es el método disparar() que utilizan los magos. Todos los magos tienen este método, sin importar si disparan o no.

Además, se utiliza ampliamente la comunicación entre los distintos objetos, como es por ejemplo el caso del menú, el cual en base a los inputs que realice el jugador, enviará al objeto generadorDeEnemigos que clase de enemigo deberá generar y en qué posición.

Se utilizan clases para, por ejemplo, instanciar slimes, ya que tendremos varios objetos slime (identicos) que serán generados en el transcurso del juego, por lo que generadorDeEnemigos instanciará los slimes para crearlos cada cierto tiempo