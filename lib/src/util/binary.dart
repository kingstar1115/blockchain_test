import 'dart:convert';
import 'dart:typed_data';

import 'package:buffer/buffer.dart';

import '../types.dart';

class BinaryUtils {
  static final String _OUT_OF_BOUNDS_START_MESS = 'can\'t be less than';
  static final String _OUT_OF_BOUNDS_MIDDLE_MESS = 'and larger than';
  static final String _OUT_OF_BOUNDS_END_MESS = 'but it equals';

  static void _checkOutOfBoundsInt(int val, String type, int min, int max) {
    if (val < min || val > max) {
      throw ArgumentError.value(
          val,
          'value',
          '$type $_OUT_OF_BOUNDS_START_MESS $min '
              '$_OUT_OF_BOUNDS_MIDDLE_MESS $max '
              '$_OUT_OF_BOUNDS_END_MESS');
    }
  }

  static void _checkOutOfBoundsBigInt(
      BigInt val, String type, BigInt min, BigInt max) {
    if (val < min || val > max) {
      throw ArgumentError.value(
          val,
          'value',
          '$type $_OUT_OF_BOUNDS_START_MESS $min '
              '$_OUT_OF_BOUNDS_MIDDLE_MESS $max '
              '$_OUT_OF_BOUNDS_END_MESS');
    }
  }

  ///Transforms an int16 value to bytes.
  ///Value must be in range -32768 to 32767.
  static Uint8List transformInt16ToBytes(int value,
      [Endian endian = Endian.little]) {
    _checkOutOfBoundsInt(value, 'int16', -32768, 32767);

    ByteDataWriter writer = ByteDataWriter();
    writer.writeInt16(value, endian);

    return writer.toBytes();
  }

  ///Transforms an int32 value to bytes.
  ///Value must be in range -2147483648 to 2147483647.
  static Uint8List transformInt32ToBytes(int value,
      [Endian endian = Endian.little]) {
    _checkOutOfBoundsInt(value, 'int32', -2147483648, 2147483647);

    ByteDataWriter writer = ByteDataWriter();
    writer.writeInt32(value, endian);

    return writer.toBytes();
  }

  ///Transforms an int64 value to bytes.
  ///Value must be in range -9223372036854775808 to 9223372036854775807.
  static Uint8List transformInt64ToBytes(int value,
      [Endian endian = Endian.little]) {
    _checkOutOfBoundsInt(
        value, 'int64', -9223372036854775808, 9223372036854775807);

    ByteDataWriter writer = ByteDataWriter();
    writer.writeInt64(value, endian);

    return writer.toBytes();
  }

  ///Transforms an uint16 value to bytes.
  ///Value must be in range 0 to 65535.
  static Uint8List transformUint16ToBytes(int value,
      [Endian endian = Endian.little]) {
    _checkOutOfBoundsInt(value, 'uint16', 0, 65535);

    ByteDataWriter writer = ByteDataWriter();
    writer.writeUint16(value, endian);

    return writer.toBytes();
  }

  ///Transforms an uint32 value to bytes.
  ///Value must be in range 0 to 4294967295.
  static Uint8List transformUint32ToBytes(int value,
      [Endian endian = Endian.little]) {
    _checkOutOfBoundsInt(value, 'uint32', 0, 4294967295);

    ByteDataWriter writer = ByteDataWriter();
    writer.writeUint32(value, endian);

    return writer.toBytes();
  }

  ///Transforms an uint64 value to bytes.
  ///Value must be in range 0 to 18446744073709551615.
  static Uint8List transformUint64ToBytes(BigInt value,
      [Endian endian = Endian.little]) {
    _checkOutOfBoundsBigInt(value, 'uint64', BigInt.from(0),
        BigInt.tryParse('18446744073709551615'));

    ByteDataWriter writer = ByteDataWriter();
    writer.writeUint64(value.toSigned(64).toInt(), endian);

    return writer.toBytes();
  }

  ///Transforms an uint32 value to VarInt big-endian bytes.
  ///Value must be in range -2147483648 to 2147483647.
  static Uint8List transformInt32ToVarIntBytes(int value) {
    _checkOutOfBoundsInt(value, 'int32', -2147483647, 2147483647);

    return transformInt64ToVarIntBytes(value & 0xFFFFFFFF);
  }

  ///Transforms an uint64 value to VarInt big-endian bytes.
  ///Value must be in range -9223372036854775808 to 9223372036854775807.
  static Uint8List transformInt64ToVarIntBytes(int value) {
    _checkOutOfBoundsInt(
        value, 'int64', -9223372036854775808, 9223372036854775807);

    ByteDataWriter writer = ByteDataWriter();

    do {
      int temp = value & 0x7F; //0x7F = 01111111

      value = (value >> 7) & 0x01FFFFFFFFFFFFFF; //unsigned bit-right shift

      if (value != 0) {
        temp |= 0x80;
      }

      writer.writeUint8(temp.toInt());
    } while (value != 0);

    return writer.toBytes();
  }

  static Uint8List transformStringToVarIntBytes(String value) {
    ArgumentError.checkNotNull(value, 'value');

    List<int> stringAsBytes = utf8.encode(value);

    ByteDataWriter writer = ByteDataWriter();
    writer.write(transformInt64ToVarIntBytes(stringAsBytes.length));
    writer.write(stringAsBytes);

    return writer.toBytes();
  }

  static Uint8List transformListToBytes(List<BaseType> value) {
    ByteDataWriter writer = ByteDataWriter();
    writer.write(transformInt64ToVarIntBytes(value.length));

    for (BaseType t in value) {
      writer.write(t.toBytes());
    }

    return writer.toBytes();
  }
}
