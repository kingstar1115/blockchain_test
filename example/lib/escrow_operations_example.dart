import 'package:convert/convert.dart';
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  escrowTransferExample();
  escrowDisputeExample();
  escrowReleaseExample();
  escrowApproveExample();
}

void escrowTransferExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 6728;
  trx.refBlockPrefix = 555943754;

  EscrowTransfer escrowTransfer = EscrowTransfer(
      initiator: AccountName('bob'),
      receiver: AccountName('alex'),
      agent: AccountName('god'),
      tokenAmount: VizAsset.fromString('100.000 VIZ'),
      fee: VizAsset.fromString('7.000 VIZ'),
      escrowId: 30,
      ratificationDeadline:
          TimePointSec(DateTime.now().add(Duration(hours: 2))),
      escrowExpiration: TimePointSec(DateTime.now().add(Duration(days: 5))),
      jsonMetadata: '{"mess": "Hello Wordl!"}');

  trx.operations.add(escrowTransfer);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void escrowDisputeExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  EscrowDispute escrowDispute = EscrowDispute(
      escrowId: 777,
      escrowInitiator: AccountName('bob'),
      receiver: AccountName('alex'),
      agent: AccountName('god'),
      who: AccountName('alex'));

  trx.operations.add(escrowDispute);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void escrowReleaseExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  EscrowRelease escrowRelease = EscrowRelease(
      escrowInitiator: AccountName('bob'),
      receiver: AccountName('alex'),
      agent: AccountName('god'),
      who: AccountName('god'),
      escrowId: 78545,
      tokenAmount: VizAsset.fromString('7856.000 VIZ'),
      tokensReceiver: AccountName('alex'));

  trx.operations.add(escrowRelease);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void escrowApproveExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  EscrowApprove escrowApprove = EscrowApprove(
      escrowInitiator: AccountName('bob'),
      receiver: AccountName('alex'),
      agent: AccountName('god'),
      who: AccountName('alex'),
      escrowId: 9886,
      approve: true);

  trx.operations.add(escrowApprove);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}
