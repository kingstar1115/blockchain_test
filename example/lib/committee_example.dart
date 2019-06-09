import 'package:viz_transaction/viz_transaction.dart';

void main() {
  committeeCreateRequestExample();
  cancelRequestExample();
  voteRequestExample();
}

void committeeCreateRequestExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  CommitteeWorkerCreateRequest committeeCreateRequest =
      CommitteeWorkerCreateRequest(
          creator: AccountName('<ACCOUNT_NAME>'),
          worker: AccountName('<ACCOUNT_NAME>'),
          maxRequiredAmount: VizAsset.fromString('1000000.000 VIZ'),
          url: MiniUrl('https://example.com'),
          duration: 5);

  trx.operations.add(committeeCreateRequest);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void cancelRequestExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  CommitteeWorkerCancelRequest cancelRequest = CommitteeWorkerCancelRequest(
      creator: AccountName('<ACCOUNT_NAME>'), requestId: 123);

  trx.operations.add(cancelRequest);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void voteRequestExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  CommitteeVoteRequest voteRequest = CommitteeVoteRequest(
      voter: AccountName('<ACCOUNT_NAME>'), votePercent: -234, requestId: 9678);

  trx.operations.add(voteRequest);
  trx.sign(['<REGULAR_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}
