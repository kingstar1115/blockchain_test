import 'dart:typed_data';

import 'package:buffer/buffer.dart';

import '../exceptions.dart';
import '../json.dart';
import '../utils.dart';
import 'account_name.dart';
import 'base_type.dart';

class BeneficiaryRouteType extends BaseType
    implements Jsonable<Map<String, Object>> {
  AccountName account;

  ///original type is uint16_t
  int weight;

  BeneficiaryRouteType(this.account, this.weight);

  BeneficiaryRouteType.empty();

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(account.toBytes());
    writer.write(BinaryUtils.transformUint16ToBytes(weight));
    return writer.toBytes();
  }

  @override
  void validate() {
    if (weight < -10000 || weight > 10000) {
      throw InvalidParameterException(
          weight, 'weight', 'Weight must be between -1000 and 10000');
    }
  }

  @override
  Map<String, Object> toJsonableObject() =>
      {"account": account.toString(), "weight": weight};
}
