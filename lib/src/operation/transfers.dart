import 'dart:typed_data';

import 'package:buffer/buffer.dart' show ByteDataWriter;

import '../exceptions.dart';
import '../json.dart';
import '../types.dart' show AccountName, VizAsset, Memo;
import '../utils.dart' show BinaryUtils;
import 'base_operatin.dart';

class Transfer implements BaseOperation, Jsonable<List<Object>> {
  AccountName from;
  AccountName to;
  VizAsset amount;
  Memo memo;

  static const ID = 2;

  Transfer({this.from, this.to, this.amount, this.memo}) {
    _fillOptionFields();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(from.toBytes());
    writer.write(to.toBytes());
    writer.write(amount.toBytes());
    writer.write(memo.toBytes());
    return writer.toBytes();
  }

  @override
  void validate() {
    _fillOptionFields();
    _checkNulls();
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'from': from.toString(),
      'to': to.toString(),
      'amount': amount.toString(),
      'memo': memo.toString()
    };

    List<Object> operation = ['transfer'];
    operation.add(params);

    return operation;
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(from, 'from');
    InvalidParameterException.checkNotNull(to, 'to');
    InvalidParameterException.checkNotNull(amount, 'amount');
  }

  void _fillOptionFields() {
    if (memo == null) {
      memo = Memo('');
    }
  }
}

class TransferToVesting implements BaseOperation, Jsonable<List<Object>> {
  AccountName from;
  AccountName to;
  VizAsset amount;

  static const ID = 3;

  TransferToVesting({this.from, this.to, this.amount});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(from.toBytes());
    writer.write(to.toBytes());
    writer.write(amount.toBytes());
    ;
    return writer.toBytes();
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'from': from.toString(),
      'to': to.toString(),
      'amount': amount.toString()
    };

    List<Object> operation = ['transfer_to_vesting'];
    operation.add(params);

    return operation;
  }

  @override
  void validate() {
    _checkNulls();
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(from, 'from');
    InvalidParameterException.checkNotNull(to, 'to');
    InvalidParameterException.checkNotNull(amount, 'amount');
  }
}
