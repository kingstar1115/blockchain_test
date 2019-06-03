import 'package:viz_transaction/viz_transaction.dart';

void main() {
  Transaction trx = Transaction(
      expiration: TimePointSec(DateTime.now().add(Duration(minutes: 30))),
      refBlockNum: 46179,
      refBlockPrefix: 1490075988); // now time + 30min

  Award award = Award(
      initiator: AccountName('<INITIATOR_LOGIN>'), //<INITIATOR_LOGIN>
      receiver: AccountName('<RECEIVER_LOGIN>'), //<RECEIVER_LOGIN>
      energy: 1000, // 10.00%
      customSequence:
          Uint64(BigInt.from(1234)), // Just any number, usually zero
      memo: Memo('Hello World'),
      beneficiaries: []);

  trx.operations.add(award);
  trx.sign(['<REGULAR_PRIVATE_KEY>']); //Sign transaction

  print(trx.toJson()); // And get a json string to broadcast in blockchain
}
