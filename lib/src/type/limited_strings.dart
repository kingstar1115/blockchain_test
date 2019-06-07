import 'dart:typed_data';

import 'package:meta/meta.dart';

import '../exceptions.dart';
import '../utils.dart' show BinaryUtils;
import 'base_type.dart';

abstract class LimitedString extends BaseType {
  int _max_length;

  String value;

  LimitedString(this.value, this._max_length) {
    validate();
  }

  @protected
  String get strName;

  @override
  Uint8List toBytes() {
    validate();
    return BinaryUtils.transformStringToVarIntBytes(value);
  }

  @override
  void validate() {
    ArgumentError.checkNotNull(value);

    if (value.length > _max_length) {
      throw InvalidParameterException(
          value.length,
          '$strName.length',
          'The $strName is too long. '
              'Only $_max_length characters are allowed.');
    }
  }

  @override
  String toString() => value;
}

class Memo extends LimitedString {
  static const MAX_LENGTH = 1024;

  Memo(String memo) : super(memo, MAX_LENGTH);

  @override
  String get strName => 'memo';
}

class MemoUrl extends Memo {
  MemoUrl(String url) : super(url);

  @override
  String get strName => 'MemoUrl';
}

class MiniUrl extends LimitedString {
  static const MAX_LENGTH = 128;

  MiniUrl(String url) : super(url, MAX_LENGTH);

  @override
  String get strName => 'MiniUrl';
}

class CustomId extends LimitedString {
  static const MAX_LENGTH = 16;

  CustomId(String customId) : super(customId, MAX_LENGTH);

  @override
  String get strName => 'customId';
}
