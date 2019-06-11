import 'dart:typed_data';

import 'package:buffer/buffer.dart';

import '../chain_conf.dart';
import '../exceptions.dart';
import '../json.dart';
import '../types.dart';
import '../utils.dart' show BinaryUtils;
import 'base_type.dart';

abstract class BaseChainProperty implements BaseType, Jsonable<List<Object>> {
  int get index;

  @override
  Uint8List toBytes() {
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(index));
    return writer.toBytes();
  }
}

class ChainPropertiesInit extends BaseChainProperty {
  @override
  int get index => 0;

  ///int16
  final int _minCurationPercent = 0;

  ///int16
  final int _maxCurationPercent = 0;

  ///int16
  final int _flagEnergyAdditionalCost = 0;

  VizAsset accountCreationFee;

  ///uint32
  int maximumBlockSize;

  ///uint32
  int createAccountDelegationRatio;
  Duration createAccountDelegationTime;
  VizAsset minDelegation;

  ///int16
  int bandwidthReservePercent;
  SharesAsset bandwidthReserveBelow;
  SharesAsset voteAccountingMinRshares;

  ///int16
  int committeeRequestApproveMinPercent;

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(super.toBytes());
    writer.write(accountCreationFee.toBytes());
    writer.write(BinaryUtils.transformUint32ToBytes(maximumBlockSize));
    writer.write(
        BinaryUtils.transformUint32ToBytes(createAccountDelegationRatio));
    writer.write(BinaryUtils.transformUint32ToBytes(
        createAccountDelegationTime.inSeconds));
    writer.write(minDelegation.toBytes());
    writer.write(BinaryUtils.transformInt16ToBytes(_minCurationPercent));
    writer.write(BinaryUtils.transformInt16ToBytes(_maxCurationPercent));
    writer.write(BinaryUtils.transformInt16ToBytes(bandwidthReservePercent));
    writer.write(bandwidthReserveBelow.toBytes());
    writer.write(BinaryUtils.transformInt16ToBytes(_flagEnergyAdditionalCost));
    writer.write(
        BinaryUtils.transformUint32ToBytes(voteAccountingMinRshares.amount));
    writer.write(
        BinaryUtils.transformInt16ToBytes(committeeRequestApproveMinPercent));
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();

    if (accountCreationFee.amount < CHAIN_MIN_ACCOUNT_CREATION_FEE.amount) {
      throw InvalidParameterException(
          accountCreationFee.amount,
          'accountCreationFee.amount',
          'An account creation fee must be greater than ${CHAIN_MIN_ACCOUNT_CREATION_FEE.toString()}');
    }

    if (maximumBlockSize < CHAIN_MIN_BLOCK_SIZE_LIMIT ||
        maximumBlockSize > CHAIN_MAX_BLOCK_SIZE_LIMIT) {
      throw InvalidParameterException(maximumBlockSize, 'maximumBlockSize',
          'A maximum block size must be in range $CHAIN_MIN_BLOCK_SIZE_LIMIT to $CHAIN_MAX_BLOCK_SIZE_LIMIT');
    }

    if (createAccountDelegationRatio <= 0) {
      throw InvalidParameterException(
          createAccountDelegationRatio,
          'createAccountDelegationRatio',
          'A maximum block size must be greater than zero');
    }

    if (createAccountDelegationTime < CHAIN_MIN_DELEGATION_TIME) {
      throw InvalidParameterException(
          createAccountDelegationTime.inSeconds,
          'createAccountDelegationTime',
          'A createAccountDelegationTime must be greater than '
              '${CHAIN_MIN_DELEGATION_TIME.inDays} days(${CHAIN_MIN_DELEGATION_TIME.inSeconds} sec).');
    }

    if (minDelegation.amount < 0) {
      throw InvalidParameterException(minDelegation.amount, 'minDelegation',
          'A minDelegation must be greater than zero');
    }

    if (bandwidthReservePercent < 0 || bandwidthReservePercent > 10000) {
      throw InvalidParameterException(
          bandwidthReservePercent,
          'bandwidthReservePercent',
          'A bandwidthReservePercent must be in range 0(0%) to 10000(100%)');
    }

