import 'dart:typed_data';

import '../types.dart' show BaseType;

class BaseOperation implements BaseType {
  static int get ID => 0;

  @override
  Uint8List toBytes() {
    return null;
  }

  @override
  void validate() {}
}
