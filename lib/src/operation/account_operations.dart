import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:viz_dart_ecc/viz_dart_ecc.dart';

import '../exceptions.dart';
import '../json.dart';
import '../types.dart';
import '../utils.dart';
import 'base_operatin.dart';

class AccountUpdate implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 5;

  AccountName account;
  Authority master;
  Authority active;
  Authority regular;
  VIZPublicKey memoKey;
  String jsonMetadata;

  AccountUpdate(
      {this.account,
      this.master,
      this.active,
      this.regular,
      this.memoKey,
      this.jsonMetadata}) {
    _fillOptionalField();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(account.toBytes());

    if (master != null) {
      writer.writeUint8(1);
      writer.write(master.toBytes());
    } else {
      writer.writeUint8(0);
    }

    if (active != null) {
      writer.writeUint8(1);
      writer.write(active.toBytes());
    } else {
      writer.writeUint8(0);
    }

    if (regular != null) {
      writer.writeUint8(1);
      writer.write(regular.toBytes());
    } else {
      writer.writeUint8(0);
    }

    writer.write(memoKey.toBuffer());
    writer.write(BinaryUtils.transformStringToVarIntBytes(jsonMetadata));
    return writer.toBytes();
  }

  @override
  void validate() {
    _fillOptionalField();
    _checkNulls();

    if (!JsonUtils.isJson(jsonMetadata)) {
      throw InvalidParameterException(
          jsonMetadata, 'jsonMetadata', 'The json string is invalid');
    }
  }

  void _fillOptionalField() {}

  void _checkNulls() {
    InvalidParameterException.checkNotNull(account, 'account');
    InvalidParameterException.checkNotNull(jsonMetadata, 'jsonMetadata');
    InvalidParameterException.checkNotNull(memoKey, 'memoKey');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'account': account.toString(),
      'master': master.toJsonableObject(),
      'active': active.toJsonableObject(),
      'regular': regular.toJsonableObject(),
      'memo_key': memoKey.toString(),
      'json_metadata': jsonMetadata
    };

    List<Object> operation = ['account_update'];
    operation.add(params);

    return operation;
  }
}
