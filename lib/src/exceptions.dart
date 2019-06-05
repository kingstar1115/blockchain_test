class InvalidParameterException implements Exception {
  final String message;
  final String parameterName;
  final Object value;

  InvalidParameterException(this.value, [this.parameterName, this.message]);

  static void checkNotNull(Object value, [String parameterName]) {
    if (value == null) {
      throw InvalidParameterException(
          value, parameterName, 'value can\'t be null');
    }
  }

  ///Returns a message like "Invalid parameter($parameterName) = $value: $message"
  @override
  String toString() {
    String res = 'Invalid parameter';

    res += parameterName != null ? '($parameterName)' : '';
    res += ' = $value';
    res += message != null ? ': $message' : '';

    return res;
  }
}
