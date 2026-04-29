# Guía para Desarrolladores

## Introducción

Esta guía está diseñada para ayudar a desarrolladores que quieran contribuir o extender el proyecto "Juego con personajes y elementos". Aquí encontrarás información sobre el flujo de trabajo, convenciones de código y mejores prácticas.

## Configuración del Entorno de Desarrollo

### Requisitos
- Visual Studio Code con extensión de Wollok
- Wollok 4.0.0+
- Git

### Configuración Inicial
```bash
# Clonar el repositorio
git clone <url-del-repositorio>
cd juego-personajes-elementos

# Abrir en VS Code
code .
```

Ver [setup.md](setup.md) para instrucciones detalladas.

## Flujo de Trabajo

### 1. Antes de Empezar

1. **Actualiza tu rama local:**
   ```bash
   git checkout main
   git pull origin main
   ```

2. **Crea una nueva rama:**
   ```bash
   git checkout -b feature/nombre-descriptivo
   # o
   git checkout -b fix/nombre-del-bug
   ```

### 2. Durante el Desarrollo

1. **Escribe tests primero (TDD) con formato BDD:**
   ```wollok
   describe "Personaje | Nueva funcionalidad" {
       test "Given: estado inicial | When: acción | Then: resultado esperado" {
           // Test que falla
           assert.equals(valorEsperado, personaje.nuevoMetodo())
       }
   }
   ```

2. **Implementa la funcionalidad:**
   ```wollok
   object personaje {
       method nuevoMetodo() {
           // Implementación mínima para pasar el test
       }
   }
   ```

3. **Ejecuta los tests frecuentemente:**
   - Después de cada cambio significativo
   - Antes de hacer commit

4. **Refactoriza:**
   - Mejora el código manteniendo los tests en verde
   - Elimina duplicación
   - Mejora nombres de variables/métodos

### 3. Antes de Hacer Commit

1. **Ejecuta TODOS los tests:**
   - Desde VS Code: Ctrl+Shift+P → "Wollok: Run All Tests"
   - O desde terminal: `wollok test` (si tienes Wollok CLI)

2. **Verifica que no haya errores de compilación:**
   - Revisa el panel "Problems" en VS Code (Ctrl+Shift+M)

3. **Revisa tus cambios:**
   ```bash
   git status
   git diff
   ```

### 4. Hacer Commit

```bash
# Agrega los archivos modificados
git add src/archivo.wlk tests/archivo.wtest

# Commit con mensaje descriptivo
git commit -m "Agrega nueva mecánica al juego

- Implementa método nuevoMetodo()
- Agrega tests para casos límite
- Fixes #123"
```

### 5. Push y Pull Request

```bash
# Push a tu rama
git push origin feature/nombre-descriptivo

# Crea un Pull Request en GitHub/GitLab
# Describe los cambios y referencia issues relacionados
```

## Convenciones de Código

### Nomenclatura

#### Objetos
```wollok
// Objetos singleton: camelCase
object floki { }
object mario { }
object castillo { }
```

#### Métodos
```wollok
// Métodos: camelCase
method encontrar(elemento) { }
method recibeAtaque(nivel) { }
method estaCargada() { }
```

#### Variables
```wollok
// Variables: camelCase
const potencia = 4
var nivelDefensa = 150
```

### Estilo de Código

#### Indentación
- Usa **2 espacios** (no tabs)
- VS Code con la extensión de Wollok lo configura automáticamente

#### Llaves
```wollok
// ✓ Bueno: llave de apertura en la misma línea
method ejemplo() {
    // código
}

// ✗ Malo: llave de apertura en nueva línea
method ejemplo()
{
    // código
}
```

#### Espacios
```wollok
// ✓ Bueno: espacios alrededor de operadores
const resultado = potencia + 10

// ✗ Malo: sin espacios
const resultado=potencia+10

// ✓ Bueno: espacio después de comas
method metodo(param1, param2, param3)

// ✗ Malo: sin espacios
method metodo(param1,param2,param3)
```

#### Líneas en Blanco
```wollok
object floki {
    // Una línea en blanco entre métodos
    method encontrar(elemento) {
        // código
    }
    
    method cambiarArma(arma) {
        // código
    }
}
```

### Comentarios

#### Cuándo Comentar
```wollok
// ✓ Bueno: comentar lógica compleja o no obvia
// tasaValor: porcentaje de defensa que se retorna como valor
const tasaValor = 0.2

// ✗ Malo: comentar lo obvio
method potencia() {
    return potencia  // retorna potencia
}
```

