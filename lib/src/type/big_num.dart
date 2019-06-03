abstract class BigNum {
  BigInt _value;

  BigInt get MAX;
  BigInt get MIN;

  set value(BigInt bigInt) {
    checkOverflowAndThrowExceptionIfError(bigInt);
    _value = bigInt;
  }

  BigInt get value => _value;

  void checkOverflowAndThrowExceptionIfError(BigInt value) {
    if (value > MAX || value < MIN) {
      throw ArgumentError.value(
          value,
          '',
          'Invalid value $value. '
              'A ${this.runtimeType.toString()} must be between $MIN and $MAX');
    }
  }

  @override
  String toString() => value.toString();
}
