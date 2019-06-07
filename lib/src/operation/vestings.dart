import 'dart:typed_data';

import 'package:buffer/buffer.dart' show ByteDataWriter;

import '../exceptions.dart';
import '../json.dart';
import '../types.dart' show AccountName, SharesAsset;
import '../utils.dart' show BinaryUtils;
import 'base_operatin.dart';

class WithdrawVesting implements BaseOperation, Jsonable<List<Object>> {
  AccountName account;
  SharesAsset amount;

  static const ID = 4;

  WithdrawVesting({this.account, this.amount});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(account.toBytes());
    writer.write(amount.toBytes());
    return writer.toBytes();
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'account': account.toString(),
      'vesting_shares': amount.toString()
    };

    List<Object> operation = ['withdraw_vesting'];
    operation.add(params);

    return operation;
  }

  @override
  void validate() {
    _checkNulls();
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(account, 'account');
    InvalidParameterException.checkNotNull(amount, 'amount');
  }
}

class SetWithdrawVestingRoute implements BaseOperation, Jsonable<List<Object>> {
  AccountName from;
  AccountName to;

  ///uint16. 100% = 10 000, 1% = 100, 0.01% = 1
  int percent;
  bool autoVest;

  static const ID = 11;

  SetWithdrawVestingRoute({this.from, this.to, this.percent, this.autoVest}) {
    _fillOptionalFields();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(from.toBytes());
    writer.write(to.toBytes());
    writer.write(BinaryUtils.transformUint16ToBytes(percent));
    writer.writeInt8(autoVest ? 1 : 0);
    return writer.toBytes();
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'from_account': from.toString(),
      'to_account': to.toString(),
      'percent': percent,
      'auto_vest': autoVest
    };

    List<Object> operation = ['set_withdraw_vesting_route'];
    operation.add(params);

    return operation;
  }

  @override
  void validate() {
    _fillOptionalFields();
    _checkNulls();
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(from, 'from');
    InvalidParameterException.checkNotNull(to, 'to');
  }

  void _fillOptionalFields() {
    if (percent == null) {
      percent = 0;
    }

    if (autoVest == null) {
      autoVest = false;
    }
  }
}

class DelegateVestingShares implements BaseOperation, Jsonable<List<Object>> {
  /// An account delegating vesting shares
  AccountName delegator;

  /// An account receiving vesting shares
  AccountName delegatee;
  SharesAsset amount;

  static const ID = 19;

  DelegateVestingShares({this.delegator, this.delegatee, this.amount});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(delegator.toBytes());
    writer.write(delegatee.toBytes());
    writer.write(amount.toBytes());
    return writer.toBytes();
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'delegator': delegator.toString(),
      'delegatee': delegatee.toString(),
      'vesting_shares': amount.toString()
    };

    List<Object> operation = ['delegate_vesting_shares'];
    operation.add(params);

    return operation;
  }

  @override
  void validate() {
    _checkNulls();
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(delegator, 'delegator');
    InvalidParameterException.checkNotNull(delegatee, 'delegatee');
  }
}
