import 'package:viz_transaction/viz_transaction.dart';

void main() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  Custom custom = Custom(
      id: CustomId('test'),
      requiredRegularAuths: [AccountName('alex')],
      jsonStr: '{"test_custom": "Hello World"}');
  trx.operations.add(custom);
  trx.sign(['<REGULAR_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}
