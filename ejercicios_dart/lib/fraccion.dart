/// Fracción a/b con numerador y denominador privados (encapsulamiento).
///
/// En Dart el guion bajo hace privado un miembro para todo el archivo
/// (librería), no solo para la clase como el `private` de C#. Por eso esta
/// clase vive en su propio archivo: desde bin/ no se puede leer ni cambiar
/// _num ni _den, solo usar los métodos públicos.
class Fraccion {
  final int _num;
  final int _den;

  Fraccion(int numerador, int denominador)
      : _num = numerador,
        _den = denominador {
    // assert solo se revisa en modo depuración; con dart run normal se
    // ignora, así que se valida con una excepción.
    if (denominador == 0) {
      throw ArgumentError('El denominador no puede ser 0.');
    }
  }

  /// Lee texto como "1/2". Devuelve null si el formato no es válido.
  static Fraccion? parse(String texto) {
    final partes = texto.split('/');
    if (partes.length != 2) return null;
    final n = int.tryParse(partes[0].trim());
    final d = int.tryParse(partes[1].trim());
    if (n == null || d == null || d == 0) return null;
    return Fraccion(n, d);
  }

  /// Sobrecarga del operador -: permite escribir a - b con dos fracciones.
  /// En C# sería: public static Fraccion operator -(Fraccion a, Fraccion b).
  Fraccion operator -(Fraccion otra) =>
      Fraccion(_num * otra._den - otra._num * _den, _den * otra._den)
          .simplificar();

  /// Divide entre el máximo común divisor y deja el signo en el numerador.
  Fraccion simplificar() {
    if (_num == 0) return Fraccion(0, 1);
    final g = _num.abs().gcd(_den.abs());
    final signo = _den < 0 ? -1 : 1;
    return Fraccion(signo * _num ~/ g, signo * _den ~/ g);
  }

  @override
  String toString() => _den == 1 ? '$_num' : '$_num/$_den';
}
