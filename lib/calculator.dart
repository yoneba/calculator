import 'operation.dart' as operation;

class InvalidExpressionException implements Exception {
  final String message;
  const InvalidExpressionException(this.message);

  @override
  String toString() => message;
}

String normalize(String rawExpression) {
  return rawExpression
      .replaceAll('０', '0')
      .replaceAll('１', '1')
      .replaceAll('２', '2')
      .replaceAll('３', '3')
      .replaceAll('４', '4')
      .replaceAll('５', '5')
      .replaceAll('６', '6')
      .replaceAll('７', '7')
      .replaceAll('８', '8')
      .replaceAll('９', '9')
      .replaceAll('．', '.')
      .replaceAll('（', '(')
      .replaceAll('×', '*')
      .replaceAll('÷', '/')
      .replaceAll('＋', '+')
      .replaceAll('―', '-')
      .replaceAll('ー', '-')
      .replaceAll('－', '-')
      .replaceAll('）', ')')
      .replaceAll(' ', '')
      .replaceAll('　', '');
}

String? extractNumeral(String expression) {
  return RegExp(r'^-?(0|[1-9]\d*)(\.\d+)?').stringMatch(expression);
}

String? extractOperator(String expression) {
  return RegExp(r'^\+|\-|\*|\/').stringMatch(expression);
}

double evaluate(String rawExpression) {
  final expression = normalize(rawExpression);
  var position = 0;
  List<double> numeralStack = [];
  List<String> symbolStack = [];
  while (true) {
    while (position < expression.length && expression[position] == '(') {
      symbolStack.add('(');
      position += 1;
    }
    if (position >= expression.length) {
      throw InvalidExpressionException(
          'Unexpectedly reached the end of the input.');
    }
    final numeral = extractNumeral(expression.substring(position));
    if (numeral == null) {
      throw InvalidExpressionException(
          'Expected a valid numerical expression at position $position');
    }
    numeralStack.add(double.parse(numeral));
    position += numeral.length;
    while (position < expression.length && expression[position] == ')') {
      while (symbolStack.isNotEmpty && symbolStack.last != '(') {
        operation.executeOnStack(numeralStack, symbolStack.removeLast());
      }
      if (symbolStack.isEmpty) {
        throw InvalidExpressionException(
            'Could not find the left parenthesis corresponding to the right one at position $position');
      }
      symbolStack.removeLast();
      position += 1;
    }
    if (position >= expression.length) break;
    final operator = extractOperator(expression.substring(position));
    if (operator == null) {
      throw InvalidExpressionException(
          'Expected a valid symbol character at position $position');
    }
    while (symbolStack.isNotEmpty &&
        symbolStack.last != '(' &&
        operation.precedence[symbolStack.last]! <=
            operation.precedence[operator]!) {
      operation.executeOnStack(numeralStack, symbolStack.removeLast());
    }
    symbolStack.add(operator);
    position += operator.length;
  }
  while (symbolStack.isNotEmpty) {
    if (symbolStack.last == '(') {
      throw InvalidExpressionException(
          'Unexpectedly reached the end of the input.');
    }
    operation.executeOnStack(numeralStack, symbolStack.removeLast());
  }
  return numeralStack.single;
}
