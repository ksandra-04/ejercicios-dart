# Ejercicios de programación en Dart

Taller del curso de **Desarrollo Full Stack**: 15 ejercicios de consola resueltos en **Dart** (la base de Flutter). La misma actividad se hizo antes en C# / .NET.

El objetivo es practicar los fundamentos de la **programación orientada a objetos** (clases, herencia, polimorfismo y encapsulamiento), los bucles y el trabajo con **Git y GitHub** usando ramas.

## Requisitos

- [Dart SDK](https://dart.dev/get-dart) 3.x (probado con 3.13.4).
  En Windows se puede instalar con `winget install --id Google.DartSDK -e`.
- Git, para clonar el repositorio.

## Cómo ejecutar

```bash
git clone https://github.com/ksandra-04/ejercicios-dart.git
cd ejercicios-dart/ejercicios_dart
dart run
```

Aparece un menú con los 15 ejercicios: escribe el número del que quieres probar y luego `0` para salir.

Para correr las pruebas automáticas de la clase `Fraccion`:

```bash
dart test
```

## Estructura del proyecto

```
ejercicios_dart/
├── bin/ejercicios_dart.dart   # Menú, clase abstracta Ejercicio y los 15 ejercicios
├── lib/fraccion.dart          # Clase Fraccion (encapsulamiento, operador -)
├── test/fraccion_test.dart    # Pruebas de la clase Fraccion
└── pubspec.yaml               # Configuración del proyecto
```

## Diseño orientado a objetos

- **Clase abstracta `Ejercicio`**: tiene el campo `nombre` y el método abstracto `ejecutar()`. No se puede instanciar directamente.
- **Herencia**: cada ejercicio es una clase que hace `extends Ejercicio` y llama al constructor de la base con `super('Nombre')`.
- **Polimorfismo**: el menú guarda todos los ejercicios en una `List<Ejercicio>` y llama a `ejecutar()` sin saber de qué clase concreta es cada uno; cada clase lo implementa con `@override`.
- **Encapsulamiento**: la clase `Fraccion` guarda numerador y denominador en campos privados (`_num`, `_den`) y solo expone métodos públicos (`parse`, `simplificar`, el operador `-` y `toString`).
- **Null safety**: `stdin.readLineSync()` devuelve `String?`; la entrada se valida con `int.tryParse` / `double.tryParse` y se vuelve a pedir si no es válida.

## Ejercicios

| # | Ejercicio | Qué hace | Concepto de POO / Dart |
|---|---|---|---|
| 1 | Positive Power | Eleva al cuadrado un número no negativo | Herencia (`extends`, `super`), `@override`, operador ternario |
| 2 | Double or Triple | Doble del primero si es mayor o igual; si no, triple del segundo | Condicional `>=`, formato sin `.0` |
| 3 | Root or Square | Raíz si es positivo; si no, cuadrado | `sqrt` de `dart:math` |
| 4 | Circle Perimeter | Perímetro 2·π·r con 2 decimales | Constante `pi`, `toStringAsFixed(2)` |
| 5 | Midweek Day | Día laboral (1–5) a partir de un número | Lista `static const` privada (`_dias`) |
| 6 | Tax Calculator | 15 % del salario anual que supera 12000 | Constantes de clase `static const` |
| 7 | Remainder Finder | Residuo de una división, validando el divisor 0 | Operador `%`, validación con `return` temprano |
| 8 | Sum of Evens | Suma de pares entre 1 y 50 (650) | Bucle `for`, inferencia con `var` |
| 9 | Fraction Difference | Resta de dos fracciones `a/b` simplificada | **Encapsulamiento** (`_num`, `_den`), sobrecarga del operador `-`, `gcd` |
| 10 | String Length | Longitud de una palabra | Propiedad `length` de `String` |
| 11 | Average of Four | Promedio de cuatro números | *Collection for*, `reduce` |
| 12 | Smallest of Five | Menor de cinco números | `reduce(min)`: funciones como parámetro |
| 13 | Vowel Counter | Cuenta vocales, incluidas las tildes | `split`, `where`, lectura UTF-8 en Windows |
| 14 | Factorial Finder | Factorial con bucle, validando negativos | Bucle `for`, `BigInt` para números grandes |
| 15 | InRange Validator | ¿Está entre 10 y 20 (incluidos)? | Operadores lógicos `&&`, `>=`, `<=` |

## Diferencias con C# que aparecieron

| Tema | Dart | C# |
|---|---|---|
| Llamar al constructor base | `: super('Nombre')` | `: base("Nombre")` |
| Sobrescribir métodos | `@override` (anotación opcional) | `override` obligatorio + `abstract` / `virtual` en la base |
| Privacidad | `_campo`: privado **para el archivo** | `private`: privado **para la clase** |
| Leer de consola | `stdin.readLineSync()` devuelve `String?` | `Console.ReadLine()` |
| Convertir texto a número | `int.tryParse(texto)` devuelve `int?` | `int.TryParse(texto, out n)` devuelve `bool` |
| Sobrecarga de operadores | Método de instancia `operator -(otra)` | Método estático `operator -(a, b)` |
| Números enteros en `double` | `25.0` se muestra como `25.0` (se formateó a `25`) | `25.0` se muestra como `25` |

## Ramas del desarrollo

| Rama | Contenido |
|---|---|
| `main` | Proyecto inicial, merges de cada fase y esta documentación |
| `ejercicios-1-5` | Estructura base (clase abstracta y menú) y ejercicios 1 a 5 |
| `ejercicios-6-10` | Ejercicios 6 a 10 y la clase `Fraccion` |
| `ejercicios-11-15` | Ejercicios 11 a 15 y la corrección de tildes en Windows |