#### Comentarios TODO
```wollok
// TODO: Implementar validación de nivel negativo
// FIXME: Este método no maneja el caso de altura cero
// HACK: Solución temporal hasta refactorizar
```

## Mejores Prácticas

### 1. Principio de Responsabilidad Única
Cada objeto debe tener una sola responsabilidad:

```wollok
// ✓ Bueno: cada objeto tiene una responsabilidad clara
object floki {
    // Responsabilidad: gestionar encuentros con arma
}

object castillo {
    // Responsabilidad: gestionar defensa y trabajo
}

// ✗ Malo: objeto con múltiples responsabilidades
object juego {
    // Gestiona floki, mario, castillo, aurora, tipa
}
```

### 2. Encapsulamiento
No expongas detalles de implementación:

```wollok
// ✓ Bueno: encapsula el estado interno
object castillo {
    var nivelDefensa = 150  // privado
    const bonificacionDefensa = 20
    const defensaTope = 200
    
    method nivelDefensa() = nivelDefensa  // getter
    
    method recibeTrabajo() {
        nivelDefensa = (nivelDefensa + bonificacionDefensa).min(defensaTope)
    }
}

// ✗ Malo: expone detalles internos con property
object castillo {
    var property nivelDefensa = 150  // público, puede ser modificado directamente
    var property bonificacionDefensa = 20
}
```

**Diferencia:**
- `var property` → Crea getter y setter públicos (expone el estado)
- `var` → Variable privada (solo accesible dentro del objeto)
- `method` → Controla cómo se accede y modifica el estado

### 3. Polimorfismo
Aprovecha el polimorfismo de Wollok:

```wollok
// ✓ Bueno: todos los elementos responden a la misma interfaz
floki.encontrar(castillo)
floki.encontrar(aurora)
floki.encontrar(tipa)

// ✗ Malo: usar condicionales para tipos
method encontrar(elemento) {
    if (elemento == castillo) elemento.recibeAtaque(arma.potencia())
    else if (elemento == aurora) elemento.recibeAtaque(arma.potencia())
    // ...
}
```

### 4. Inmutabilidad Cuando Sea Posible
```wollok
// ✓ Bueno: usa const para valores que no cambian
object castillo {
    const property altura = 20
}

// ✗ Malo: usar var innecesariamente
object castillo {
    var property altura = 20  // ¿realmente necesita cambiar?
}
```

### 5. Nombres Descriptivos
```wollok
// ✓ Bueno: nombres que expresan intención
method esFeliz() = valor >= valorMinimFelicidad || alturaUltimoElemEncontrado >= alturaMinimFelicidad

// ✗ Malo: nombres crípticos
method check() = valor >= 50 || altura >= 10
```

## Patrones Comunes

### Pattern: Métodos de Consulta
```wollok
// Métodos que retornan información sin cambiar estado
method potencia() = potencia
method estaCargada() = cantFlechas > 0
method esFeliz() = valor >= valorMinimFelicidad || alturaUltimoElemEncontrado >= alturaMinimFelicidad
```

### Pattern: Métodos de Acción
```wollok
// Métodos que cambian el estado del objeto
method encontrar(elemento) { 
    valor += elemento.recibeTrabajo()
    alturaUltimoElemEncontrado = elemento.altura()
}
method usar() { cantFlechas = (cantFlechas - 1).max(0) }
method recibeAtaque(nivel) { nivelDefensa = (nivelDefensa - nivel).max(0) }
method recibeTrabajo() { nivelDefensa = (nivelDefensa + bonificacionDefensa).min(defensaTope) }
```

### Pattern: Delegation
```wollok
// Delegar a componentes
object luisa {
    method aparece(elemento) { personajeActivo.encontrar(elemento) }
}
```

## Flujo de Juego

El flujo típico del juego es:

1. **Inicialización:**
   - Luisa tiene un personaje activo (floki o mario)
   - Cada personaje tiene su estado inicial

2. **Encuentro:**
   - Luisa invoca `aparece(elemento)`
   - El personaje activo ejecuta `encontrar(elemento)`
   - El elemento reacciona según su tipo

3. **Reacción del Elemento:**
   - Si es Floki: elemento recibe ataque si arma está cargada
   - Si es Mario: elemento otorga valor y Mario lo acumula

4. **Evaluación:**
   - Se puede consultar el estado de Mario (¿es feliz?)
   - Se puede cambiar el personaje activo

## Testing

### Test-Driven Development (TDD)

