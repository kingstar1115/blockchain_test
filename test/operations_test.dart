import 'package:convert/convert.dart';
import "package:test/test.dart";
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  group('Operations transformation transaction to bytes.', () {
    test("Testing Award operation.", () {
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

    test("Testing Transfer operation.", () {
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

    test("Testing TransferToVesting operation.", () {
      TransferToVesting transfer = TransferToVesting(
          from: AccountName('bob'),
          to: AccountName('alex'),
          amount: VizAsset(523000) // 523 VIZ
          );
      expect(hex.encode(transfer.toBytes()),
          equals('0303626f6204616c6578f8fa0700000000000356495a00000000'));
    });

    test("Testing WithdrawVesting operation.", () {
      WithdrawVesting withdraw = WithdrawVesting(
          account: AccountName('bob'), amount: SharesAsset(1000000) // 1 SHARES
          );
      expect(hex.encode(withdraw.toBytes()),
          equals('0403626f6240420f00000000000653484152455300'));
    });

    test("Testing SetWithdrawVestingRoute operation.", () {
      SetWithdrawVestingRoute vestingRoute = SetWithdrawVestingRoute(
          from: AccountName('bob'),
          to: AccountName('alex'),
          percent: 1000, // 10%
          autoVest: true);
      expect(hex.encode(vestingRoute.toBytes()),
          equals('0b03626f6204616c6578e80301'));
    });

    test("Testing DelegateVestingShares operation.", () {
      DelegateVestingShares delegateVestingShares = DelegateVestingShares(
          delegator: AccountName('bob'),
          delegatee: AccountName('alex'),
          amount: SharesAsset(540000000) // 540 Shares
          );
      expect(hex.encode(delegateVestingShares.toBytes()),
          equals('1303626f6204616c657800bf2f20000000000653484152455300'));
    });
  });
}
