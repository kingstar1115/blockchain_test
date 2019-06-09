import 'dart:typed_data';

import 'package:buffer/buffer.dart';

import '../types.dart' show BaseType;

class BaseOperation implements BaseType {
  @override
  Uint8List toBytes() {
    return null;
  }

  @override
  void validate() {}
}
