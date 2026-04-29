import src.armas.*

object floki {
    var arma = ballesta

    method cambiarArma(unArma) { arma = unArma }
    method encontrar(elemento) {
        if(arma.estaCargada()) {
            elemento.recibeAtaque(arma.potencia())
            arma.usar()
        }
    }
}

object mario {
    const valorMinFelicidad = 50
    const alturaMinFelicidad = 10
    var valor = 0
    var alturaUltimoElemEncontrado = 0

    method encontrar(elemento) {
        elemento.recibeTrabajo()
        alturaUltimoElemEncontrado = elemento.altura()
        valor += elemento.valor()
    }
    method esFeliz() = valor >= valorMinFelicidad || alturaUltimoElemEncontrado >= alturaMinFelicidad
}