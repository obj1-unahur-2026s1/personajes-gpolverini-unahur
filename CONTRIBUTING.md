# Guía de Contribución

¡Gracias por tu interés en contribuir a "Juego con personajes y elementos"! Este documento proporciona directrices e instrucciones para contribuir al proyecto.

## Código de Conducta

Este proyecto se adhiere a un Código de Conducta. Al participar, se espera que respetes este código. Por favor lee [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) para más detalles.

## ¿Cómo puedo contribuir?

### Reportar Bugs

Si encuentras un bug, por favor crea un issue incluyendo:

- Una descripción clara del problema
- Pasos para reproducir el comportamiento
- Comportamiento esperado vs. comportamiento actual
- Capturas de pantalla si son relevantes
- Versión de Wollok que estás usando

### Sugerir Mejoras

Las sugerencias de mejoras son bienvenidas. Por favor crea un issue describiendo:

- La mejora propuesta
- Por qué sería útil
- Ejemplos de uso si es aplicable

### Pull Requests

1. **Fork el repositorio** y crea tu rama desde `main`
2. **Escribe código claro** siguiendo las convenciones del proyecto
3. **Agrega tests** si es aplicable
4. **Asegúrate de que los tests pasen** antes de enviar el PR
5. **Actualiza la documentación** si es necesario
6. **Escribe mensajes de commit claros** y descriptivos

#### Proceso de Pull Request

1. Asegúrate de que tu código sigue las convenciones de estilo de Wollok
2. Actualiza el README.md si agregas funcionalidad que lo requiera
3. Los tests deben pasar exitosamente
4. El PR será revisado por los mantenedores del proyecto

### Convenciones de Código

- Usa nombres descriptivos para variables y métodos
- Escribe comentarios cuando el código no sea auto-explicativo
- Sigue las convenciones de nomenclatura de Wollok
- Mantén los métodos pequeños y enfocados en una sola responsabilidad
- Usa constantes para valores mágicos

### Estructura del Proyecto

```
juego-personajes-elementos/
├── src/                    # Código fuente principal
│   ├── armas.wlk          # Definición de armas (ballesta, jabalina)
│   ├── elementos.wlk      # Definición de elementos (castillo, aurora, tipa)
│   ├── personajes.wlk     # Definición de personajes (floki, mario)
│   ├── jugadores.wlk      # Definición de jugadores (luisa)
│   └── juego.wpgm         # Programa principal del juego
├── tests/                  # Tests unitarios
│   ├── armas.wtest        # Tests para armas
│   ├── elementos.wtest    # Tests para elementos
│   ├── personajes.wtest   # Tests para personajes
│   ├── jugadores.wtest    # Tests para jugadores
│   └── testExample.wtest  # Ejemplo de test
├── docs/                   # Documentación del proyecto
│   ├── index.md           # Índice de documentación
│   ├── setup.md           # Guía de configuración
│   ├── development.md     # Guía de desarrollo
│   ├── testing.md         # Guía de testing
│   └── architecture.md    # Arquitectura del proyecto
├── log/                    # Archivos de log (ignorados en git)
├── .gitignore             # Archivos ignorados por git
├── package.json           # Configuración del proyecto
├── README.md              # Documentación principal del ejercicio
├── CONTRIBUTING.md        # Esta guía
├── CODE_OF_CONDUCT.md     # Código de conducta
├── CHANGELOG.md           # Historial de cambios
└── LICENSE                # Licencia ISC

```

#### Descripción de módulos:

**src/armas.wlk**
- `ballesta`: Arma con 10 flechas, potencia 4, se descarga al usar
- `jabalina`: Arma de un solo uso, potencia 30

**src/elementos.wlk**
- `castillo`: Elemento defensivo, altura 20, defensa inicial 150
- `aurora`: Vaca, altura 1, muere con ataque ≥10
- `tipa`: Árbol, altura inicial 8, crece con trabajo

**src/personajes.wlk**
- `floki`: Guerrero que ataca con armas
- `mario`: Trabajador que recolecta valor

**src/jugadores.wlk**
- `luisa`: Jugadora que maneja personajes activos

### Tests

Todos los cambios deben incluir tests apropiados. Para ejecutar los tests:

```bash
# Desde VS Code: Abre la paleta de comandos
# Ctrl+Shift+P (Windows/Linux) o Cmd+Shift+P (Mac)
# Busca: "Wollok: Run All Tests"
```

### Mensajes de Commit

- Usa el tiempo presente ("Agrega feature" no "Agregado feature")
- Usa el modo imperativo ("Mueve cursor a..." no "Mueve cursor a...")
- Limita la primera línea a 72 caracteres o menos
- Referencia issues y pull requests cuando sea relevante

Ejemplo:
```
Agrega método para cambiar arma de personaje

- Implementa setter de arma en floki
- Agrega tests para cambio de arma
- Fixes #123
```

## Preguntas

Si tienes preguntas sobre cómo contribuir, no dudes en crear un issue con la etiqueta "question".

## Licencia

Al contribuir a este proyecto, aceptas que tus contribuciones serán licenciadas bajo la licencia ISC del proyecto.
