import 'package:viz_transaction/viz_transaction.dart';
import 'package:viz_dart_ecc/viz_dart_ecc.dart';

void main() {
  createInviteExample();
  claimInviteBalanceExample();
  inviteRegistrationExample();
}

void createInviteExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  CreateInvite createInvite = CreateInvite(
      creator: AccountName('<ACCOUNT_NAME'),
      balance: VizAsset.fromString('2345.000 VIZ'),
      inviteKeyPubKey: VIZPublicKey.fromString('<ANY_PUBLIC_KEY>'));

  trx.operations.add(createInvite);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

  // And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void claimInviteBalanceExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  ClaimInviteBalance claimInviteBalance = ClaimInviteBalance(
      receiver: AccountName('alex'),
      initiator: AccountName('bob'),
      secret: VIZPrivateKey.fromString('<PRIVATE_KEY_FOR_INVITE>'));

  trx.operations.add(claimInviteBalance);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void inviteRegistrationExample() {
  Transaction trx = Transaction(refBlockNum: 46179, refBlockPrefix: 1490075988);

  InviteRegistration inviteRegistration = InviteRegistration(
      initiator: AccountName('bob'),
      newAccount: AccountName('alex'),
      newAccountPubKey: VIZPublicKey.fromString('<PUBLIC_KEY_FOR_NEW_ACCOUNT>'),
      secret: VIZPrivateKey.fromString('<PRIVATE_KEY_FOR_INVITE>'));

  trx.operations.add(inviteRegistration);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}
