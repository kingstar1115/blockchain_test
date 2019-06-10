import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:viz_dart_ecc/viz_dart_ecc.dart';

import '../exceptions.dart';
import '../json.dart';
import '../types.dart';
import '../utils.dart';
import 'base_operatin.dart';

class WitnessUpdate implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 6;

  AccountName owner;
  MemoUrl url;
  VIZPublicKey key;

  WitnessUpdate({this.owner, this.url, this.key});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(owner.toBytes());
    writer.write(url.toBytes());
    writer.write(key.toBuffer());
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(owner, 'owner');
    InvalidParameterException.checkNotNull(url, 'url');
    InvalidParameterException.checkNotNull(key, 'key');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'owner': owner.toString(),
      'url': url.toString(),
      'block_signing_key': key.toString()
    };

    List<Object> operation = ['witness_update'];
    operation.add(params);

    return operation;
  }
}

class AccountWitnessVote implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 7;

  AccountName account;
  AccountName witness;
  bool approve;

  AccountWitnessVote({this.account, this.witness, this.approve}) {
    _fillOptionalField();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(account.toBytes());
    writer.write(witness.toBytes());
    writer.writeUint8(approve ? 1 : 0);
    return writer.toBytes();
  }

  @override
  void validate() {
    _fillOptionalField();
    _checkNulls();
  }

  void _fillOptionalField() {
    if (approve == null) {
      approve = true;
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(account, 'account');
    InvalidParameterException.checkNotNull(witness, 'witness');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'account': account.toString(),
      'witness': witness.toString(),
      'approve': approve
    };

    List<Object> operation = ['account_witness_vote'];
    operation.add(params);

    return operation;
  }
}

class AccountWitnessProxy implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 8;

  AccountName account;
  AccountName proxy;

  AccountWitnessProxy({this.account, this.proxy});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(account.toBytes());
    writer.write(proxy.toBytes());
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(account, 'account');
    InvalidParameterException.checkNotNull(proxy, 'proxy');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'account': account.toString(),
      'proxy': proxy.toString()
    };

    List<Object> operation = ['account_witness_proxy'];
    operation.add(params);

    return operation;
  }
}

//class VersionedChainPropertiesUpdate implements BaseOperation, Jsonable<List<Object>> {
//
//  static const ID = 46;
//
//  AccountName owner;
//
//  VersionedChainPropertiesUpdate() {
//    _fillOptionalField();
//  }
//
//  @override
//  Uint8List toBytes() {
//    validate();
//    ByteDataWriter writer = ByteDataWriter();
//    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
//    return writer.toBytes();
//  }
//
//  @override
//  void validate() {
//    _fillOptionalField();
//    _checkNulls();
//  }
//
//  void _fillOptionalField() {
//  }
//
//  void _checkNulls() {
//  }
//
//  @override
//  List<Object> toJsonableObject() {
//    validate();
//    Map<String, Object> params = {
//    };
//
//    List<Object> operation = ['versioned_chain_properties_update'];
//    operation.add(params);
//
//    return operation;
//  }
//}
