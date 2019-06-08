import 'dart:typed_data';

import 'package:buffer/buffer.dart';

import '../exceptions.dart';
import '../json.dart';
import '../operations.dart';
import '../types.dart';
import '../utils.dart';

class EscrowTransfer implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 15;

  AccountName initiator;
  AccountName receiver;
  AccountName agent;

  ///uint32
  int escrowId;

  VizAsset tokenAmount;
  VizAsset fee;

  TimePointSec ratificationDeadline;
  TimePointSec escrowExpiration;

  String jsonMetadata;

  EscrowTransfer(
      {this.initiator,
      this.receiver,
      this.agent,
      this.tokenAmount,
      this.fee,
      this.ratificationDeadline,
      this.escrowExpiration,
      this.escrowId,
      this.jsonMetadata}) {
    _fillOptionalField();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));

    writer.write(initiator.toBytes());
    writer.write(receiver.toBytes());
    writer.write(tokenAmount.toBytes());
    writer.write(BinaryUtils.transformUint32ToBytes(escrowId));
    writer.write(agent.toBytes());
    writer.write(fee.toBytes());
    writer.write(BinaryUtils.transformStringToVarIntBytes(jsonMetadata));
    writer.write(ratificationDeadline.toBytes());
    writer.write(escrowExpiration.toBytes());
    return writer.toBytes();
  }

  @override
  void validate() {
    _fillOptionalField();
    _checkNulls();

    if (initiator == agent || receiver == agent) {
      throw InvalidParameterException(
          agent.toString(), 'agent', 'An agent must be a third party');
    }

    if (ratificationDeadline > escrowExpiration) {
      throw InvalidParameterException(
          ratificationDeadline,
          'ratificationDeadline',
          'A ratification deadline cannot be greater than an escrow expiration');
    }
  }

  void _fillOptionalField() {
    if (jsonMetadata == null) {
      jsonMetadata = '{}';
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(initiator, 'initiatro');
    InvalidParameterException.checkNotNull(receiver, 'receiver');
    InvalidParameterException.checkNotNull(agent, 'agent');
    InvalidParameterException.checkNotNull(escrowId, 'escrowId');
    InvalidParameterException.checkNotNull(tokenAmount, 'tokenAmount');
    InvalidParameterException.checkNotNull(fee, 'fee');
    InvalidParameterException.checkNotNull(
        ratificationDeadline, 'ratificationDeadline');
    InvalidParameterException.checkNotNull(
        escrowExpiration, 'ratificationDeadline');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'from': initiator.toString(),
      'to': receiver.toString(),
      'agent': agent.toString(),
      'escrow_id': escrowId,
      'token_amount': tokenAmount.toString(),
      'fee': fee.toString(),
      'ratification_deadline': ratificationDeadline.toString(),
      'escrow_expiration': escrowExpiration.toString(),
      'json_metadata': jsonMetadata
    };

    List<Object> operation = ['escrow_transfer'];
    operation.add(params);

    return operation;
  }
}

class EscrowDispute implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 16;

  AccountName escrowInitiator;
  AccountName receiver;
  AccountName agent;
  AccountName who;

  ///uint32
  int escrowId;

  EscrowDispute(
      {this.escrowInitiator,
      this.receiver,
      this.agent,
      this.who,
      this.escrowId});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(escrowInitiator.toBytes());
    writer.write(receiver.toBytes());
    writer.write(agent.toBytes());
    writer.write(who.toBytes());
    writer.write(BinaryUtils.transformUint32ToBytes(escrowId));
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();

    if (who != escrowInitiator && who != receiver) {
      throw InvalidParameterException(who, 'who',
          'Only the escrow initiator or receiver can initiate a dispute');
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(escrowInitiator, 'escrowInitiator');
    InvalidParameterException.checkNotNull(receiver, 'receiver');
    InvalidParameterException.checkNotNull(agent, 'agent');
    InvalidParameterException.checkNotNull(who, 'who');
    InvalidParameterException.checkNotNull(escrowId, 'escrowId');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'from': escrowInitiator.toString(),
      'to': receiver.toString(),
      'agent': agent.toString(),
      'who': who.toString(),
      'escrow_id': escrowId
    };

    List<Object> operation = ['escrow_dispute'];
    operation.add(params);

    return operation;
  }
}

class EscrowRelease implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 17;

  AccountName escrowInitiator;
  AccountName receiver;
  AccountName agent;
  AccountName who;

  AccountName tokensReceiver;
  VizAsset tokenAmount;

  ///uint32
  int escrowId;

  EscrowRelease(
      {this.escrowInitiator,
      this.receiver,
      this.agent,
      this.who,
      this.tokensReceiver,
      this.tokenAmount,
      this.escrowId});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(escrowInitiator.toBytes());
    writer.write(receiver.toBytes());
    writer.write(agent.toBytes());
    writer.write(who.toBytes());
    writer.write(tokensReceiver.toBytes());
    writer.write(BinaryUtils.transformUint32ToBytes(escrowId));
    writer.write(tokenAmount.toBytes());
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();

    if (who != escrowInitiator && who != receiver && who != agent) {
      throw InvalidParameterException(who, 'who',
          'The escrow initiator or receiver or agent can initiate release operation');
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(escrowInitiator, 'escrowInitiator');
    InvalidParameterException.checkNotNull(receiver, 'receiver');
    InvalidParameterException.checkNotNull(agent, 'agent');
    InvalidParameterException.checkNotNull(tokensReceiver, 'tokensReceiver');
    InvalidParameterException.checkNotNull(escrowId, 'escrowId');
    InvalidParameterException.checkNotNull(tokenAmount, 'tokenAmount');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'from': escrowInitiator.toString(),
      'to': receiver.toString(),
      'agent': agent.toString(),
      'who': who.toString(),
      'receiver': tokensReceiver.toString(),
      'escrow_id': escrowId,
      'token_amount': tokenAmount.toString(),
    };

    List<Object> operation = ['escrow_release'];
    operation.add(params);

    return operation;
  }
}

class EscrowApprove implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 18;

  AccountName escrowInitiator;
  AccountName receiver;
  AccountName agent;
  AccountName who;

  ///uint32
  int escrowId;
  bool approve;

  EscrowApprove(
      {this.escrowInitiator,
      this.receiver,
      this.agent,
      this.who,
      this.escrowId,
      this.approve});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(escrowInitiator.toBytes());
    writer.write(receiver.toBytes());
    writer.write(agent.toBytes());
    writer.write(who.toBytes());
    writer.write(BinaryUtils.transformUint32ToBytes(escrowId));
    writer.writeUint8(approve ? 1 : 0);
    return writer.toBytes();
  }

  @override
  void validate() {
    _fillOptionalField();
    _checkNulls();

    if (who != agent && who != receiver) {
      throw InvalidParameterException(who, 'who',
          'Only the agent or receiver can initiate approve operation');
    }
  }

  void _fillOptionalField() {
    if (approve == null) {
      approve = true;
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(escrowInitiator, 'escrowInitiator');
    InvalidParameterException.checkNotNull(receiver, 'receiver');
    InvalidParameterException.checkNotNull(agent, 'agent');
    InvalidParameterException.checkNotNull(who, 'who');
    InvalidParameterException.checkNotNull(escrowId, 'escrowId');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'from': escrowInitiator.toString(),
      'to': receiver.toString(),
      'agent': agent.toString(),
      'who': who.toString(),
      'escrow_id': escrowId,
      'approve': approve
    };

    List<Object> operation = ['escrow_approve'];
    operation.add(params);

    return operation;
  }
}
