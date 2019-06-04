import 'package:convert/convert.dart';
import "package:test/test.dart";
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  group('Operations transformation transaction to bytes.', () {
    test("Testing award operation.", () {
      Award awardOp = Award(
          initiator: AccountName('bob'),
          receiver: AccountName('alex'),
          energy: 5678,
          customSequence: Uint64(BigInt.from(50)),
          memo: Memo('Hello World!'),
          beneficiaries: [
            BeneficiaryRouteType(AccountName('pom.bob'), 50),
            BeneficiaryRouteType(AccountName('totobo'), 50)
          ]);
      expect(
          hex.encode(awardOp.toBytes()),
          equals(
              '2f03626f6204616c65782e1632000000000000000c48656c6c6f20576f726c64210207706f6d2e626f62320006746f746f626f3200'));
    });

    test("Testing transfer operation.", () {
      Transfer transfer = Transfer(
          from: AccountName('bob'),
          to: AccountName('alex'),
          amount: VizAsset(523000), // 523 VIZ
          memo: Memo('The best transfer!'));
      expect(
          hex.encode(transfer.toBytes()),
          equals(
              '0203626f6204616c6578f8fa0700000000000356495a00000000125468652062657374207472616e7366657221'));
    });
  });
}
