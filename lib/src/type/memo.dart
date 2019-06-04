import 'dart:typed_data';

import '../exceptions.dart';
import '../utils.dart' show BinaryUtils;
import 'base_type.dart';

class Memo extends BaseType {
  String _memo;

  Memo(String memo) {
    this.memo = memo;
    validate();
  }

  set memo(String str) {
    _validate(str);
    _memo = str;
  }

  String get memo => _memo;

  @override
  Uint8List toBytes() {
    validate();
    return BinaryUtils.transformStringToVarIntBytes(memo);
  }

  @override
  void validate() {
    _validate(memo);
  }

  void _validate(String memo) {
    ArgumentError.checkNotNull(memo);

    if (memo.length > 1024) {
      throw InvalidParameterException(
          memo.length,
          'memo.length',
          'The memo is too long. '
              'Only 1024 characters are allowed.');
    }
  }

  @override
  String toString() => memo;
}
