// ===============================
// Revisado
// ===============================


import magos.*
import wollok.game.*

// ===============================
// Pala: Lo que no me gusta agarrar
// ===============================
object pala {
    const position = new MutablePosition(x=6, y=5)
    
    method image() = "pala.png"

    method position() = position

    method eliminarMago(magoSeleccionado){
        magoSeleccionado.eliminar()
    }
    method recibeDanioMago(danio){}
    method frenarEnemigo()= true
}
// Me da ansiedad la pala
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣶⣶⣶⣤⣀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⠋⠀⠀⠀⠈⠙⠛⢷⣦⡀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⣀⣤⠴⠶⠚⠛⠛⠛⠲⠾⢿⣟⠛⠻⠶⣤⣀⠀⠀⠙⣿⡀⠀⠀
//⠀⠀⠀⠀⣰⠟⣱⢦⢍⢋⠈⡂⠀⠀⠀⠀⠀⠈⠛⣦⠀⠀⠙⠳⣦⡀⣸⡇⠀⠀
//⠀⢀⣠⣤⣯⠤⠷⢦⣼⠈⢤⡅⠀⠀⠀⠀⠀⠀⠀⠘⠷⣄⠀⠀⢈⣿⡟⠀⠀⠀
//⢀⡾⠁⠂⠀⠀⠀⠈⣿⠀⠘⠁⠀⠀⠀⠀⠀⢀⠆⠀⠀⣸⠀⢀⣿⡿⠀⠀⠀⠀
//⣸⠃⠀⠀⠀⠀⠀⡜⢻⠀⢰⡀⠀⠒⠒⠀⣔⡁⠀⢀⠞⣽⣀⣾⡿⠁⠀⠀⠀⠀
//⢿⡀⠄⠀⠀⠀⢠⣷⢆⠝⢫⡀⠀⠀⠀⢰⢏⠩⠍⠁⠀⡏⣹⣿⣅⠀⠀⠀⠀⠀
//⠈⣻⣄⠀⠀⠀⢨⡿⠥⠄⣀⣹⠀⠀⠀⢸⡼⠀⠀⠀⡰⢰⣽⡿⣿⠇⠀⠀⠀⠀
//⠀⠙⠻⣿⣿⣶⣻⠤⠤⣄⣀⠈⠑⠓⠒⠋⡇⣀⠄⣊⣴⣿⠞⣷⡇⠀⠀⠀⠀⠀
//⠀⠀⠀⠈⠉⠻⣅⠀⢨⠀⠀⠉⢭⣽⣿⣉⣭⣴⣿⣿⣿⣇⠀⣿⣿⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⢐⡏⠀⠀⡀⠀⠀⠀⠹⣯⠛⠛⠁⣸⣿⠷⣯⣳⣾⣿⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⣰⠿⡖⢺⣿⣿⣆⠀⠀⠈⢷⡀⣰⣿⠃⠀⠀⠙⠳⠾⠁⠀⠀⠀⠀
//⠀⠀⠀⠀⢸⣏⣐⣷⠟⠁⠀⠙⣧⡀⠀⠈⢻⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠈⠙⠛⠉⠀⠀⠀⠀⣨⣷⣤⠚⢉⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡞⠫⣡⢣⣴⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣶⣾⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
// 
//     ^
//     | 
// es shinji en una silla, no malpienses