1. **Red:** Escribe un test que falle
2. **Green:** Implementa lo mínimo para que pase
3. **Refactor:** Mejora el código

**Formato BDD Gherkin-like:**
```wollok
// 1. RED: Test que falla
describe "Mario | Nueva funcionalidad" {
    test "Given: estado inicial | When: acción | Then: resultado esperado" {
        assert.equals(valorEsperado, mario.nuevoMetodo())
    }
}

// 2. GREEN: Implementación mínima
object mario {
    method nuevoMetodo() = valorEsperado
}

// 3. REFACTOR: (si es necesario)
```

Ver [testing.md](testing.md) para más detalles.

## Debugging

### Técnicas de Debugging

#### 1. Console.println()
```wollok
method encontrar(elemento) {
    console.println("Valor antes: " + valor)
    console.println("Valor elemento: " + elemento.recibeTrabajo())
    valor += elemento.recibeTrabajo()
    console.println("Valor después: " + valor)
}
```

#### 2. Breakpoints
- Click en el margen izquierdo del editor en VS Code
- Ejecuta en modo Debug (F5)
- Inspecciona variables en el panel de Debug

#### 3. Tests Específicos
```wollok
test "debug: verificar cálculo de valor" {
    mario.valor(0)
    mario.encontrar(castillo)
    console.println("Valor mario: " + mario.valor())
    console.println("Esperado: 30")
    assert.equals(30, mario.valor())
}
```

## Errores Comunes

### 1. Olvidar el `self`
```wollok
// ✗ Malo
object mario {
    var valor = 0
    method duplicarValor() {
        valor = valor * 2  // Error: valor no está definido
    }
}

// ✓ Bueno
object mario {
    var valor = 0
    method duplicarValor() {
        valor = self.valor() * 2
    }
}
```

### 2. No Inicializar Variables
```wollok
// ✗ Malo
object mario {
    var valor  // Error: no inicializada
}

// ✓ Bueno
object mario {
    var valor = 0
}
```

### 3. Confundir `estaCargada()` con `usar()`
```wollok
// ✗ Malo: no verificar si está cargada
method encontrar(elemento) {
    elemento.recibeAtaque(arma.potencia())
    arma.usar()  // Puede fallar si no está cargada
}

// ✓ Bueno: verificar primero
method encontrar(elemento) {
    if(arma.estaCargada()) {
        elemento.recibeAtaque(arma.potencia())
        arma.usar()
    }
}
```

### 4. Modificar Estado Compartido
```wollok
// ✗ Malo: modificar directamente afecta todos los tests posteriores
castillo.recibeAtaque(50)  // Castillo ahora tiene defensa 100

// ✓ Bueno: cada test es independiente
test "ejemplo 1" {
    castillo.recibeAtaque(50)
    assert.equals(100, castillo.nivelDefensa())
}

test "ejemplo 2" {
    // Castillo vuelve a tener defensa 150 (estado inicial)
    assert.equals(150, castillo.nivelDefensa())
}
```

## Preguntas Frecuentes

### ¿Cómo agrego un nuevo personaje?

1. Crea un nuevo objeto en `src/personajes.wlk`
2. Implementa el método `encontrar(elemento)`
3. Agrega tests en `tests/personajes.wtest`
4. Úsalo en `luisa.personajeActivo(nuevoPersonaje)`

### ¿Cómo agrego un nuevo elemento?

1. Crea un nuevo objeto en `src/elementos.wlk`
2. Implementa `altura()`, `recibeAtaque(nivel)`, `recibeTrabajo()`
3. Agrega tests en `tests/elementos.wtest`
4. Úsalo en encuentros

### ¿Cómo agrego un nuevo arma?

1. Crea un nuevo objeto en `src/armas.wlk`
2. Implementa `potencia()`, `estaCargada()`, `usar()`
3. Agrega tests en `tests/armas.wtest`
4. Asígnalo a un personaje

### ¿Puedo modificar el README.md?

No, el README.md contiene la especificación del ejercicio y no debe modificarse.

### ¿Dónde reporto bugs?

Crea un issue en el repositorio con:
- Descripción del bug
- Pasos para reproducir
- Comportamiento esperado vs actual
- Versión de Wollok

## Contacto

Si tienes preguntas o necesitas ayuda:
- Crea un issue con la etiqueta "question"
- Revisa la [Guía de Contribución](../CONTRIBUTING.md)
- Consulta el [Código de Conducta](../CODE_OF_CONDUCT.md)
