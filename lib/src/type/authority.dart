import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:viz_dart_ecc/viz_dart_ecc.dart';

import '../exceptions.dart';
import '../json.dart';
import '../utils.dart';
import 'account_name.dart';
import 'base_type.dart';

class Authority extends BaseType implements Jsonable<Map<String, Object>> {
  ///uint32
  int weightThreshold;

  ///Map<AccountName, weight:uint16>
  Map<AccountName, int> accountAuths;

  ///Map<VIZPublicKey, weight:uint16>
  Map<VIZPublicKey, int> keyAuths;

  Authority({this.weightThreshold, this.accountAuths, this.keyAuths}) {
    _fillOptionFields();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformUint32ToBytes(weightThreshold));

    writer.write(BinaryUtils.transformInt64ToVarIntBytes(accountAuths.length));
    for (AccountName account in accountAuths.keys) {
      writer.write(account.toBytes());
      writer.write(BinaryUtils.transformUint16ToBytes(accountAuths[account]));
    }

    writer.write(BinaryUtils.transformInt64ToVarIntBytes(keyAuths.length));
    for (VIZPublicKey key in keyAuths.keys) {
      writer.write(key.toBuffer());
      writer.write(BinaryUtils.transformUint16ToBytes(keyAuths[key]));
    }

    return writer.toBytes();
  }

  @override
  void validate() {
    _fillOptionFields();

    if (weightThreshold < 0) {
      throw InvalidParameterException(weightThreshold, 'weightThreshold',
          'weightThreshold cannont be less than zero');
    }

    int weightSum = 0;

    accountAuths.keys.forEach((account) {
      weightSum += accountAuths[account];
    });

    keyAuths.keys.forEach((key) {
      weightSum += keyAuths[key];
    });

    if (weightSum < weightThreshold) {
      throw InvalidParameterException(weightSum, 'weightSum',
          'weightSum cannont be less than weightThreshold');
    }
  }

  @override
  Map<String, Object> toJsonableObject() {
    List<List<Object>> accountAuthList = [];
    accountAuths.keys.forEach((account) {
      accountAuthList.add([account.toString(), accountAuths[account]]);
    });

    List<List<Object>> keyAuthList = [];
    keyAuths.keys.forEach((key) {
      keyAuthList.add([key.toString(), keyAuths[key]]);
    });

    return {
      'weight_threshold': weightThreshold,
      'account_auths': accountAuthList,
      'key_auths': keyAuthList
    };
  }

  void _fillOptionFields() {
    if (weightThreshold == null) {
      weightThreshold = 0;
    }

    if (keyAuths == null) {
      keyAuths = {};
    }

    if (accountAuths == null) {
      accountAuths = {};
    }
  }
}
