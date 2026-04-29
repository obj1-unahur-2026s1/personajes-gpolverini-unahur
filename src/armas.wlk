object ballesta {
    var cantFlechas = 10
    const property potencia = 4

    method estaCargada() = cantFlechas > 0
    method usar() { cantFlechas = (cantFlechas - 1).max(0) }
}

object jabalina {
    var estaCargada = true
    const property potencia = 30
    
    method estaCargada() = estaCargada
    method usar() { estaCargada = false }
}