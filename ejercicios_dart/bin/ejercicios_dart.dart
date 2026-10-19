import 'dart:io';
import 'dart:math';

// ===================== Utilidades de entrada/salida =====================

// stdin.readLineSync() devuelve String? (puede ser null): con ?. y ?? se
// convierte en un String seguro antes de usarlo (null safety).
String leerTexto(String mensaje) {
  stdout.write(mensaje);
  return stdin.readLineSync()?.trim() ?? '';
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
