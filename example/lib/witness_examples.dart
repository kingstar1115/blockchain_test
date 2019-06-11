import 'package:viz_dart_ecc/viz_dart_ecc.dart';
import 'package:viz_transaction/viz_transaction.dart';

void main() {
  witnessUpdateExample();
  witnessVoteExample();
  witnessProxyExample();
  propertiesUpdateExample();
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
  trx.sign(['<PRIVATE_ACTIVE_KEY>']); //Sign transaction

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
  trx.sign(['<PRIVATE_ACTIVE_KEY>']); //Sign transaction

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
  trx.sign(['<PRIVATE_ACTIVE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}

void propertiesUpdateExample() {
  Transaction trx = Transaction();
  trx.refBlockNum = 46179;
  trx.refBlockPrefix = 1490075988;

  ChainPropertiesHf6 propertiesHf6 = ChainPropertiesHf6();
  propertiesHf6.witnessMissPenaltyDuration = Duration(seconds: 50);
  propertiesHf6.witnessMissPenaltyPercent = 1; //0.01%
  propertiesHf6.dataOperationsCostAdditionalBandwidth = 100;
  propertiesHf6.inflationRecalcPeriod = 120;
  propertiesHf6.inflationRatioCommitteeVsRewardFund = 5000;
  propertiesHf6.inflationWitnessPercent = 2000;
  propertiesHf6.bandwidthReserveBelow = SharesAsset(0);
  propertiesHf6.bandwidthReservePercent = 124;
  propertiesHf6.committeeRequestApproveMinPercent = 1000;
  propertiesHf6.createAccountDelegationRatio = 10;
  propertiesHf6.createAccountDelegationTime = Duration(days: 30);
  propertiesHf6.maximumBlockSize = CHAIN_MIN_BLOCK_SIZE_LIMIT + 1024;
  propertiesHf6.minDelegation = CHAIN_MIN_ACCOUNT_CREATION_FEE;
  propertiesHf6.voteAccountingMinRshares =
      SharesAsset.fromString('1.000000 SHARES');
  propertiesHf6.accountCreationFee = CHAIN_MIN_ACCOUNT_CREATION_FEE;

  VersionedChainPropertiesUpdate propertiesUpdate =
      VersionedChainPropertiesUpdate(
          owner: AccountName('bob'), props: propertiesHf6);
  trx.operations.add(propertiesUpdate);
  trx.sign(['<PRIVATE_ACTIVE_KEY>']); //Sign transaction

// And get a json string to broadcast in blockchain
  print(trx.toJsonString());
}
