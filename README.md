# viz-transaction

![Logo](https://raw.githubusercontent.com/Ivanzar/viz-transaction/master/img/viz-transaction%20logo.png)

![GitHub](https://img.shields.io/github/license/VizTower/viz-transaction.svg)
[![Build Status](https://travis-ci.com/VizTower/viz-transaction.svg?branch=master)](https://travis-ci.com/VizTower/viz-transaction)
![Pub](https://img.shields.io/pub/v/viz_transaction.svg)
![GitHub stars](https://img.shields.io/github/stars/VizTower/viz-transaction.svg?style=social)

[issue tracker][tracker] | [API](https://pub.dev/documentation/viz_transaction/latest/)

Using this library you can easily create and sign transactions for VIZ blockchain.
It also allows you to multi-sign existing transactions or create them without signature at all.

**NOTE:** You cannot broadcast transactions to the blockchain using this library. Only serialization and signing.
To send transactions to the network, use any other http/ws-library

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
      amount: VizAsset.fromString('1.000 VIZ'),
      memo: Memo('Hello world!'));

  trx.operations.add(transfer);
  trx.sign(['<ACTIVE_PRIVATE_KEY>']); //Sign transaction

  // And get a json string to broadcast in blockchain
  print(trx.toJsonString());
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

  print(trx.toJsonString()); // And get a json string to broadcast in blockchain
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
  print(trx.toJsonString());
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

See more examples in the ``example`` folder.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/VizTower/viz-transaction/issues
