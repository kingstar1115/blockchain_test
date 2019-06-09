import 'package:viz_dart_ecc/viz_dart_ecc.dart';
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  accountUpdateExample();
}

void accountUpdateExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  AccountUpdate accountUpdate = AccountUpdate(
      account: AccountName('bob'),
      master: Authority(weightThreshold: 1, keyAuths: {
        VIZPublicKey.fromString(
            'VIZ5mBeifuYe9gQKdZPLZ9Ps48i1EGpXBEQSTvBqTJ4PopVUWtyJL'): 1
      }),
      regular: Authority(weightThreshold: 1, keyAuths: {
        VIZPublicKey.fromString(
            'VIZ5mBeifuYe9gQKdZPLZ9Ps48i1EGpXBEQSTvBqTJ4PopVUWtyJL'): 1
      }),
      active: Authority(weightThreshold: 2, accountAuths: {
        AccountName('alex'): 1,
        AccountName('jhon'): 1
      }, keyAuths: {
        VIZPublicKey.fromString(
            'VIZ5mBeifuYe9gQKdZPLZ9Ps48i1EGpXBEQSTvBqTJ4PopVUWtyJL'): 2
      }),
      memoKey: VIZPublicKey.fromString(
          'VIZ5mBeifuYe9gQKdZPLZ9Ps48i1EGpXBEQSTvBqTJ4PopVUWtyJL'),
      jsonMetadata: '{"test": "Hello World"}');

  trx.operations.add(accountUpdate);
  trx.sign(['<ACTIVE_MASTER_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}
