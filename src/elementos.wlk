object castillo {
    const property altura = 20
    const bonificacionDefensa = 20
    const defensaTope = 200
    const tasaValor = 0.2
    var nivelDefensa = 150

    method nivelDefensa() = nivelDefensa
    method recibeAtaque(nivel) { nivelDefensa = (nivelDefensa - nivel).max(0) }
    method valor() = nivelDefensa * tasaValor
    method recibeTrabajo() { nivelDefensa = (nivelDefensa + bonificacionDefensa).min(defensaTope) }
}

object aurora {
    const property altura = 1
    const nivelAtaqueMinimo = 10
    const property valor = 15
    var estaViva = true
    
    method estaViva() = estaViva
    method recibeAtaque(nivel) { estaViva = (nivel < nivelAtaqueMinimo) }
    method recibeTrabajo() {}
}

object tipa {
    const factorDeCrecimiento = 1
    const multiplicadorValor = 2
    var altura = 8

    method altura() = altura
    method recibeAtaque(nivel) {}
    method valor() = altura * multiplicadorValor
    method recibeTrabajo() { altura += factorDeCrecimiento }
}