# Guía de Testing

## Estrategia de Testing

El proyecto utiliza el framework de testing de Wollok para garantizar la correctitud del código. Los tests están organizados por módulo y cubren tanto casos normales como casos límite.

## Estructura de Tests

```
tests/
├── armas.wtest        # Tests unitarios de armas
├── elementos.wtest    # Tests unitarios de elementos
├── personajes.wtest   # Tests unitarios de personajes
└── jugadores.wtest    # Tests unitarios de jugadores
```

## Ejecutar Tests

### Todos los tests
```bash
# Desde VS Code: Abre la paleta de comandos
# Ctrl+Shift+P (Windows/Linux) o Cmd+Shift+P (Mac)
# Busca: "Wollok: Run All Tests"

# O desde la terminal con Wollok CLI (si está instalado):
wollok test
```

### Test individual
```bash
# Desde VS Code: 
# - Abre el archivo .wtest
# - Click en el ícono "Run Test" que aparece sobre cada test
# - O click derecho en el archivo → "Run Wollok File"

# Desde la terminal:
wollok test tests/armas.wtest
```

## Cobertura de Tests

### Total: 38 tests unitarios con 100% de cobertura

**Armas (7 tests):**
- Ballesta Inicialización: 2 tests
- Ballesta Uso: 2 tests
- Jabalina Inicialización: 2 tests
- Jabalina Uso: 1 test

**Elementos (21 tests):**
- Castillo Inicialización: 1 test
- Castillo Valor: 1 test
- Castillo Ataques: 2 tests
- Castillo Trabajo: 2 tests
- Aurora Inicialización: 1 test
- Aurora Valor: 1 test
- Aurora Ataques: 3 tests
- Aurora Trabajo: 1 test
- Tipa Inicialización: 1 test
- Tipa Valor: 2 tests
- Tipa Ataques: 1 test
- Tipa Trabajo: 2 tests
- Tipa Crecimiento: 1 test

**Personajes (9 tests):**
- Floki Encuentro: 3 tests
- Mario Trabajo: 1 test
- Mario Felicidad: 4 tests
- Floki Uso de arma: 1 test

**Jugadores (4 tests):**
- Luisa Encuentro con Floki: 1 test
- Luisa Encuentro con Mario: 1 test
- Luisa Múltiples apariciones: 1 test
- Luisa Personaje activo inicial: 1 test

## Formato de Tests: BDD (Given-When-Then)

Los tests siguen la estructura Given-When-Then para mayor claridad:

```wollok
describe "Componente | Contexto o funcionalidad" {
    test "Given: estado inicial | When: acción | Then: resultado esperado" {
        // Arrange (preparar estado)
        // Act (realizar acción)
        // Assert (verificar resultado)
        assert.that(condicion)
    }
}
```

**Ventajas:**
- Legible como especificación
- Comunica claramente qué se prueba
- Sirve como documentación viva
- Estándar en la industria

## Buenas Prácticas de Testing

### 1. Nombres Descriptivos
Los nombres de los tests deben describir claramente qué se está probando:

✓ **Bueno:**
```wollok
test "Given: Floki con ballesta cargada | When: encuentra castillo | Then: castillo debería recibir daño" {
    assert.that(castillo.nivelDefensa() < defensaAntes)
}
```

✗ **Malo:**
```wollok
test "test1" {
    assert.that(castillo.nivelDefensa() < defensaAntes)
}
```

### 2. Arrange-Act-Assert (AAA)
Organiza tus tests en tres secciones:

```wollok
test "Given: Mario | When: encuentra castillo | Then: debería acumular valor" {
    // Arrange (preparar)
    mario.valor(0)
    
    // Act (actuar)
    mario.encontrar(castillo)
    
    // Assert (verificar)
    assert.that(mario.valor() > 0)
}
```

### 3. Tests Independientes
Cada test debe ser independiente. Usa setters para establecer estado inicial:

```wollok
test "Given: Castillo con defensa 190 | When: recibe trabajo | Then: no debería superar 200" {
    castillo.nivelDefensa(190)
    castillo.recibeTrabajo()
    assert.equals(200, castillo.nivelDefensa())
}
```

### 4. Casos Límite
Siempre prueba casos límite:

```wollok
test "Given: Ballesta | When: usamos 10 veces | Then: debería quedar descargada" {
    10.times { _ => ballesta.usar() }
    assert.notThat(ballesta.estaCargada())
}

test "Given: Aurora viva | When: recibe ataque de 9 | Then: debería seguir viva" {
    aurora.recibeAtaque(9)
    assert.that(aurora.estaViva())
}
```

## Debugging de Tests

### Test Falla Inesperadamente

1. **Lee el mensaje de error:**
   ```
   Expected: 200
   But was: 190
   ```

2. **Verifica el estado:**
   ```wollok
   test "debug ejemplo" {
       castillo.nivelDefensa(190)
       castillo.recibeTrabajo()
       console.println("Defensa: " + castillo.nivelDefensa())
       assert.equals(200, castillo.nivelDefensa())
   }
   ```

3. **Simplifica el test:**
   - Reduce el test al mínimo necesario
   - Verifica una cosa a la vez

### Test Pasa Pero No Debería

- Verifica que estás usando `assert.that()` y no `assert.notThat()`
- Asegúrate de que el test realmente ejecuta la lógica esperada
- Revisa que no haya typos en los nombres de métodos

## Agregar Nuevos Tests

Cuando agregues nueva funcionalidad, sigue estos pasos:

1. **Escribe el test primero (TDD):**
   ```wollok
   test "nueva funcionalidad" {
       // Test que falla porque la funcionalidad no existe
   }
   ```

2. **Implementa la funcionalidad mínima:**
   - Haz que el test pase

3. **Refactoriza:**
   - Mejora el código manteniendo los tests en verde

4. **Agrega más tests:**
   - Casos límite
   - Casos de error
   - Diferentes escenarios

## Recursos Adicionales

- [Documentación oficial de Wollok Testing](https://www.wollok.org/documentacion/testing/)
- [Guía de TDD](https://www.wollok.org/documentacion/tdd/)
- Ver [architecture.md](architecture.md) para entender la estructura del código
- Ver [setup.md](setup.md) para instrucciones de instalación
