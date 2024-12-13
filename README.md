# Magos Vs. Slimes
### UTN - Facultad Regional Buenos Aires - Materia Paradigmas de Programación

![portada](Cosas_juego/portada/title1.jpg)

### Trailer
[![Trailer](https://i.ibb.co/Dp3vzNH/TRAILER-12-4-2024.png)](https://youtu.be/0D9ru_qJyPM?si=un1xRSzEtPHEvkAe)

[Probar sin descargar (Version desactualizada)](https://www.wollok.org/concurso/2024-o-tpjuego-ahmeestancodeando/)

Magos vs Slimes es un emocionante videojuego de estrategia y defensa en el que los jugadores deben proteger la última ciudad de la humanidad, Utopía de las Tierras de Nortfernand (UTN), de interminables oleadas de Slimes. Con una variada selección de Magos, cada uno con habilidades y poderes únicos, tendrás que impedir que los Slimes alcancen las puertas de la ciudad. Si tres o más logran atravesar tus defensas, el juego llegará a su fin y la humanidad perecerá...

¡Prepárate para la batalla y salva a la UTN del caos!

## Magos
Cada Mago tiene una función específica, como disparar proyectiles, bloquear el avance de los zombis, explotar causando daño, entre otros. Los Magos requieren Dinero para poder ser contratados, este dinero se genera automáticamente a lo largo de la partida.

<div align="center">
  <table>
    <tr>
      <td align="center"><img src="assets/magoFuego.png" alt="Mago de Fuego" width="100"><br>Daño: 🔥🔥<br>Vida: ❤️<br>Dispara</td>
      <td align="center"><img src="assets/magoHielo.png" alt="Mago de Hielo" width="100"><br>Daño: ❄️❄️❄️<br>Vida: 💙<br>Dispara</td>
      <td align="center"><img src="assets/magoHealer.png" alt="Mago Irlandés" width="100"><br>Daño: 🤑<br>Vida: 💚<br>Genera Dinero</td>
      <td align="center"><img src="assets/magoPiedra.png" alt="Mago de Piedra" width="100"><br>Daño: ☮️<br>Vida: 🗿🗿🗿<br>Protección</td>
      <td align="center"><img src="assets/magoExplosivo.png" alt="Papa John" width="100"><br>Daño: 💣💣💣<br>Vida: ☠️☠️☠️<br>Explota</td>
      <td align="center"><img src="assets/magoStop.png" alt="Mago Stop" width="100"><br>Daño: 🤚<br>Vida: ❤️<br>Dispara</td>
    </tr>
  </table>
</div>

## Proyectiles
Cada tipo de Proyectil tiene daño o efecto propio. Los proyectiles se pueden fusionar dando lugar a versiones más poderosas.

<div align="center">
  <table>
    <tr>
      <td align="center"><img src="assets/p.proyectilFuego - frame2.png" alt="Proyectil Fuego" width="100"><br>Daño: 🔥🔥</td>
      <td align="center">➡️</td>
      <td align="center"><img src="assets/p.proyectilHielo-frame2.png" alt="Proyectil Hielo" width="100"><br>Daño: ❄️❄️❄️</td>
      <td align="center">➡️</td>
      <td align="center"><img src="assets/p.superProyectil-2.png" alt="Super Proyectil" width="100"><br>Daño: 🟣🟣🟣🟣</td>
    </tr>
    <tr> Al juntarse dos proyectiles identicos se convierte en uno mejor </tr>
    <tr>
      <td align="center" colspan="5"><img src="assets/p.proyectilDeStop-frame2.png" alt="Proyectil Stop" width="100"><br>Daño: 🤚<br>Ralentiza enemigos</td>
    </tr>
  </table>
</div>

## Slimes
Los distintos Slimes tienen características propias: más vida, más daño, movimientos especiales, entre otras cosas. Atacan en oleadas desde el extremo derecho del tablero e intentan llegar a la base de los magos (extremo izquierdo del tablero).

<div align="center">
  <table>
    <tr>
      <td align="center"><img src="assets/s.slimeBase_02.png" alt="Slime Básico" width="150"><br>Daño: 🟢<br>Vida: 💚💚<br> - </td>
      <td align="center"><img src="assets/s.slimeGuerrero_02.png" alt="Slime Guerrero" width="150"><br>Daño: 🟢<br>Vida: 💚💚💚<br> Tiene mas vida</td>
      <td align="center"><img src="assets/s.slimeNinja_02.png" alt="Slime Ninja" width="150"><br>Daño: 🥷🥷🥷<br>Vida: 💚💚<br> Se mueve de a dos celdas </td>
      <td align="center"><img src="assets/s.slimeBlessed_02.png" alt="Slime Bendito" width="150"><br>Daño: 🛐🛐🛐<br>Vida: 🛐🛐🛐<br> Mucha vida y daño </td>
    </tr>
    <tr>
      <td align="center"><img src="assets/s.slimeDorado_02.png" alt="Slime Dorado" width="150"><br>Daño: -<br>Vida: 💚💚💚<br> Da dinero al morir </td>
      <td align="center"><img src="assets/s.slimeLadron_02.png" alt="Slime Ladrón" width="150"><br>Daño: 🟢<br>Vida: 💚💚<br> Roba dinero </td>
      <td align="center"><img src="assets/s.slimeMedioOriente_02.png" alt="Slime Bomba" width="150"><br>Daño: 💣💣💣<br>Vida: 💚💚💚<br> Explota </td>
      <td align="center"><img src="assets/s.slimeAgil_02.png" alt="Slime Ágil" width="150"><br>Daño: 🟢<br>Vida: 💚💚💚<br> Se mueve de fila </td>
    </tr>
  </table>
</div>

## Modos de Juego

**Historia:** Enfrentar diversos niveles con cambios en tipos y dificultad de oleadas.

**Eterno:** Modo desafiante en el que se enfrentan oleadas interminables y aleatorias de Slimes, con dificultad creciente.

## Controles:

- `A` para ir a la izquierda en la tienda
- `D` para ir a la derecha en la tienda
- `ARROW_UP` para mover arriba cursor
- `ARROW_LEFT` para mover izquierda cursor
- `ARROW_RIGHT` para mover derecha cursor
- `ARROW_DOWN` para mover abajo cursor
- `ENTER` para poner planta / utilizar pala
- `P` para reiniciar juego
- `I` termina el juego
- `O` para pausar juego
- `X` Ir al Menú Principal

## Equipo de desarrollo:

- Echeverría, Manuel
- Marek, Nahuel
- Marzocca, Damián
- Schkurko, Nicolás
- Vallone, Matías

## Capturas

![1](https://github.com/user-attachments/assets/1297f5c8-e4a1-44d0-8f46-1c002f1cb82f)

![3](https://github.com/user-attachments/assets/78192b7f-5ce0-4f2e-b012-98eb4f4dc90a)

## Como está hecho

[Acceso a teórica](https://github.com/pdepjm/2024-o-tpjuego-ahmeestancodeando/blob/concurso/Teorica.md)

## Links relevantes

- [Probar sin descargar (Version desactualizada))](https://www.wollok.org/concurso/2024-o-tpjuego-ahmeestancodeando/)
- [Link al Lore](https://docs.google.com/document/d/1lBfEKnoyl5uwRfzc_BIOiNtRY3-iJxHwnHqUtpygSzU/edit?tab=t.0)
- [Link al Trailer](https://youtu.be/0D9ru_qJyPM?si=un1xRSzEtPHEvkAe)

## Updates
> 09-12-24 1.01v: Animaciones disparo, mejoras rendimiento, mejoras sonido, balanceo general

