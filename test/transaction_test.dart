import 'package:convert/convert.dart';
import "package:test/test.dart";
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  Transaction trx;

  setUp(() {
    trx = Transaction();
    trx.expiration = TimePointSec(DateTime.parse('2019-05-29T14:37:02+00:00'));
    trx.refBlockNum = 40593;
    trx.refBlockPrefix = 2545120202;
  });

  group('Testing transformation transaction to bytes.', () {
    test("Testing one award operation.", () {
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

      trx.operations.add(awardOp);
      expect(
          hex.encode(trx.toBytes()),
          equals(
              '2040effda178d4fffff5eab7a915d4019879f5205cc5392e4bcced2b6edda0cd' //chainId
              '919eca73b3970e99ee5c' //refBlockNum, refBlockPrefix, expiration,
              '01' //operations count
              '2f03626f6204616c65782e1632000000000000000c48656c6c6f20576f726c64210207706f6d2e626f62320006746f746f626f3200' //operations
              '00' //extensions count
              ));
    });

    test("Testing two award operations.", () {
      Award awardOp1 = Award(
          initiator: AccountName('bob'),
          receiver: AccountName('alex'),
          energy: 5678,
          customSequence: Uint64(BigInt.from(50)),
          memo: Memo('Hello World!'),
          beneficiaries: [
            BeneficiaryRouteType(AccountName('pom.bob'), 50),
            BeneficiaryRouteType(AccountName('totobo'), 50)
          ]);

      Award awardOp2 = Award(
          initiator: AccountName('bobtist'),
          receiver: AccountName('alexander'),
          energy: 10000,
          customSequence: Uint64(BigInt.from(78567564576568)),
          memo: Memo('Hello Dear World!'),
          beneficiaries: [
            BeneficiaryRouteType(AccountName('folor'), 3200),
            BeneficiaryRouteType(AccountName('roi'), 5800)
          ]);

      trx.operations.add(awardOp1);
      trx.operations.add(awardOp2);
      expect(
          hex.encode(trx.toBytes()),
          equals(
              '2040effda178d4fffff5eab7a915d4019879f5205cc5392e4bcced2b6edda0cd' //chainId
              '919eca73b3970e99ee5c' //refBlockNum, refBlockPrefix, expiration
              '02' //operations count
              '2f03626f6204616c65782e1632000000000000000c48656c6c6f20576f726c64210207706f6d2e626f62320006746f746f626f3200' //awardOp1
              '2f07626f627469737409616c6578616e64657210273807c7ef744700001148656c6c6f204465617220576f726c64210205666f6c6f72800c04726f7469a816' //awardOp2
              '00' //extensions count
              ));
    });
  });
}
