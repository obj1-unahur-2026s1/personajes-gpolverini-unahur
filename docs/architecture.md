# Arquitectura del Sistema

## Visión General

El proyecto "Juego con personajes y elementos" es un sistema orientado a objetos que modela un juego donde jugadores manejan personajes que interactúan con elementos. El sistema está diseñado siguiendo principios de programación orientada a objetos y el paradigma de Wollok.

## Diagrama de Componentes

```
┌────────────────────────────────────────────────┐
│                     ARMAS                      │
│  ┌──────────────┐  ┌───────────────┐           │
│  │   Ballesta   │  │    Jabalina   │           │
│  │ (10 flechas) │  │ (un solo uso) │           │
│  └──────────────┘  └───────────────┘           │
└────────────────────────────────────────────────┘
                         │
                         │ usa
                         ▼
┌────────────────────────────────────────────────┐
│                   PERSONAJES                   │
│  ┌──────────────┐  ┌──────────────┐            │
│  │    Floki     │  │    Mario     │            │
│  │  (Guerrero)  │  │ (Trabajador) │            │
│  └──────────────┘  └──────────────┘            │
└────────────────────────────────────────────────┘
                         │
                         │ interactúan
                         ▼
┌────────────────────────────────────────────────┐
│                    ELEMENTOS                   │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐      │
│  │ Castillo │  │  Aurora  │  │   Tipa   │      │
│  │(Defensa) │  │  (Vaca)  │  │  (Árbol) │      │
│  └──────────┘  └──────────┘  └──────────┘      │
└────────────────────────────────────────────────┘
                         │
                         │ gestiona
                         ▼
┌────────────────────────────────────────────────┐
│                     JUGADOR                    │
│  ┌──────────────────────────────────────────┐  │
│  │ Luisa - Gestiona personaje activo        │  │
│  │ - Puede cambiar entre Floki y Mario      │  │
│  │ - Delega encuentros al personaje activo  │  │
│  └──────────────────────────────────────────┘  │
└────────────────────────────────────────────────┘
```

## Módulos del Sistema

### 1. Armas (`src/armas.wlk`)

**Responsabilidad:** Modelar armas que pueden ser usadas por personajes.

#### Ballesta
**Propiedades:**
- `cantFlechas = 10` - Cantidad de flechas disponibles
- `potencia = 4` - Daño que causa

**Métodos:**
- `estaCargada()` - Retorna true si tiene flechas
- `usar()` - Pierde una flecha (mínimo 0)

**Comportamiento:**
- Nace con 10 flechas
- Cada uso pierde una flecha
- Está cargada si tiene al menos una flecha
- No puede tener flechas negativas

#### Jabalina
**Propiedades:**
- `estaCargada = true` - Estado de carga
- `potencia = 30` - Daño que causa

**Métodos:**
- `estaCargada()` - Retorna estado de carga
- `usar()` - Se descarga (solo se puede usar una vez)

**Comportamiento:**
- Nace cargada
- Se puede usar solo una vez
- Después de usar, queda descargada permanentemente

### 2. Elementos (`src/elementos.wlk`)

**Responsabilidad:** Modelar elementos del juego que interactúan con personajes.

#### Castillo
**Propiedades:**
- `altura = 20` - Altura en metros
- `nivelDefensa = 150` - Nivel de defensa actual
- `bonificacionDefensa = 20` - Defensa ganada al trabajar
- `defensaTope = 200` - Defensa máxima
- `tasaValor = 0.2` - Porcentaje de defensa que retorna como valor

**Métodos:**
- `altura()` - Retorna altura (20)
- `nivelDefensa()` - Getter/Setter de defensa
- `recibeAtaque(nivel)` - Pierde defensa (mínimo 0)
- `recibeTrabajo()` - Aumenta defensa y retorna 20% como valor

**Comportamiento:**
- Recibe ataques que disminuyen su defensa
- No puede tener defensa negativa
- Al recibir trabajo: aumenta defensa en 20 (máximo 200)
- Retorna el 20% de su defensa ACTUAL como valor

