# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

## [1.0.0] - 2026-04-29

### Agregado

#### Objetos Principales

**Armas:**
- **Ballesta**: Arma con sistema de flechas
  - Flechas iniciales: 10
  - Potencia: 4
  - Métodos: `estaCargada()`, `usar()`

- **Jabalina**: Arma de un solo uso
  - Cargada inicialmente: true
  - Potencia: 30
  - Métodos: `estaCargada()`, `usar()`

**Elementos:**
- **Castillo**: Estructura defensiva
  - Altura: 20 metros (constante)
  - Defensa inicial: 150
  - Métodos: `altura()`, `nivelDefensa()`, `valor()`, `recibeAtaque(nivel)`, `recibeTrabajo()`
  - Constantes: `bonificacionDefensa` (20), `defensaTope` (200), `tasaValor` (0.2)

- **Aurora**: Vaca
  - Altura: 1 metro (constante)
  - Valor: 15 (constante)
  - Estado: viva (inicial)
  - Métodos: `altura()`, `estaViva()`, `valor()`, `recibeAtaque(nivel)`, `recibeTrabajo()`
  - Constantes: `nivelAtaqueMinimo` (10)

- **Tipa**: Árbol
  - Altura inicial: 8 metros
  - Métodos: `altura()`, `valor()`, `recibeAtaque(nivel)`, `recibeTrabajo()`
  - Constantes: `factorDeCrecimiento` (1), `multiplicadorValor` (2)

**Personajes:**
- **Floki**: Guerrero
  - Arma inicial: ballesta (intercambiable)
  - Métodos: `cambiarArma(unArma)`, `encontrar(elemento)`

- **Mario**: Trabajador
  - Valor acumulado inicial: 0
  - Métodos: `encontrar(elemento)`, `esFeliz()`
  - Constantes: `valorMinFelicidad` (50), `alturaMinFelicidad` (10)

**Jugador:**
- **Luisa**: Gestiona personajes activos
  - Personaje activo inicial: floki
  - Métodos: `cambiarPersonaje(unPersonaje)`, `aparece(elemento)`

#### Mecánicas de Juego

- **Sistema de encuentros**: Personajes interactúan con elementos
- **Sistema de ataques**: Floki ataca elementos si su arma está cargada
  - Ballesta: ataque de 4 puntos, consume una flecha
  - Jabalina: ataque de 30 puntos, se descarga después de usar
- **Sistema de trabajo**: Mario recolecta valor de elementos
  - Castillo: otorga 20% de su defensa actual
  - Aurora: otorga 15 puntos
  - Tipa: otorga el doble de su altura actual
- **Sistema de felicidad**: Mario es feliz si:
  - Ha recolectado 50 o más puntos de valor, O
  - El último elemento encontrado mide 10 o más metros
- **Sistema de defensa**: Castillo pierde defensa al recibir ataques (mínimo 0)
- **Sistema de crecimiento**: Tipa crece 1 metro al recibir trabajo

#### Tests

- **38 tests unitarios** con cobertura del 100%
- Formato BDD (Given-When-Then)
- Distribución:
  - Armas: 7 tests
  - Elementos: 21 tests
  - Personajes: 9 tests
  - Jugadores: 4 tests
- Casos límite y casos normales cubiertos

#### Documentación

- README.md con especificación completa del ejercicio
- LICENSE (ISC)
- CODE_OF_CONDUCT.md
- CONTRIBUTING.md
- CHANGELOG.md (este archivo)
- docs/index.md - Índice de documentación
- docs/architecture.md - Arquitectura del sistema
- docs/setup.md - Guía de instalación
- docs/testing.md - Guía de testing
- docs/development.md - Guía para desarrolladores

#### Configuración

- Proyecto configurado para Wollok 4.0.0+
- Estructura de carpetas: src/, tests/, docs/
- Configuración de .gitignore para archivos de log
- Formato de tests consistente con steering

### Características Técnicas

- Código limpio con nombres descriptivos
- Constantes bien nombradas para valores mágicos
- Métodos polimórficos para encuentros
- Validación de límites (defensa mínima 0, altura mínima 0)
- Evaluación de estado basada en condiciones lógicas
- Independencia de tests mediante estado inicial consistente
- Encapsulamiento de estado interno
- Delegación de responsabilidades

[1.0.0]: https://github.com/obj1-unahur-2026s1/personajes-gpolverini-unahur/releases/tag/v1.0.0
