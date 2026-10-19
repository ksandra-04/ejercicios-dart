import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ejercicios_dart/fraccion.dart';

// ===================== Utilidades de entrada/salida =====================

// stdin.readLineSync() devuelve String? (puede ser null): con ?. y ?? se
// convierte en un String seguro antes de usarlo (null safety).
//
// En Windows, Dart decodifica la entrada con la codificación del sistema
// (Windows-1252), pero terminales como Git Bash envían UTF-8 y las tildes
// llegaban dañadas ("É" -> "Ã‰"). Se leen los bytes tal cual (latin1 no los
// altera), se intenta UTF-8 y, si no es válido, se usa la del sistema.
String leerTexto(String mensaje) {
  stdout.write(mensaje);
  final linea = stdin.readLineSync(encoding: latin1);
  if (linea == null) return '';
  final bytes = latin1.encode(linea);
  try {
    return utf8.decode(bytes).trim();
  } on FormatException {
    return systemEncoding.decode(bytes).trim();
  }
}

// tryParse devuelve null si el texto no es un número, así que se repite
// la pregunta hasta obtener un valor válido.
double leerNumero(String mensaje) {
  while (true) {
    final valor = double.tryParse(leerTexto(mensaje).replaceAll(',', '.'));
    if (valor != null) return valor;
    print('Valor no válido, intenta de nuevo.');
  }
}

int leerEntero(String mensaje) {
  while (true) {
    final valor = int.tryParse(leerTexto(mensaje));
    if (valor != null) return valor;
    print('Debes ingresar un número entero.');
  }
}

/// Muestra 25 en vez de 25.0 y 1.5 en vez de 1.50
String fmt(num n) {
  if (n == n.roundToDouble()) return n.toInt().toString();
  return n
      .toStringAsFixed(4)
      .replaceAll(RegExp(r'0+$'), '')
      .replaceAll(RegExp(r'\.$'), '');
}

// ===================== Clase base (abstracción + herencia) =====================

abstract class Ejercicio {
  final String nombre;
  Ejercicio(this.nombre);

  /// Cada ejercicio implementa su propia lógica (polimorfismo).
  void ejecutar();
}

// 1. Positive Power
// extends = herencia; super(...) llama al constructor de Ejercicio
// (equivale a ": base(...)" en C#).
class PositivePower extends Ejercicio {
  PositivePower() : super('Positive Power');

  // @override es una anotación opcional, pero avisa si el método no existe
  // en la clase base. En C# se usa la palabra clave override.
  @override
  void ejecutar() {
    final n = leerNumero('Ingresa un número: ');
    print(n < 0 ? 'Número negativo.' : 'Resultado: ${fmt(n * n)}');
  }
}

// 2. Double or Triple
class DoubleOrTriple extends Ejercicio {
  DoubleOrTriple() : super('Double or Triple');

  @override
  void ejecutar() {
    final a = leerNumero('Primer número: ');
    final b = leerNumero('Segundo número: ');
    // Si son iguales (6, 6) el ejemplo da 12, es decir, el doble del primero.
    final resultado = a >= b ? a * 2 : b * 3;
    print('Resultado: ${fmt(resultado)}');
  }
}

// 3. Root or Square
class RootOrSquare extends Ejercicio {
  RootOrSquare() : super('Root or Square');

  @override
  void ejecutar() {
    final n = leerNumero('Ingresa un número: ');
    // sqrt viene de dart:math; en C# sería Math.Sqrt.
    final resultado = n > 0 ? sqrt(n) : n * n;
    print('Resultado: ${fmt(resultado)}');
  }
}

// 4. Circle Perimeter
class CirclePerimeter extends Ejercicio {
  CirclePerimeter() : super('Circle Perimeter');

  @override
  void ejecutar() {
    final r = leerNumero('Radio del círculo: ');
    print('Resultado: ${(2 * pi * r).toStringAsFixed(2)}');
  }
}

// 5. Midweek Day
class MidweekDay extends Ejercicio {
  MidweekDay() : super('Midweek Day');

  // El guion bajo hace privada la lista. En Dart la privacidad es por
  // archivo (librería), no por clase como el private de C#.
  static const _dias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'];

  @override
  void ejecutar() {
    final n = leerEntero('Número entre 1 y 7: ');
    if (n >= 1 && n <= 5) {
      print('Resultado: ${_dias[n - 1]}');
    } else {
      print('Número fuera del rango laboral.');
    }
  }
}

// 6. Tax Calculator
class TaxCalculator extends Ejercicio {
  TaxCalculator() : super('Tax Calculator');

  // static const: constantes de la clase, conocidas en tiempo de compilación.
  static const double limite = 12000;
  static const double tasa = 0.15;

  @override
  void ejecutar() {
    final salario = leerNumero('Salario anual: ');
    if (salario > limite) {
      print('Impuesto a pagar: ${fmt((salario - limite) * tasa)}');
    } else {
      print('No debe impuestos.');
    }
  }
}

// 7. Remainder Finder
class RemainderFinder extends Ejercicio {
  RemainderFinder() : super('Remainder Finder');

  @override
  void ejecutar() {
    final a = leerEntero('Dividendo: ');
    final b = leerEntero('Divisor: ');
    // En Dart, % entre enteros con divisor 0 lanza una excepción: se valida antes.
    if (b == 0) {
      print('No se puede dividir entre cero.');
      return;
    }
    print('Resultado: ${a % b}');
  }
}