**Ejemplo:**
```
Castillo con defensa 150 recibe trabajo:
- Valor retornado: 150 * 0.2 = 30
- Nueva defensa: min(150 + 20, 200) = 170
```

#### Aurora (Vaca)
**Propiedades:**
- `altura = 1` - Altura en metros
- `estaViva = true` - Estado de vida
- `nivelAtaqueMinimo = 10` - Ataque necesario para morir
- `valorTrabajo = 15` - Valor que otorga

**Métodos:**
- `altura()` - Retorna altura (1)
- `estaViva()` - Getter/Setter de estado de vida
- `recibeAtaque(nivel)` - Muere si nivel >= 10
- `recibeTrabajo()` - Retorna 15 de valor

**Comportamiento:**
- Muere si recibe un ataque de 10 o más
- No muere con ataques menores a 10
- No recibe daño del trabajo
- Siempre otorga 15 de valor

#### Tipa (Árbol)
**Propiedades:**
- `altura = 8` - Altura inicial en metros
- `crecimientoAltura = 1` - Metros que crece al trabajar
- `multiplicadorValor = 2` - Factor para calcular valor

**Métodos:**
- `altura()` - Getter/Setter de altura
- `recibeAtaque(nivel)` - No recibe daño
- `recibeTrabajo()` - Crece 1 metro y retorna altura * 2

**Comportamiento:**
- No recibe daño de ataques
- Crece 1 metro cada vez que recibe trabajo
- Retorna el doble de su altura ACTUAL como valor

**Ejemplo:**
```
Tipa con altura 8 recibe trabajo:
- Valor retornado: 8 * 2 = 16
- Nueva altura: 8 + 1 = 9
```

### 3. Personajes (`src/personajes.wlk`)

**Responsabilidad:** Modelar personajes que interactúan con elementos.

#### Floki (Guerrero)
**Propiedades:**
- `arma = ballesta` - Arma actual (intercambiable)

**Métodos:**
- `arma()` - Getter/Setter del arma
- `encontrar(elemento)` - Interactúa con elemento

**Comportamiento:**
- Si el arma está cargada:
  - El elemento recibe un ataque con la potencia del arma
  - El arma se usa (se descarga)
- Si el arma no está cargada:
  - No ocurre nada

**Ejemplo:**
```
Floki con ballesta (potencia 4) encuentra castillo:
- Castillo recibe ataque de 4
- Ballesta pierde una flecha
```

#### Mario (Trabajador)
**Propiedades:**
- `valor = 0` - Valor acumulado
- `alturaUltimoElemEncontrado = 0` - Altura del último elemento
- `valorMinimFelicidad = 50` - Valor mínimo para ser feliz
- `alturaMinimFelicidad = 10` - Altura mínima para ser feliz

**Métodos:**
- `valor()` - Getter/Setter de valor
- `encontrar(elemento)` - Interactúa con elemento
- `esFeliz()` - Retorna true si cumple condiciones de felicidad

**Comportamiento:**
- Al encontrar un elemento:
  - Acumula el valor que retorna el elemento
  - Guarda la altura del elemento
- Es feliz si:
  - Ha acumulado 50 o más de valor, O
  - El último elemento encontrado mide 10 o más metros

**Ejemplo:**
```
Mario encuentra castillo (defensa 150):
- Valor acumulado: 0 + (150 * 0.2) = 30
- Altura guardada: 20
- ¿Es feliz? Sí (altura 20 >= 10)

Mario encuentra aurora (altura 1, valor 15):
- Valor acumulado: 30 + 15 = 45
- Altura guardada: 1
- ¿Es feliz? No (valor 45 < 50 Y altura 1 < 10)
```

### 4. Jugador (`src/jugadores.wlk`)

**Responsabilidad:** Gestionar el personaje activo y delegar encuentros.

#### Luisa
**Propiedades:**
- `personajeActivo = floki` - Personaje que está controlando

**Métodos:**
- `personajeActivo()` - Getter/Setter del personaje activo
- `aparece(elemento)` - Delega encuentro al personaje activo

**Comportamiento:**
- Puede cambiar entre Floki y Mario
- Cuando aparece un elemento, delega al personaje activo
- El personaje activo decide cómo interactuar

