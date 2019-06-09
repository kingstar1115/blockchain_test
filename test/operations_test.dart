import 'package:convert/convert.dart';
import "package:test/test.dart";
import 'package:viz_dart_ecc/viz_dart_ecc.dart';
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

    test("Testing SetPaidSubscription operation.", () {
      SetPaidSubscription setPaidSubscription = SetPaidSubscription(
          account: AccountName('alex'),
          amount: VizAsset.fromString('200.000 VIZ'),
          levels: 10,
          period: 30,
          url: MemoUrl('https://example.com'));

      expect(
          hex.encode(setPaidSubscription.toBytes()),
          equals(
              '3204616c65781368747470733a2f2f6578616d706c652e636f6d0a00400d0300000000000356495a000000001e00'));
    });

    test("Testing PaidSubscription operation.", () {
      PaidSubscription paidSubscription = PaidSubscription(
          account: AccountName('alex'),
          subscriber: AccountName('bob'),
          amount: VizAsset.fromString('100.000 VIZ'),
          level: 5,
          period: 10,
          autoRenewal: true);

      expect(
          hex.encode(paidSubscription.toBytes()),
          equals(
              '3303626f6204616c65780500a0860100000000000356495a000000000a0001'));
    });

    test("Testing CreateInvite operation.", () {
      CreateInvite createInvite = CreateInvite(
          creator: AccountName('bob'),
          balance: VizAsset.fromString('2345.000 VIZ'),
          inviteKeyPubKey: VIZPublicKey.fromString(
              'VIZ88WzAwBeg9ZqEe3ykJKhnSVjpZU75KcNNbWZji6tFddiP5rtwX'));

      expect(
          hex.encode(createInvite.toBytes()),
          equals(
              '2b03626f6228c82300000000000356495a0000000003aaf0e06546cebf14c31014ddea4e308fbcc4a9d40344ec352e9c2263cb6ade55'));
    });

    test("Testing ClaimInviteBalance operation.", () {
      ClaimInviteBalance inviteRegistration = ClaimInviteBalance(
          receiver: AccountName('alex'),
          initiator: AccountName('bob'),
          secret: VIZPrivateKey.fromString(
              '5KUEWR4TcKw6KP35cZ1DiGQH5ADf5CTM7WH8jPGaGwbkQCLWbWz'));

      expect(
          hex.encode(inviteRegistration.toBytes()),
          equals(
              '2c03626f6204616c657833354b554557523454634b77364b503335635a314469475148354144663543544d375748386a5047614777626b51434c5762577a'));
    });

    test("Testing InviteRegistration operation.", () {
      InviteRegistration inviteRegistration = InviteRegistration(
          initiator: AccountName('bob'),
          newAccount: AccountName('alex'),
          newAccountPubKey: VIZPublicKey.fromString(
              'VIZ8P3WuejwhAyHdjdHb2BgBcmr9ecUSNkSM3wym3dK8mNCCmtqYu'),
          secret: VIZPrivateKey.fromString(
              '5KN1P2GmJbMXQEKKq7sQoxBSkKMBvibjPXoXm17PG8snQVmjuPr'));
      expect(
          hex.encode(inviteRegistration.toBytes()),
          equals(
              '2d03626f6204616c657833354b4e315032476d4a624d5851454b4b713773516f7842536b4b4d427669626a50586f586d3137504738736e51566d6a75507203cbecc28163b484510c35d00c014e384f4b679686379a5d51e1f29d483e2f4d45'));
    });

    test("Testing CommitteeWorkerCreateRequest operation.", () {
      CommitteeWorkerCreateRequest committeeCreateRequest =
          CommitteeWorkerCreateRequest(
              creator: AccountName('bob'),
              worker: AccountName('alex'),
              maxRequiredAmount: VizAsset.fromString('1000000.000 VIZ'),
              url: MiniUrl('https://example.com'),
              duration: 5);
      expect(
          hex.encode(committeeCreateRequest.toBytes()),
          equals(
              '2303626f621368747470733a2f2f6578616d706c652e636f6d04616c657800000000000000000356495a0000000000ca9a3b000000000356495a0000000080970600'));
    });

    test("Testing CommitteeWorkerCancelRequest operation.", () {
      CommitteeWorkerCancelRequest cancelRequest = CommitteeWorkerCancelRequest(
          creator: AccountName('bob'), requestId: 123);

      expect(hex.encode(cancelRequest.toBytes()), equals('2403626f627b000000'));
    });

    test("Testing CommitteeVoteRequest operation.", () {
      CommitteeVoteRequest voteRequest = CommitteeVoteRequest(
          voter: AccountName('alex'), votePercent: -234, requestId: 9678);

      expect(hex.encode(voteRequest.toBytes()),
          equals('2504616c6578ce25000016ff'));
    });

    test("Testing EscrowTransfer operation.", () {
      EscrowTransfer escrowTransfer = EscrowTransfer(
          initiator: AccountName('bob'),
          receiver: AccountName('alex'),
          agent: AccountName('god'),
          tokenAmount: VizAsset.fromString('1000.000 VIZ'),
          fee: VizAsset.fromString('67.000 VIZ'),
          escrowId: 8675,
          ratificationDeadline:
              TimePointSec(DateTime.parse('2019-06-08T10:54:21+00:00')),
          escrowExpiration:
              TimePointSec(DateTime.parse('2019-06-08T17:54:21+00:00')),
          jsonMetadata: '{"mess": "Hello Wordl!"}');

      expect(
          hex.encode(escrowTransfer.toBytes()),
          equals(
              '0f03626f6204616c657840420f00000000000356495a00000000e321000003676f64b8050100000000000356495a00000000187b226d657373223a202248656c6c6f20576f72646c21227ddd93fb5c4df6fb5c'));
    });

    test("Testing EscrowApprove operation.", () {
      EscrowApprove escrowApprove = EscrowApprove(
          escrowInitiator: AccountName('bob'),
          receiver: AccountName('alex'),
          agent: AccountName('god'),
          who: AccountName('alex'),
          escrowId: 9886,
          approve: true);

      expect(hex.encode(escrowApprove.toBytes()),
          equals('1203626f6204616c657803676f6404616c65789e26000001'));
    });

    test("Testing EscrowRelease operation.", () {
      EscrowRelease escrowRelease = EscrowRelease(
          escrowInitiator: AccountName('bob'),
          receiver: AccountName('alex'),
          agent: AccountName('god'),
          who: AccountName('god'),
          escrowId: 78545,
          tokenAmount: VizAsset.fromString('7856.000 VIZ'),
          tokensReceiver: AccountName('alex'));

      expect(
          hex.encode(escrowRelease.toBytes()),
          equals(
              '1103626f6204616c657803676f6403676f6404616c6578d132010080df7700000000000356495a00000000'));
    });

    test("Testing EscrowDispute operation.", () {
      EscrowDispute escrowDispute = EscrowDispute(
          escrowId: 777,
          escrowInitiator: AccountName('bob'),
          receiver: AccountName('alex'),
          agent: AccountName('god'),
          who: AccountName('alex'));

      expect(hex.encode(escrowDispute.toBytes()),
          equals('1003626f6204616c657803676f6404616c657809030000'));
    });

    test("Testing EscrowDispute operation.", () {
      Custom custom = Custom(id: CustomId('test'),
          requiredRegularAuths: [AccountName('alex')],
          jsonStr: '{"test_custom": "Hello World"}');

      expect(hex.encode(custom.toBytes()),
          equals('0a000104616c657804746573741e7b22746573745f637573746f6d223a202248656c6c6f20576f726c64227d'));
    });
  });
}