// 8. Sum of Evens
class SumOfEvens extends Ejercicio {
  SumOfEvens() : super('Sum of Evens');

  @override
  void ejecutar() {
    // var infiere el tipo (int), como var en C#.
    var suma = 0;
    for (var i = 2; i <= 50; i += 2) {
      suma += i;
    }
    print('Suma de pares entre 1 y 50: $suma');
  }
}

// 9. Fraction Difference (usa la clase Fraccion de lib/fraccion.dart)
class FractionDifference extends Ejercicio {
  FractionDifference() : super('Fraction Difference');

  Fraccion _leer(String mensaje) {
    while (true) {
      final f = Fraccion.parse(leerTexto(mensaje));
      if (f != null) return f;
      print('Formato no válido. Usa por ejemplo 1/2');
    }
  }

  @override
  void ejecutar() {
    final a = _leer('Primera fracción (ej. 1/2): ');
    final b = _leer('Segunda fracción (ej. 1/3): ');
    // a - b llama al operador sobrecargado de Fraccion.
    print('Resultado: ${a - b}');
  }
}

// 10. String Length
class StringLength extends Ejercicio {
  StringLength() : super('String Length');

  @override
  void ejecutar() {
    final palabra = leerTexto('Ingresa una palabra: ');
    // length es una propiedad (sin paréntesis), igual que Length en C#.
    print('Resultado: ${palabra.length}');
  }
}

// 11. Average of Four
class AverageOfFour extends Ejercicio {
  AverageOfFour() : super('Average of Four');

  @override
  void ejecutar() {
    // "collection for": el bucle va dentro de la lista y la llena.
    // En C# se haría con un for y List.Add, o con LINQ.
    final numeros = [
      for (var i = 1; i <= 4; i++) leerNumero('Número $i: '),
    ];
    // reduce combina los elementos de dos en dos (como Aggregate en LINQ).
    final promedio = numeros.reduce((a, b) => a + b) / numeros.length;
    print('Resultado: ${fmt(promedio)}');
  }
}

// 12. Smallest of Five
class SmallestOfFive extends Ejercicio {
  SmallestOfFive() : super('Smallest of Five');

  @override
  void ejecutar() {
    final numeros = [
      for (var i = 1; i <= 5; i++) leerNumero('Número $i: '),
    ];
    // min (de dart:math) se pasa como función: devuelve el menor de dos.
    print('Resultado: ${fmt(numeros.reduce(min))}');
  }
}

// 13. Vowel Counter
class VowelCounter extends Ejercicio {
  VowelCounter() : super('Vowel Counter');

  // Incluye vocales con tilde y diéresis.
  static const _vocales = 'aeiouáéíóúü';

  @override
  void ejecutar() {
    final palabra = leerTexto('Ingresa una palabra: ').toLowerCase();
    // split('') separa la palabra en letras; where filtra (como Where en LINQ).
    final cantidad =
        palabra.split('').where((c) => _vocales.contains(c)).length;
    print('Resultado: $cantidad');
  }
}

// 14. Factorial Finder
class FactorialFinder extends Ejercicio {
  FactorialFinder() : super('Factorial Finder');

  // BigInt evita el desbordamiento: un int de 64 bits solo llega hasta 20!.
  BigInt factorial(int n) {
    var resultado = BigInt.one;
    for (var i = 2; i <= n; i++) {
      resultado *= BigInt.from(i);
    }
    return resultado;
  }

  @override
  void ejecutar() {
    final n = leerEntero('Ingresa un número: ');
    if (n < 0) {
      print('No existe el factorial de un número negativo.');
      return;
    }
    print('Resultado: ${factorial(n)}');
  }
}

// 15. InRange Validator
class InRangeValidator extends Ejercicio {
  InRangeValidator() : super('InRange Validator');

  @override
  void ejecutar() {
    final n = leerNumero('Ingresa un número: ');
    // Ambos extremos incluidos: >= y <=.
    print(n >= 10 && n <= 20 ? 'Está en el rango.' : 'Fuera del rango.');
  }
}

// ===================== Menú principal =====================

void main() {
  // La lista es de tipo Ejercicio (la clase base): puede guardar cualquier
  // subclase y el menú no necesita saber cuál es cada una.
  final List<Ejercicio> ejercicios = [
    PositivePower(),
    DoubleOrTriple(),
    RootOrSquare(),
    CirclePerimeter(),
    MidweekDay(),
    TaxCalculator(),
    RemainderFinder(),
    SumOfEvens(),
    FractionDifference(),
    StringLength(),
    AverageOfFour(),
    SmallestOfFive(),
    VowelCounter(),
    FactorialFinder(),
    InRangeValidator(),
  ];

  while (true) {
    print('\n===== EJERCICIOS DART =====');
    for (var i = 0; i < ejercicios.length; i++) {
      print('${i + 1}. ${ejercicios[i].nombre}');
    }
    print('0. Salir');

    final opcion = leerEntero('Elige una opción: ');
    if (opcion == 0) break;
    if (opcion < 1 || opcion > ejercicios.length) {
      print('Opción no válida.');
      continue;
    }

    final ejercicio = ejercicios[opcion - 1];
    print('\n--- ${ejercicio.nombre} ---');
    ejercicio.ejecutar(); // polimorfismo: cada clase responde a su manera
  }
  print('¡Hasta luego!');
}
