import 'dart:typed_data';

import '../exceptions.dart';
import '../utils.dart' show BinaryUtils;
import 'base_type.dart';

class Url extends BaseType {
  String _url;

  Url(String url) {
    this.url = url;
    validate();
  }

  set url(String str) {
    _validate(str);
    _url = str;
  }

  String get url => _url;

  @override
  Uint8List toBytes() {
    validate();
    return BinaryUtils.transformStringToVarIntBytes(url);
  }

  @override
  void validate() {
    _validate(url);
  }

  void _validate(String memo) {
    ArgumentError.checkNotNull(memo);

    if (memo.length > 1024) {
      throw InvalidParameterException(
          url.length,
          'urls.length',
          'The url is too long. '
              'Only 1024 characters are allowed.');
    }
  }

  @override
  String toString() => url;
}
