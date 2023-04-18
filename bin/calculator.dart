import 'package:calculator/calculator.dart' as calculator;
import 'dart:io';

void main(List<String> arguments) {
  while (true) {
    try {
      stdout.write('Enter an expression: ');
      final rawExpression = stdin.readLineSync();
      if (rawExpression == null) break;
      final result = calculator.evaluate(rawExpression);
      stdout.writeln(result);
    } on calculator.InvalidExpressionException catch (e) {
      stderr.writeln(e.toString());
    }
  }
}
