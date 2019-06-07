import 'package:viz_transaction/viz_transaction.dart';

void main() {
  Transaction trx = Transaction(refBlockNum: 46179, refBlockPrefix: 1490075988);

  Award award = Award(
      initiator: AccountName('<INITIATOR_LOGIN>'),
      receiver: AccountName('<RECEIVER_LOGIN>'),
      energy: 1000, // 10.00%
      memo: Memo('Hello World'));

  trx.operations.add(award);
  trx.sign(['<REGULAR_PRIVATE_KEY>']); //Sign transaction

  print(trx.toJsonString()); // And get a json string to broadcast in blockchain
}
