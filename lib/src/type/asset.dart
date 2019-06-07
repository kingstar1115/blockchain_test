import 'dart:convert';
import 'dart:typed_data';

import 'package:buffer/buffer.dart' show ByteDataWriter;

import '../exceptions.dart';
import '../utils.dart' show BinaryUtils;
import 'base_type.dart';

enum AssetSymbol { VIZ, SHARES }

abstract class Asset implements BaseType {
  ///Original type is int64
  int amount;

  ///Original type  uint64
  AssetSymbol get symbol;
  int get decimals;

  Asset(this.amount);

  /// Creates [Asset] from a string like 16.000 VIZ.
  /// A ``value`` must be in the format ``INTEGER.DECIMAL SYMBOL_NAME``.
  /// Fore example 20 VIZ must be ``20.000 VIZ`` or 50 SHARES must be ``50.000000 SHARES``.
  Asset.fromString(String value) {
    value = value.trim().toUpperCase();
    String symbolName = symbol.toString().split('.').last.toUpperCase();

    RegExp regExp = RegExp('^-?[0-9]+\\.[0-9]{$decimals} $symbolName\$');

    if (regExp.hasMatch(value)) {
      String amountStr = value.split(' ')[0].split('.').join();
      amount = int.tryParse(amountStr);
    } else {
      throw FormatException(
          'Invalid value = $value: The string format of the asset must consist of $decimals decimal places '
          'and at least one before the comma and "$symbolName" after space.');
    }
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

    if (amountStr.length <= decimals) {
      amountStr = _padAmountStr(amountStr);
    }

    String decimalsStr = amountStr.substring(amountStr.length - decimals);
    amountStr = amountStr.substring(0, amountStr.length - decimals);
    return '$amountStr.$decimalsStr $assetName';
  }

  String _padAmountStr(String amountStr) {
    amountStr = amountStr.padLeft(decimals + 1, '0');
    return amountStr;
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(amount, 'amoun');
    InvalidParameterException.checkNotNull(symbol, 'symbol');
    InvalidParameterException.checkNotNull(decimals, 'decimals');
  }
}

class VizAsset extends Asset {
  @override
  AssetSymbol get symbol => AssetSymbol.VIZ;
  @override
  int get decimals => 3;

  ///1 = 0.001 VIZ
  ///10 = 0.01 VIZ
  ///100 = 0.1 VIZ
  ///1 000 = 1 VIZ
  ///10 000 = 10 VIZ
  ///100 000 = 100 VIZ
  VizAsset(int amount) : super(amount);
  VizAsset.fromString(String value) : super.fromString(value);
}

class SharesAsset extends Asset {
  @override
  AssetSymbol get symbol => AssetSymbol.SHARES;
  @override
  int get decimals => 6;

  ///1 = 0.000001 SHARES
  ///1 000 000 = 1 SHARES
  ///10 000 000 = 10 SHARES
  ///100 000 000 = 100 SHARES
  SharesAsset(int amount) : super(amount);
  SharesAsset.fromString(String value) : super.fromString(value);
}
