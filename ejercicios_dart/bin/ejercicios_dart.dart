import 'dart:io';

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

// ===================== Menú principal =====================

void main() {
  // La lista es de tipo Ejercicio (la clase base): puede guardar cualquier
  // subclase y el menú no necesita saber cuál es cada una.
  final List<Ejercicio> ejercicios = [];

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