    if (bandwidthReserveBelow.amount < 0) {
      throw InvalidParameterException(
          bandwidthReserveBelow.amount,
          'bandwidthReserveBelow',
          'A bandwidthReserveBelow must be greater or equals zero');
    }

    if (committeeRequestApproveMinPercent < 0 ||
        committeeRequestApproveMinPercent > 10000) {
      throw InvalidParameterException(
          committeeRequestApproveMinPercent,
          'committeeRequestApproveMinPercent',
          'A committeeRequestApproveMinPercent must be in range 0(0%) to 10000(100%)');
    }

    if (voteAccountingMinRshares.amount < 0) {
      throw InvalidParameterException(
          voteAccountingMinRshares.amount,
          'voteAccountingMinRshares',
          'A bandwidthReserveBelow must be greater or equals zero');
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(
        accountCreationFee, 'accountCreationFee');
    InvalidParameterException.checkNotNull(
        maximumBlockSize, 'maximumBlockSize');
    InvalidParameterException.checkNotNull(
        createAccountDelegationRatio, 'createAccountDelegationRatio');
    InvalidParameterException.checkNotNull(
        createAccountDelegationTime, 'createAccountDelegationTime');
    InvalidParameterException.checkNotNull(minDelegation, 'minDelegation');
    InvalidParameterException.checkNotNull(
        bandwidthReservePercent, 'minDelegation');
    InvalidParameterException.checkNotNull(
        bandwidthReserveBelow, 'minDelegation');
    InvalidParameterException.checkNotNull(
        voteAccountingMinRshares, 'minDelegation');
    InvalidParameterException.checkNotNull(
        committeeRequestApproveMinPercent, 'minDelegation');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    List<Object> operation = [index];
    operation.add(getJsonParams());
    return operation;
  }

  Map<String, Object> getJsonParams() {
    return {
      'account_creation_fee': accountCreationFee.toString(),
      'maximum_block_size': maximumBlockSize,
      'create_account_delegation_ratio': createAccountDelegationRatio,
      'create_account_delegation_time': createAccountDelegationTime.inSeconds,
      'min_delegation': minDelegation.toString(),
      'min_curation_percent': _minCurationPercent,
      'max_curation_percent': _maxCurationPercent,
      'bandwidth_reserve_percent': bandwidthReservePercent,
      'bandwidth_reserve_below': bandwidthReserveBelow.toString(),
      'flag_energy_additional_cost': _flagEnergyAdditionalCost,
      'vote_accounting_min_rshares': voteAccountingMinRshares.amount,
      'committee_request_approve_min_percent': committeeRequestApproveMinPercent
    };
  }
}

class ChainPropertiesHf4 extends ChainPropertiesInit {
  @override
  int get index => 1;

  ///int16
  int inflationWitnessPercent;

  ///int16
  int inflationRatioCommitteeVsRewardFund;