**Ejemplo:**
```
Luisa con Mario activo aparece castillo:
- Luisa.aparece(castillo)
- Mario.encontrar(castillo)
- Mario acumula valor
```

## Patrones de Diseño

### 1. Singleton Pattern
Todos los objetos son singletons (una única instancia):
- Armas: `ballesta`, `jabalina`
- Elementos: `castillo`, `aurora`, `tipa`
- Personajes: `floki`, `mario`
- Jugador: `luisa`

**Ventaja:** Simplifica el modelo y evita duplicación de estado

### 2. Composition
- Floki compone un arma (puede cambiarla)
- Luisa compone un personaje activo (puede cambiarlo)

**Ventaja:** Permite cambiar comportamiento en tiempo de ejecución

### 3. Polymorphism
Todos los elementos responden a la interfaz:
- `altura()` - Altura del elemento
- `recibeAtaque(nivel)` - Reacción al ataque
- `recibeTrabajo()` - Reacción al trabajo

**Ventaja:** Permite agregar nuevos elementos sin cambiar personajes

### 4. Delegation
- Luisa delega encuentros al personaje activo
- Personajes delegan acciones a elementos

**Ventaja:** Separación de responsabilidades

## Decisiones de Diseño

### ¿Por qué separar armas en objetos?

**Razón:** Permite que diferentes personajes usen diferentes armas y que las armas tengan su propio estado (flechas, carga).

### ¿Por qué Mario guarda la altura del último elemento?

**Razón:** Necesita esta información para evaluar la segunda condición de felicidad (elemento alto).

### ¿Por qué Floki solo ataca si el arma está cargada?

**Razón:** Simula realismo: no puedes atacar sin munición o con un arma descargada.

### ¿Por qué usar constantes para valores mágicos?

**Razón:** Facilita cambios futuros y hace el código más legible y mantenible.

### ¿Por qué Castillo retorna valor ANTES de aumentar defensa?

**Razón:** El valor representa lo que el elemento "produce" en su estado actual, no después de ser mejorado.

## Extensibilidad

El sistema está diseñado para ser fácilmente extensible:

### Agregar nuevas armas
```wollok
object espada {
    const property potencia = 20
    method estaCargada() = true
    method usar() {}
}
```

### Agregar nuevos elementos
```wollok
object rio {
    const property altura = 5
    method recibeAtaque(nivel) {}
    method recibeTrabajo() = 10
}
```

### Agregar nuevos personajes
```wollok
object cazador {
    var property arma = ballesta
    method encontrar(elemento) { /* lógica */ }
}
```

## Flujo de Interacción Típico

1. **Configuración inicial:**
   ```wollok
   luisa.personajeActivo(floki)
   ```

2. **Encuentro:**
   ```wollok
   luisa.aparece(castillo)
   // Floki ataca castillo si ballesta está cargada
   ```

3. **Cambio de personaje:**
   ```wollok
   luisa.personajeActivo(mario)
   luisa.aparece(castillo)
   // Mario recolecta valor del castillo
   ```

4. **Evaluación de estado:**
   ```wollok
   mario.esFeliz()
   ```

## Consideraciones de Testing

Cada módulo tiene su propia suite de tests:
- `tests/armas.wtest` - Tests de armas
- `tests/elementos.wtest` - Tests de elementos
- `tests/personajes.wtest` - Tests de personajes
- `tests/jugadores.wtest` - Tests de jugadores

Ver [testing.md](testing.md) para más detalles sobre estrategias de testing.

## Diagrama de Secuencia: Encuentro Típico

```
Luisa                Mario              Castillo
  │                    │                    │
  ├─ aparece(castillo) │                    │
  │                    ├─ encontrar(castillo)
  │                    │                    │
  │                    ├─ recibeTrabajo()   │
  │                    │◄───────────────────┤
  │                    │ retorna: 30         │
  │                    │                    │
  │                    ├─ valor += 30       │
  │                    │                    │
  │                    ├─ altura = 20       │
  │                    │                    │
  │◄───────────────────┤                    │
  │                    │                    │
```
