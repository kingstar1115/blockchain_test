import 'dart:convert';
import 'dart:typed_data';

import 'package:buffer/buffer.dart';

import '../exceptions.dart';
import '../json.dart';
import '../types.dart';
import '../utils.dart';
import 'base_operatin.dart';

const MAX_ID_LENGTH = 16;

class Custom implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 10;

  List<AccountName> requiredActiveAuths;
  List<AccountName> requiredRegularAuths;
  CustomId id;
  String jsonStr;

  Custom(
      {this.requiredRegularAuths,
      this.requiredActiveAuths,
      this.id,
      this.jsonStr}) {
    _fillOptionalField();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(BinaryUtils.transformListToBytes(requiredActiveAuths));
    writer.write(BinaryUtils.transformListToBytes(requiredRegularAuths));
    writer.write(id.toBytes());
    writer.write(BinaryUtils.transformStringToVarIntBytes(jsonStr));
    return writer.toBytes();
  }

  @override
  void validate() {
    _fillOptionalField();
    _checkNulls();

    if (requiredRegularAuths.length + requiredActiveAuths.length == 0) {
      throw InvalidParameterException(0, 'auths length',
          'requiredRegularAuths or requiredActiveAuths at least must be specified');
    }

    try {
      json.decode(jsonStr);
    } on FormatException {
      throw InvalidParameterException(
          jsonStr, 'jsonStr', 'The json string invalid');
    }
  }

  void _fillOptionalField() {
    if (requiredActiveAuths == null) {
      requiredActiveAuths = [];
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(
        requiredRegularAuths, 'requiredActiveAuths');
    InvalidParameterException.checkNotNull(id, 'id');
    InvalidParameterException.checkNotNull(jsonStr, 'jsonStr');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'required_active_auths': JsonSerializer.serializes(requiredActiveAuths),
      'required_regular_auths': JsonSerializer.serializes(requiredRegularAuths),
      'id': id.toString(),
      'json': jsonStr
    };

    List<Object> operation = ['custom'];
    operation.add(params);

    return operation;
  }
}
