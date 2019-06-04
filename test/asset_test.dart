import 'package:test/test.dart';
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  group('Testing Asset utils.', () {
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