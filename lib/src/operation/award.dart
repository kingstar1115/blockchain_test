import 'dart:typed_data';

import 'package:buffer/buffer.dart';

import '../exceptions.dart';
import '../json.dart';
import '../types.dart' show AccountName, Uint64, Memo, BeneficiaryRouteType;
import '../utils.dart';
import 'base_operatin.dart';

class Award implements BaseOperation, Jsonable<List<Object>> {
  AccountName initiator;
  AccountName receiver;

  ///original type is uint16_t
  int energy;
  Uint64 customSequence;
  Memo memo;
  List<BeneficiaryRouteType> beneficiaries;

  static int get ID => 47;

  Award(
      {this.initiator,
      this.receiver,
      this.energy,
      this.customSequence,
      this.memo,
      this.beneficiaries}) {
    _fillNullOptionalsFields();
  }

  Award.empty() {
    _fillNullOptionalsFields();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(initiator.toBytes());
    writer.write(receiver.toBytes());
    writer.write(BinaryUtils.transformUint16ToBytes(energy));
    writer.write(customSequence.toBytes());
    writer.write(memo.toBytes());
    writer.write(BinaryUtils.transformListToBytes(beneficiaries));
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();
    _fillNullOptionalsFields();
    _checkBeneficiaries();
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(initiator, 'initiator');
    InvalidParameterException.checkNotNull(receiver, 'receiver');
    InvalidParameterException.checkNotNull(energy, 'energy');
  }

  void _checkBeneficiaries() {
    if (beneficiaries.length > 127) {
      throw InvalidParameterException(beneficiaries.length, 'beneficiaries',
          'Cannot specify more than 127 beneficiaries.');
    }

    int weightSum = 0;

    for (BeneficiaryRouteType beneficiary in beneficiaries) {
      if (beneficiary.weight > 10000) {
        throw InvalidParameterException(
            beneficiary.weight,
            'beneficiary: ${beneficiary.account.name}',
            'Cannot share more than 100% of rewards to one account.');
      }

      weightSum += beneficiary.weight;
    }

    if (weightSum > 10000) {
      throw InvalidParameterException(weightSum, 'beneficiary',
          'Cannot share more than 100% of rewards for one award operation.');
    }
  }

  void _fillNullOptionalsFields() {
    if (customSequence == null) {
      customSequence = Uint64(BigInt.from(0));
    }

    if (memo == null) {
      memo = Memo('');
    }

    if (beneficiaries == null) {
      beneficiaries = [];
    }
  }

  @override
  List<Object> toJsonableObject() {
    List<Object> beneficiaries = [];

    for (BeneficiaryRouteType beneficiary in this.beneficiaries) {
      beneficiaries.add(beneficiary.toJsonableObject());
    }

    Map<String, Object> params = {
      'initiator': initiator.toString(),
      'receiver': receiver.toString(),
      'energy': energy,
      'custom_sequence': customSequence.toString(),
      'memo': memo.toString()
    };

    params['beneficiaries'] = beneficiaries;

    List<Object> operation = ['award'];
    operation.add(params);

    return operation;
  }
}
