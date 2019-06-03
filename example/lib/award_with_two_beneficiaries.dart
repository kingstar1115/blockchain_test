/// In this example, a [Award] transaction with two beneficiaries will be created and signed.
/// Also, an empty constructors for [Award] operation and [Transaction] will be used as an example,
/// and then values will be set.

import 'package:viz_transaction/viz_transaction.dart';

void main() {
  Transaction trx = Transaction.empty();
  trx.expiration = TimePointSec(
      DateTime.now().add(Duration(minutes: 30))); // now time + 30min
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  Award award = Award.empty();
  award.initiator = AccountName('<INITIATOR_LOGIN>');
  award.receiver = AccountName('<RECEIVER_LOGIN>');
  award.energy = 1000; // 10.00%
  award.memo = Memo('Hello World');
  award.beneficiaries = [
    BeneficiaryRouteType(AccountName('<BENEFICIARY_ONE>'),
        50), // Share 0.50% with BENEFICIARY_ONE
    BeneficiaryRouteType(AccountName('<BENEFICIARY_TWO>'),
        50) // Share 0.50% with BENEFICIARY_TWO
  ];

  trx.operations.add(award);
  trx.sign(['<REGULAR_PRIVATE_KEY>']); //Sign transaction

  // And get a json string to broadcast in blockchain
  print(trx.toJson());
}
