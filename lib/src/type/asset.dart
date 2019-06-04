import 'dart:convert';
import 'dart:typed_data';

import 'package:buffer/buffer.dart' show ByteDataWriter;

import '../exceptions.dart';
import '../utils.dart' show BinaryUtils;
import 'base_type.dart';

enum AssetSymbol { VIZ, SHARES }

class Asset implements BaseType {
  ///Original type is int64
  int amount;

  ///Original type  uint64
  AssetSymbol _symbol;
  int _decimals;

  AssetSymbol get symbol => _symbol;
  int get decimals => _decimals;

  Asset(this.amount, AssetSymbol symbol, int decimals) {
    this._symbol = symbol;
    this._decimals = decimals;
  }

  @override
  Uint8List toBytes() {
    validate();

    String symbolName = symbol.toString().split('.').last.toUpperCase();

    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt64ToBytes(amount));
    writer.write(BinaryUtils.transformInt8ToBytes(decimals));
    writer.write(utf8.encode(symbolName));

    for (int i = symbolName.length; i < 7; i++) {
      writer.writeInt8(0x00);
    }

    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();
  }

  @override
  String toString() {
    String assetName = symbol.toString().split('.').last.toUpperCase();
    String amountStr = amount.toString();
    String decimalsStr = amountStr.substring(amountStr.length - decimals);
    amountStr = amountStr.substring(0, amountStr.length - decimals);
    return '$amountStr.$decimalsStr $assetName';
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(amount, 'amoun');
    InvalidParameterException.checkNotNull(symbol, 'symbol');
    InvalidParameterException.checkNotNull(decimals, 'decimals');
  }
}

class VizAsset extends Asset {
  ///1 = 0.001 VIZ
  ///10 = 0.01 VIZ
  ///100 = 0.1 VIZ
  ///1 000 = 1 VIZ
  ///10 000 = 10 VIZ
  ///100 000 = 100 VIZ
  VizAsset(int amount) : super(amount, AssetSymbol.VIZ, 3);
}

class SharesAsset extends Asset {
  ///1 = 0.000001 SHARES
  ///1 000 000 = 1 SHARES
  ///10 000 000 = 10 SHARES
  ///100 000 000 = 100 SHARES
  SharesAsset(int amount) : super(amount, AssetSymbol.SHARES, 6);
}
