import "package:test/test.dart";
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  group('Testing operators utils.', () {
    test("Testing AccountName", () {
      expect(AccountName('bob') != AccountName('bob'), equals(false));
      expect(AccountName('bob') != AccountName('alex'), equals(true));

      expect(AccountName('bob') == AccountName('alex'), equals(false));
      expect(AccountName('bob') == AccountName('bob'), equals(true));
    });

    test("Testing TimePointSec", () {
      DateTime greaterTime = DateTime(2020);
      DateTime lessTime = DateTime(2018);

      TimePointSec greater = TimePointSec(greaterTime);
      TimePointSec equal = TimePointSec(greaterTime);

      TimePointSec less = TimePointSec(lessTime);

      expect(greater > less, equals(true));
      expect(greater >= less, equals(true));
      expect(greater >= equal, equals(true));
      expect(greater == equal, equals(true));

      expect(greater < less, equals(false));
      expect(greater <= less, equals(false));
      expect(greater == less, equals(false));
    });
  });
}
