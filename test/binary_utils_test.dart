import 'package:convert/convert.dart';
import "package:test/test.dart";
import 'package:viz_transaction/src/utils.dart';

void main() {
  group('Testing binary utils.', () {
    test("Testing correct transformation to bytes", () {
      expect(
          hex.encode(BinaryUtils.transformInt16ToBytes(8976)), equals('1023'));
      expect(hex.encode(BinaryUtils.transformUint16ToBytes(65520)),
          equals('f0ff'));

      expect(hex.encode(BinaryUtils.transformInt32ToBytes(1703542768)),
          equals('f0ff8965'));
      expect(hex.encode(BinaryUtils.transformUint32ToBytes(4287234032)),
          equals('f0ff89ff'));

      expect(hex.encode(BinaryUtils.transformInt64ToBytes(8229311296525959152)),
          equals('f0ff89ff05633472'));
      expect(
          hex.encode(BinaryUtils.transformUint64ToBytes(
              BigInt.from(8229311296525959152))),
          equals('f0ff89ff05633472'));
    });

    test("Testing out of min bounds errors", () {
      expect(
          () => BinaryUtils.transformInt16ToBytes(-32769), throwsArgumentError);
      expect(() => BinaryUtils.transformInt32ToBytes(-2147483649),
          throwsArgumentError);
      expect(() => BinaryUtils.transformUint16ToBytes(-1), throwsArgumentError);
      expect(() => BinaryUtils.transformUint32ToBytes(-1), throwsArgumentError);
      expect(() => BinaryUtils.transformUint64ToBytes(BigInt.from(-1)),
          throwsArgumentError);
      expect(() => BinaryUtils.transformInt32ToVarIntBytes(-2147483649),
          throwsArgumentError);
    });
  });
}