  ///uint32
  ///blocks count
  int inflationRecalcPeriod;

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(super.toBytes());
    writer.write(BinaryUtils.transformInt16ToBytes(inflationWitnessPercent));
    writer.write(
        BinaryUtils.transformInt16ToBytes(inflationRatioCommitteeVsRewardFund));
    writer.write(BinaryUtils.transformUint32ToBytes(inflationRecalcPeriod));
    return writer.toBytes();
  }

  @override
  void validate() {
    super.validate();
    _checkNulls();

    if (inflationWitnessPercent < 0 || inflationWitnessPercent > 10000) {
      throw InvalidParameterException(
          inflationWitnessPercent,
          'inflationWitnessPercent',
          'A inflationWitnessPercent must be in range 0(0%) to 10000(100%)');
    }

    if (inflationRatioCommitteeVsRewardFund < 0 ||
        inflationRatioCommitteeVsRewardFund > 10000) {
      throw InvalidParameterException(
          inflationRatioCommitteeVsRewardFund,
          'inflationRatioCommitteeVsRewardFund',
          'A inflationRatioCommitteeVsRewardFund must be in range 0(0%) to 10000(100%)');
    }

    if (inflationRecalcPeriod < 0 ||
        inflationRecalcPeriod > CHAIN_BLOCKS_PER_YEAR) {
      throw InvalidParameterException(
          inflationRecalcPeriod,
          'inflationRecalcPeriod',
          'A inflationRecalcPeriod must be in range 0 to $CHAIN_BLOCKS_PER_YEAR');
    }
  }

  void _checkNulls() {
    super._checkNulls();
    InvalidParameterException.checkNotNull(
        inflationRecalcPeriod, 'inflationRecalcPeriod');
    InvalidParameterException.checkNotNull(inflationRatioCommitteeVsRewardFund,
        'inflationRatioCommitteeVsRewardFund');
    InvalidParameterException.checkNotNull(
        inflationWitnessPercent, 'inflationWitnessPercent');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    List<Object> operation = [index];
    operation.add(getJsonParams());

    return operation;
  }

  Map<String, Object> getJsonParams() {
    Map<String, Object> params = super.getJsonParams();
    params['inflation_witness_percent'] = inflationWitnessPercent;
    params['inflation_ratio_committee_vs_reward_fund'] =
        inflationRatioCommitteeVsRewardFund;
    params['inflation_recalc_period'] = inflationRecalcPeriod;

    return params;
  }
}

class ChainPropertiesHf6 extends ChainPropertiesHf4 {
  @override
  int get index => 2;

  ///uint32
  int dataOperationsCostAdditionalBandwidth;

  ///int16
  int witnessMissPenaltyPercent;

  Duration witnessMissPenaltyDuration;

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(super.toBytes());
    writer.write(BinaryUtils.transformUint32ToBytes(
        dataOperationsCostAdditionalBandwidth));
    writer.write(BinaryUtils.transformInt16ToBytes(witnessMissPenaltyPercent));
    writer.write(BinaryUtils.transformUint32ToBytes(
        witnessMissPenaltyDuration.inSeconds));
    return writer.toBytes();
  }

  @override
  void validate() {
    super.validate();
    _checkNulls();

    if (witnessMissPenaltyPercent < 0 || witnessMissPenaltyPercent > 10000) {
      throw InvalidParameterException(
          inflationWitnessPercent,
          'inflationWitnessPercent',
          'A inflationWitnessPercent must be in range 0(0%) to 10000(100%)');
    }

    if (dataOperationsCostAdditionalBandwidth < 0) {
      throw InvalidParameterException(
          dataOperationsCostAdditionalBandwidth,
          'dataOperationsCostAdditionalBandwidth',
          'A dataOperationsCostAdditionalBandwidth must be'
              ' greater or equals zero');
    }

    if (witnessMissPenaltyDuration.inSeconds < 0 ||
        witnessMissPenaltyDuration.inSeconds >
            CHAIN_BLOCKS_PER_YEAR * CHAIN_BLOCK_INTERVAL) {
      throw InvalidParameterException(
          witnessMissPenaltyDuration.inSeconds,
          'witnessMissPenaltyDuration',
          'A witnessMissPenaltyDuration must be in range '
              '0 to ${CHAIN_BLOCKS_PER_YEAR * CHAIN_BLOCK_INTERVAL} sec');
    }
  }

  void _checkNulls() {
    super._checkNulls();
    InvalidParameterException.checkNotNull(
        dataOperationsCostAdditionalBandwidth,
        'dataOperationsCostAdditionalBandwidth');
    InvalidParameterException.checkNotNull(
        witnessMissPenaltyPercent, 'witnessMissPenaltyPercent');
    InvalidParameterException.checkNotNull(
        witnessMissPenaltyDuration, 'witnessMissPenaltyDuration');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    List<Object> operation = [index];
    operation.add(getJsonParams());

    return operation;
  }

  Map<String, Object> getJsonParams() {
    Map<String, Object> params = super.getJsonParams();
    params['data_operations_cost_additional_bandwidth'] =
        dataOperationsCostAdditionalBandwidth;
    params['witness_miss_penalty_percent'] = witnessMissPenaltyPercent;
    params['witness_miss_penalty_duration'] = witnessMissPenaltyDuration.inSeconds;

    return params;
  }
}
