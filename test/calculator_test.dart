import 'package:calculator/calculator.dart' as calculator;
import 'package:test/test.dart';

void main() {
  test('calculator.evaluate', () {
    expect(calculator.evaluate('1+2'), 3);
    expect(calculator.evaluate('1.2 - 2.9'), -1.7);
    expect(calculator.evaluate('2 * 5 - 7 + 6 + 9 ÷ 3'), 12);
    expect(calculator.evaluate('((-2 * (5 - (7 - 9)) + 8) / 3)'), -2);
    expect(calculator.evaluate('（（－２．０　×　（５．５　－　（７　ー　９））　＋　６）　÷　３）'), -3);
  });
}
