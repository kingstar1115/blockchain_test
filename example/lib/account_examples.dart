import 'package:viz_dart_ecc/viz_dart_ecc.dart';
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  accountUpdateExample();
  requestAccountRecoveryExample();
  recoverAccountExample();
  changeRecoveryAccountExample();
  accountMetadataExample();
  accountCreateExample();
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
  trx.sign(['<PRIVATE_MASTER_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void requestAccountRecoveryExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  RequestAccountRecovery requestRecovery = RequestAccountRecovery(
      accountToRecover: AccountName('bob'),
      recoveryAccount: AccountName('alex'),
      newMasterAuth: Authority(weightThreshold: 1, keyAuths: {
        VIZPublicKey.fromString(
            'VIZ7cjtcWktb6sqv5ehUcDUZre1jwCYWYkC35UYSek7eDVKwyKQSY'): 1
      }));

  trx.operations.add(requestRecovery);
  trx.sign(['<PRIVATE_ACTIVE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void recoverAccountExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  RecoverAccount recoverAccount = RecoverAccount(
      accountToRecover: AccountName('bob'),
      recentMasterAuth: Authority(weightThreshold: 1, keyAuths: {
        VIZPublicKey.fromString(
            'VIZ5mBeifuYe9gQKdZPLZ9Ps48i1EGpXBEQSTvBqTJ4PopVUWtyJL'): 1
      }),
      newMasterAuth: Authority(weightThreshold: 1, keyAuths: {
        VIZPublicKey.fromString(
            'VIZ7cjtcWktb6sqv5ehUcDUZre1jwCYWYkC35UYSek7eDVKwyKQSY'): 1
      }));

  trx.operations.add(recoverAccount);
  trx.sign(['<PRIVATE_ACTIVE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void changeRecoveryAccountExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  ChangeRecoveryAccount changeRecoveryAccount = ChangeRecoveryAccount(
      accountToRecover: AccountName('bob'),
      newRecoveryAccount: AccountName('god'));

  trx.operations.add(changeRecoveryAccount);
  trx.sign(['<PRIVATE_ACTIVE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void accountMetadataExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  AccountMetadata accountMetadata = AccountMetadata(
      account: AccountName('bob'), jsonMetadata: '{"test": "Hello World!"}');

  trx.operations.add(accountMetadata);
  //trx.sign(['<PRIVATE_REGULAR_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void accountCreateExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  AccountCreate accountCreate = AccountCreate(
      fee: VizAsset.fromString('1.000 VIZ'),
      delegation: SharesAsset.fromString('10.000000 SHARES'),
      newAccount: AccountName('bob'),
      creator: AccountName('alex'),
      master: Authority(weightThreshold: 1, keyAuths: {
        VIZPublicKey.fromString(
            'VIZ7cjtcWktb6sqv5ehUcDUZre1jwCYWYkC35UYSek7eDVKwyKQSY'): 1
      }),
      active: Authority(weightThreshold: 1, keyAuths: {
        VIZPublicKey.fromString(
            'VIZ7cjtcWktb6sqv5ehUcDUZre1jwCYWYkC35UYSek7eDVKwyKQSY'): 1
      }),
      regular: Authority(weightThreshold: 1, keyAuths: {
        VIZPublicKey.fromString(
            'VIZ7cjtcWktb6sqv5ehUcDUZre1jwCYWYkC35UYSek7eDVKwyKQSY'): 1
      }),
      memoKey: VIZPublicKey.fromString(
          'VIZ7cjtcWktb6sqv5ehUcDUZre1jwCYWYkC35UYSek7eDVKwyKQSY'),
      jsonMetadata: '{"test": "HelloWorld"}');

  trx.operations.add(accountCreate);
  trx.sign(['<PRIVATE_ACTIVE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}
