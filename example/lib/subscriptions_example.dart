import 'package:viz_transaction/viz_transaction.dart';

void main() {
  setPaidSubscriptionExample();
  paidSubscriptionExample();
}

void setPaidSubscriptionExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  SetPaidSubscription setPaidSubscription = SetPaidSubscription(
      account: AccountName('<LOGIN_NAME>'),
      amount: VizAsset.fromString('200.000 VIZ'),
      levels: 10,
      period: 30,
      url: Url('https://example.com'));

  trx.operations.add(setPaidSubscription);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJson());
}

void paidSubscriptionExample() {
  Transaction trx = Transaction(refBlockNum: 46179, refBlockPrefix: 1490075988);

  PaidSubscription paidSubscription = PaidSubscription(
    account: AccountName('<LOGIN_NAME>'),
    subscriber: AccountName('<LOGIN_NAME>'),
    amount: VizAsset.fromString('100.000 VIZ'),
    level: 5,
    period: 10,
    autoRenewal: true
  );

  trx.operations.add(paidSubscription);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJson());
}
