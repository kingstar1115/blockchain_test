# viz-transaction

![GitHub](https://img.shields.io/github/license/VizTower/viz-transaction.svg)

Using this library you can easily create and sign transactions for Waves blockchain.
It also allows you to multi-sign existing transactions or create them without signature at all.

## Example transaction

Creates and signs a transaction with an ``award`` operation and without beneficiaries.

```dart
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  Transaction trx = Transaction(
      expiration: TimePointSec(DateTime.now().add(Duration(minutes: 30))),
      refBlockNum: 46179,
      refBlockPrefix: 1490075988); // now time + 30min

  Award award = Award(
      initiator: AccountName('<INITIATOR_LOGIN>'), //<INITIATOR_LOGIN>
      receiver: AccountName('<RECEIVER_LOGIN>'), //<RECEIVER_LOGIN>
      energy: 1000, // 10.00%
      customSequence:
          Uint64(BigInt.from(1234)), // Just any number, usually zero
      memo: Memo('Hello World'),
      beneficiaries: []);

  trx.operations.add(award);
  trx.sign(['<REGULAR_PRIVATE_KEY>']); //Sign transaction

  print(trx.toJson()); // And get a json string to broadcast in blockchain
}
```

And now let's do the same but with two beneficiaries.

```dart
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
  award.customSequence =
      Uint64(BigInt.from(1234)); // Just any number, usually zero
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

As you can see, an empty constructor was used for "award" operation, and then values were set. Just because it is possible.

## Example gets ref block num and prefix

As you can see, we set `` refBlockNum`` and `` refBlockPrefix`` manually, 
but in any case you need to get them from the block number (height)
and block identifier respectively. Fortunately, you can do this by simply calling the utils methods, 
as demonstrated below:

```dart
int refBlockNum = BlockchainUtils.getRefBlockNum(7097393);
int refBlockPrefix = BlockchainUtils.getRefBlockPrefix("006c4c314a0c19918caa3187abdebfeeb56724b1");
```

See more examples in the ``example`` folder.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/VizTower/viz-transaction/issues
