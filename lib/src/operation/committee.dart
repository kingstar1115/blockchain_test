import 'dart:typed_data';

import 'package:buffer/buffer.dart';

import '../exceptions.dart';
import '../json.dart';
import '../operations.dart';
import '../types.dart';
import '../utils.dart';

const COMMITTEE_MIN_DURATION = 5;
const COMMITTEE_MAX_DURATION = 30;

/// A half of initial initial supply(50 000 000.000 VIZ / 2 = 25 000 000.000 VIZ)
const int COMMITTEE_MAX_REQUIRED_AMOUNT = 25000000000;

class CommitteeWorkerCreateRequest
    implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 35;

  AccountName creator;
  AccountName worker;
  VizAsset minRequiredAmount;
  VizAsset maxRequiredAmount;
  MiniUrl url;

  ///uint32
  int duration;

  CommitteeWorkerCreateRequest(
      {this.creator,
      this.worker,
      this.minRequiredAmount,
      this.maxRequiredAmount,
      this.url,
      this.duration}) {
    _fillOptionalField();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(creator.toBytes());
    writer.write(url.toBytes());
    writer.write(worker.toBytes());
    writer.write(minRequiredAmount.toBytes());
    writer.write(maxRequiredAmount.toBytes());
    writer.write(BinaryUtils.transformUint32ToBytes(duration * 24 * 60 * 60));
    return writer.toBytes();
  }

  @override
  void validate() {
    _fillOptionalField();
    _checkNulls();

    if (url.value.isEmpty) {
      throw InvalidParameterException(url.value, 'url', 'URL cannot be empty');
    }

    if (duration < COMMITTEE_MIN_DURATION ||
        duration > COMMITTEE_MAX_DURATION) {
      throw InvalidParameterException(duration, 'duration',
          'Duration must be in range $COMMITTEE_MIN_DURATION to $COMMITTEE_MAX_DURATION');
    }

    if (maxRequiredAmount.amount > COMMITTEE_MAX_REQUIRED_AMOUNT) {
      throw InvalidParameterException(maxRequiredAmount, 'maxRequiredAmount',
          'A max required amount cannot be greater than $COMMITTEE_MAX_REQUIRED_AMOUNT');
    }

    if (maxRequiredAmount.amount < minRequiredAmount.amount) {
      throw InvalidParameterException(maxRequiredAmount, 'maxRequiredAmount',
          'A max required amount cannot be less than $minRequiredAmount');
    }
  }

  void _fillOptionalField() {
    if (minRequiredAmount == null) {
      minRequiredAmount = VizAsset(0);
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(creator, 'creator');
    InvalidParameterException.checkNotNull(url, 'url');
    InvalidParameterException.checkNotNull(worker, 'worker');
    InvalidParameterException.checkNotNull(
        maxRequiredAmount, 'maxRequiredAmount');
    InvalidParameterException.checkNotNull(duration, 'duration');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'creator': creator.toString(),
      'url': url.toString(),
      'worker': worker.toString(),
      'required_amount_min': minRequiredAmount.toString(),
      'required_amount_max': maxRequiredAmount.toString(),
      'duration': duration * 24 * 60 * 60
    };
    print('post params');

    List<Object> operation = ['committee_worker_create_request'];
    operation.add(params);
    print('post opertations');

    return operation;
  }
}

class CommitteeWorkerCancelRequest
    implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 36;

  AccountName creator;

  ///uint32
  int requestId;

  CommitteeWorkerCancelRequest({this.creator, this.requestId});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(creator.toBytes());
    writer.write(BinaryUtils.transformUint32ToBytes(requestId));
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(creator, 'creator');
    InvalidParameterException.checkNotNull(requestId, 'requestId');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'creator': creator.toString(),
      'request_id': requestId
    };
    List<Object> operation = ['committee_worker_cancel_request'];
    operation.add(params);

    return operation;
  }
}

class CommitteeVoteRequest implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 37;

  AccountName voter;

  ///uint32
  int requestId;

  ///int16
  int votePercent;

  CommitteeVoteRequest({this.voter, this.requestId, this.votePercent});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(voter.toBytes());
    writer.write(BinaryUtils.transformUint32ToBytes(requestId));
    writer.write(BinaryUtils.transformInt16ToBytes(votePercent));
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();

    if (votePercent < -10000 || votePercent > 10000) {
      throw InvalidParameterException(votePercent, 'votePercent',
          'A vote percent must be in range -10 000(-100%) to 10 000(100%)');
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(voter, 'voter');
    InvalidParameterException.checkNotNull(requestId, 'requestId');
    InvalidParameterException.checkNotNull(votePercent, 'votePercent');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'voter': voter.toString(),
      'request_id': requestId,
      'vote_percent': votePercent
    };

    List<Object> operation = ['committee_vote_request'];
    operation.add(params);

    return operation;
  }
}
