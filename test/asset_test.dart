import 'package:test/test.dart';
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  group('Testing Asset.', () {

    test("VizAsset from int", () {
      expect(VizAsset(0).toString(), equals('0.000 VIZ'));
      expect(VizAsset(1).toString(), equals('0.001 VIZ'));
      expect(VizAsset(10).toString(), equals('0.010 VIZ'));
      expect(VizAsset(100).toString(), equals('0.100 VIZ'));
      expect(VizAsset(1000).toString(), equals('1.000 VIZ'));
      expect(VizAsset(10000).toString(), equals('10.000 VIZ'));
      expect(VizAsset(100000).toString(), equals('100.000 VIZ'));
      expect(VizAsset(1000000).toString(), equals('1000.000 VIZ'));
    });

    test("SharesAsset from int", () {
      expect(SharesAsset(0).toString(), equals('0.000000 SHARES'));
      expect(SharesAsset(1).toString(), equals('0.000001 SHARES'));
      expect(SharesAsset(10).toString(), equals('0.000010 SHARES'));
      expect(SharesAsset(100).toString(), equals('0.000100 SHARES'));
      expect(SharesAsset(1000).toString(), equals('0.001000 SHARES'));
      expect(SharesAsset(10000).toString(), equals('0.010000 SHARES'));
      expect(SharesAsset(100000).toString(), equals('0.100000 SHARES'));
      expect(SharesAsset(1000000).toString(), equals('1.000000 SHARES'));
      expect(SharesAsset(10000000).toString(), equals('10.000000 SHARES'));
      expect(SharesAsset(100000000).toString(), equals('100.000000 SHARES'));
    });

    test("VizAsset.fromString", () {
      String value = '533.654 VIZ';
      VizAsset asset = VizAsset.fromString(value);
      expect(asset.toString(), equals(value));
    });

    test("SharesAsset.fromString", () {
      String value = '533.654345 SHARES';
      SharesAsset asset = SharesAsset.fromString(value);
      expect(asset.toString(), equals(value));
    });
  });
}
