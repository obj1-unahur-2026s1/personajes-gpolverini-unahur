import src.personajes.*

object luisa {
    var personajeActivo = floki
    
    method cambiarPersonaje(unPersonaje) { personajeActivo = unPersonaje }
    method aparece(elemento) { personajeActivo.encontrar(elemento) }
}