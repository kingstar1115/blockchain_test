import 'package:viz_transaction/viz_transaction.dart';

void main() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  Transfer transfer = Transfer(
      from: AccountName('<SENDER_LOGIN>'),
      to: AccountName('<RECEIVER_LOGIN>'),
      amount: VizAsset(1000), // 1 VIZ
      memo: Memo('Hello world!'));

  trx.operations.add(transfer);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

  // And get a json string to broadcast in blockchain
  print(trx.toJson());
}
