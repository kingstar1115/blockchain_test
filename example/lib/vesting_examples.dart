import 'package:viz_transaction/viz_transaction.dart';

void main() {
  withdrawVestingExample();
  setWithdrawVestingRouteExample();
  delegateVestingSharesExample();
}

void withdrawVestingExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  WithdrawVesting withdraw = WithdrawVesting(
      account: AccountName('<ACCOUNT_NAME>'),
      amount: SharesAsset.fromString('540.000000 SHARES'));

  trx.operations.add(withdraw);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

  // And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void setWithdrawVestingRouteExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  SetWithdrawVestingRoute vestingRoute = SetWithdrawVestingRoute(
      from: AccountName('<SENDER_LOGIN>'),
      to: AccountName('<RECEIVER_LOGIN>'),
      percent: 1000, // 10%
      autoVest: true);

  trx.operations.add(vestingRoute);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void delegateVestingSharesExample() {
  Transaction trx = Transaction(refBlockNum: 46179, refBlockPrefix: 1490075988);

  DelegateVestingShares delegateVestingShares = DelegateVestingShares(
      delegator: AccountName('<SENDER_LOGIN>'),
      delegatee: AccountName('<RECEIVER_LOGIN>'),
      amount: SharesAsset(540000000) // another way to set 540 Shares
      );

  trx.operations.add(delegateVestingShares);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}
