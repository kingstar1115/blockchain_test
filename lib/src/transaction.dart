import 'dart:convert';
import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:convert/convert.dart';
import 'package:viz_dart_ecc/viz_dart_ecc.dart';

import 'config.dart';
import 'exceptions.dart';
import 'json.dart';
import 'operation/base_operatin.dart';
import 'type/base_type.dart';
import 'type/time_point_sec.dart';
import 'utils.dart';

class Transaction extends BaseType implements Jsonable<Map<String, Object>> {
  TimePointSec expiration;
  List<BaseType> extensions;
  List<BaseOperation> operations;
  int refBlockNum;
  int refBlockPrefix;
  List<String> signatures;

  Transaction(
      {this.expiration,
      this.operations,
      this.refBlockNum,
      this.refBlockPrefix,
      this.extensions,
      this.signatures}) {
    _fillNullOptionalsFields();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(hex.decode(Config.chainId));
    writer.write(BinaryUtils.transformUint16ToBytes(refBlockNum));
    writer.write(BinaryUtils.transformUint32ToBytes(refBlockPrefix));
    writer.write(expiration.toBytes());
    writer.write(BinaryUtils.transformInt64ToVarIntBytes(operations.length));
    for (BaseOperation op in operations) {
      writer.write(op.toBytes());
    }
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(extensions.length));
    for (BaseType ex in extensions) {
      writer.write(ex.toBytes());
    }
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();
    _fillNullOptionalsFields();
    //_validateAllOperations();
  }

  @override
  Map<String, Object> toJsonableObject() {
    validate();
    return {
      'expiration': expiration.toString(),
      'extensions': JsonUtils.serializesToJsonable(extensions),
      'operations': JsonUtils.serializesToJsonable(operations),
      'ref_block_num': refBlockNum,
      'ref_block_prefix': refBlockPrefix,
      'signatures': signatures
    };
  }

  ///Converts the transaction to Json string
  String toJsonString() {
    Map<String, Object> jsonObj = this.toJsonableObject();
    String jsonStr = json.encode(jsonObj);
    return jsonStr;
  }

  ///Signs the transaction and adds signatures to [Transaction.signatures] filed.
  void sign(List<String> keys) {
    List<String> newSignatures = generateSignatures(keys);
    signatures.addAll(newSignatures);
  }

  List<String> generateSignatures(List<String> keys) {
    List<String> signatures = [];

    for (String key in keys) {
      String signature = generateSignature(key);
      signatures.add(signature);
    }

    return signatures;
  }

  String generateSignature(String wif) {
    VIZPrivateKey privateKey = VIZPrivateKey.fromString(wif);
    VIZSignature signature = privateKey.sign(toBytes());
    return signature.toString();
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(operations, 'operations');
    InvalidParameterException.checkNotNull(refBlockNum, 'ref_block_num');
    InvalidParameterException.checkNotNull(refBlockPrefix, 'ref_block_prefix');
  }

  void _fillNullOptionalsFields() {
    if (expiration == null) {
      expiration = TimePointSec(DateTime.now().add(Duration(minutes: 30)));
    }

    if (operations == null) {
      operations = [];
    }

    if (extensions == null) {
      extensions = [];
    }

    if (signatures == null) {
      signatures = [];
    }
  }
}
