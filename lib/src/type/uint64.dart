import 'dart:typed_data';

import '../utils.dart';
import 'base_type.dart';
import 'big_num.dart';

class Uint64 extends BigNum implements BaseType {
  Uint64(BigInt value) {
    this.value = value;
  }

  @override
  BigInt get MAX => BigInt.tryParse('18446744073709551615');

  @override
  BigInt get MIN => BigInt.from(0);

  @override
  void validate() {}

  @override
  Uint8List toBytes() {
    validate();
    return BinaryUtils.transformUint64ToBytes(value);
  }
}
