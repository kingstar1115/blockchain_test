import 'package:viz_dart_ecc/viz_dart_ecc.dart';
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  witnessUpdateExample();
  witnessVoteExample();
  witnessProxyExample();
}

void witnessUpdateExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  WitnessUpdate witnessUpdate = WitnessUpdate(
      owner: AccountName('bob'),
      url: MemoUrl('https://example.com'),
      key: VIZPublicKey.fromString(
          'VIZ7cjtcWktb6sqv5ehUcDUZre1jwCYWYkC35UYSek7eDVKwyKQSY'));

  trx.operations.add(witnessUpdate);
  //trx.sign(['<PRIVATE_ACTIVE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void witnessVoteExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  AccountWitnessVote witnessVote = AccountWitnessVote(
      account: AccountName('alex'), witness: AccountName('god'));

  trx.operations.add(witnessVote);
  //trx.sign(['<PRIVATE_ACTIVE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void witnessProxyExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  AccountWitnessProxy witnessProxy = AccountWitnessProxy(
      account: AccountName('bob'), proxy: AccountName('alex'));

  trx.operations.add(witnessProxy);
  //trx.sign(['<PRIVATE_ACTIVE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}
