import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:viz_dart_ecc/viz_dart_ecc.dart';

import '../exceptions.dart';
import '../json.dart';
import '../types.dart';
import '../utils.dart';
import 'base_operatin.dart';

class CreateInvite implements BaseOperation, Jsonable<List<Object>> {
  AccountName creator;
  VizAsset balance;
  VIZPublicKey inviteKeyPubKey;

  static const ID = 43;

  CreateInvite({this.creator, this.balance, this.inviteKeyPubKey});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(creator.toBytes());
    writer.write(balance.toBytes());
    writer.write(inviteKeyPubKey.toBuffer());
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();

    if (balance.amount <= 0) {
      throw InvalidParameterException(balance.amount, 'balance.amount',
          'Invite creation balance must be nonzero amount');
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(creator, 'creator');
    InvalidParameterException.checkNotNull(balance, 'balance');
    InvalidParameterException.checkNotNull(inviteKeyPubKey, 'inviteKeyPubKey');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'creator': creator.toString(),
      'balance': balance.toString(),
      'invite_key': inviteKeyPubKey.toString()
    };

    List<Object> operation = ['create_invite'];
    operation.add(params);

    return operation;
  }
}

class ClaimInviteBalance implements BaseOperation, Jsonable<List<Object>> {
  AccountName initiator;
  AccountName receiver;
  VIZPrivateKey secret;

  static const ID = 44;

  ClaimInviteBalance({this.initiator, this.receiver, this.secret});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(initiator.toBytes());
    writer.write(receiver.toBytes());
    writer.write(BinaryUtils.transformStringToVarIntBytes(secret.toString()));
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(initiator, 'initiator');
    InvalidParameterException.checkNotNull(receiver, 'receiver');
    InvalidParameterException.checkNotNull(secret, 'secret');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'initiator': initiator.toString(),
      'receiver': receiver.toString(),
      'invite_secret': secret.toString()
    };

    List<Object> operation = ['claim_invite_balance'];
    operation.add(params);

    return operation;
  }
}

class InviteRegistration implements BaseOperation, Jsonable<List<Object>> {
  AccountName initiator;
  AccountName newAccount;
  VIZPublicKey newAccountPubKey;
  VIZPrivateKey secret;

  static const ID = 45;

  InviteRegistration(
      {this.initiator, this.newAccount, this.newAccountPubKey, this.secret});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(initiator.toBytes());
    writer.write(newAccount.toBytes());
    writer.write(BinaryUtils.transformStringToVarIntBytes(secret.toString()));
    writer.write(newAccountPubKey.toBuffer());
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(initiator, 'initiator');
    InvalidParameterException.checkNotNull(newAccount, 'newAccount');
    InvalidParameterException.checkNotNull(
        newAccountPubKey, 'newAccountPubKey');
    InvalidParameterException.checkNotNull(secret, 'secret');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'initiator': initiator.toString(),
      'new_account_name': newAccount.toString(),
      'invite_secret': secret.toString(),
      'new_account_key': newAccountPubKey.toString()
    };

    List<Object> operation = ['invite_registration'];
    operation.add(params);

    return operation;
  }
}
