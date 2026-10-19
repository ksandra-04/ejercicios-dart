import 'package:ejercicios_dart/fraccion.dart';
import 'package:test/test.dart';

void main() {
  test('diferencias de la tabla del ejercicio 9', () {
    expect('${Fraccion(1, 2) - Fraccion(1, 3)}', '1/6');
    expect('${Fraccion(2, 3) - Fraccion(1, 2)}', '1/6');
    expect('${Fraccion(1, 4) - Fraccion(1, 4)}', '0');
  });

  test('simplificar y signo', () {
    expect('${Fraccion(4, 8).simplificar()}', '1/2');
    expect('${Fraccion(3, -6).simplificar()}', '-1/2');
    expect('${Fraccion(1, 3) - Fraccion(1, 2)}', '-1/6');
  });

  test('parse', () {
    expect('${Fraccion.parse(' 3 / 4 ')}', '3/4');
    expect(Fraccion.parse('abc'), isNull);
    expect(Fraccion.parse('1/0'), isNull);
  });

  test('denominador 0 lanza error', () {
    expect(() => Fraccion(1, 0), throwsArgumentError);
  });
}
