import 'package:viz_transaction/viz_transaction.dart';

void main() {
  Transaction trx = Transaction(
      expiration: TimePointSec(
          DateTime.now().add(Duration(minutes: 30))), // now time + 30min
      refBlockNum: 46179,
      refBlockPrefix: 1490075988);

  Award award = Award(
      initiator: AccountName('<INITIATOR_LOGIN>'),
      receiver: AccountName('<RECEIVER_LOGIN>'),
      energy: 1000, // 10.00%
      memo: Memo('Hello World'));

  trx.operations.add(award);
  trx.sign(['<REGULAR_PRIVATE_KEY>']); //Sign transaction

  print(trx.toJson()); // And get a json string to broadcast in blockchain
}
