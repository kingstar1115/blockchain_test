import 'dart:typed_data';

import 'package:buffer/buffer.dart';

import '../exceptions.dart';
import '../json.dart';
import '../types.dart' show AccountName, Url, VizAsset;
import '../utils.dart' show BinaryUtils;
import 'base_operatin.dart';

const PAID_SUBSCRIPTION_MAX_LEVEL = 1000;
const PAID_SUBSCRIPTION_MAX_PERIOD = 1000;

class SetPaidSubscription implements BaseOperation, Jsonable<List<Object>> {
  AccountName account;
  Url url;
  VizAsset amount;

  /// Origin type uint16
  int levels;

  /// Origin type uint16
  int period;

  static int get ID => 50;

  SetPaidSubscription(
      {this.account, this.amount, this.levels, this.period, this.url}) {
    _fillOptionalField();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(account.toBytes());
    writer.write(url.toBytes());
    writer.write(BinaryUtils.transformUint16ToBytes(levels));
    writer.write(amount.toBytes());
    writer.write(BinaryUtils.transformUint16ToBytes(period));
    return writer.toBytes();
  }

  @override
  void validate() {
    _fillOptionalField();
    _checkNulls();

    if (levels < 0 || levels > PAID_SUBSCRIPTION_MAX_LEVEL) {
      throw InvalidParameterException(levels, 'levels',
          'Levels count must be in range 0 to $PAID_SUBSCRIPTION_MAX_LEVEL');
    }

    if (period < 0 || period > PAID_SUBSCRIPTION_MAX_PERIOD) {
      throw InvalidParameterException(period, 'period',
          'A period must be in range 0 to $PAID_SUBSCRIPTION_MAX_LEVEL');
    }
  }

  void _fillOptionalField() {
    if (url == null) {
      url = Url('');
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(account, 'acount');
    InvalidParameterException.checkNotNull(amount, 'amount');
    InvalidParameterException.checkNotNull(url, 'url');
    InvalidParameterException.checkNotNull(levels, 'levels');
    InvalidParameterException.checkNotNull(period, 'period');
  }

  @override
  List<Object> toJsonableObject() {
    Map<String, Object> params = {
      'account': account.toString(),
      'url': url.toString(),
      'levels': levels,
      'amount': amount.toString(),
      'period': period
    };

    List<Object> operation = ['set_paid_subscription'];
    operation.add(params);

    return operation;
  }
}

class PaidSubscription implements BaseOperation, Jsonable<List<Object>> {
  AccountName account;
  AccountName subscriber;
  VizAsset amount;

  /// Origin type uint16
  int level;

  /// Origin type uint16
  int period;

  bool autoRenewal;

  static int get ID => 51;

  PaidSubscription(
      {this.account,
      this.subscriber,
      this.amount,
      this.level,
      this.period,
      this.autoRenewal}) {
    _fillOptionalField();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(subscriber.toBytes());
    writer.write(account.toBytes());
    writer.write(BinaryUtils.transformUint16ToBytes(level));
    writer.write(amount.toBytes());
    writer.write(BinaryUtils.transformUint16ToBytes(period));
    writer.writeUint8(autoRenewal ? 1 : 0);
    return writer.toBytes();
  }

  @override
  void validate() {
    _fillOptionalField();
    _checkNulls();

    if (level < 0 || level > PAID_SUBSCRIPTION_MAX_LEVEL) {
      throw InvalidParameterException(level, 'level',
          'A level count must be in range 0 to $PAID_SUBSCRIPTION_MAX_LEVEL');
    }

    if (period < 0 || period > PAID_SUBSCRIPTION_MAX_PERIOD) {
      throw InvalidParameterException(period, 'period',
          'A period must be in range 0 to $PAID_SUBSCRIPTION_MAX_LEVEL');
    }
  }

  void _fillOptionalField() {
    if (autoRenewal == null) {
      autoRenewal = true;
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(account, 'acount');
    InvalidParameterException.checkNotNull(amount, 'amount');
    InvalidParameterException.checkNotNull(subscriber, 'subscriber');
    InvalidParameterException.checkNotNull(level, 'level');
    InvalidParameterException.checkNotNull(period, 'period');
  }

  @override
  List<Object> toJsonableObject() {
    Map<String, Object> params = {
      'subscriber': subscriber.toString(),
      'account': account.toString(),
      'level': level,
      'amount': amount.toString(),
      'period': period,
      'auto_renewal': autoRenewal
    };

    List<Object> operation = ['paid_subscribe'];
    operation.add(params);

    return operation;
  }
}
