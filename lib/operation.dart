const precedence = {'+': 2, '-': 2, '*': 1, '/': 1};

double apply(double firstOperand, double secondOperand, String operator) {
  switch (operator) {
    case '+':
      return firstOperand + secondOperand;
    case '-':
      return firstOperand - secondOperand;
    case '*':
      return firstOperand * secondOperand;
    case '/':
      return firstOperand / secondOperand;
    default:
      throw UnsupportedError('Unrecognizable operator type.');
  }
}

void executeOnStack(List<double> numeralStack, String operator) {
  final secondOperand = numeralStack.removeLast();
  final firstOperand = numeralStack.removeLast();
  numeralStack.add(apply(firstOperand, secondOperand, operator));
}
