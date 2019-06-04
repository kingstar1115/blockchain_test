## Example transfer

Signing ``transfer`` operations with viz-transaction is very simple:

```dart
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
```

## Example award

What about creating and signing a transaction with an ``award`` operation? Let's do it without beneficiaries.

```dart
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  Transaction trx = Transaction(
      refBlockNum: 46179,
      refBlockPrefix: 1490075988);

  Award award = Award(
      initiator: AccountName('<INITIATOR_LOGIN>'),
      receiver: AccountName('<RECEIVER_LOGIN>'),
      energy: 1000, // 10.00%
      memo: Memo('Hello World'));

  trx.operations.add(award);
  trx.sign(['<REGULAR_PRIVATE_KEY>']); //Sign transaction

  print(trx.toJson()); // And get a json string to broadcast in blockchain
}
```

And now let's do the same but with two beneficiaries.

```dart
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  Award award = Award();
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
```

As you may have noticed, an empty constructor was used for "award" operation, and then values were set. Just because it is possible.

## Example gets ref block num and prefix

As you can see, we set `` refBlockNum`` and `` refBlockPrefix`` manually, 
but in any case you need to get them from the block number (height)
and block identifier respectively. Fortunately, you can do this by simply calling the utils methods, 
as demonstrated below:

```dart
int refBlockNum = BlockchainUtils.getRefBlockNum(7097393);
int refBlockPrefix = BlockchainUtils.getRefBlockPrefix("006c4c314a0c19918caa3187abdebfeeb56724b1");
```

See more examples in the ``example/lib`` folder.