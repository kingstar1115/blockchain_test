import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:viz_dart_ecc/viz_dart_ecc.dart';

import '../exceptions.dart';
import '../json.dart';
import '../types.dart';
import '../utils.dart';
import 'base_operatin.dart';

class AccountUpdate implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 5;

  AccountName account;
  Authority master;
  Authority active;
  Authority regular;
  VIZPublicKey memoKey;
  String jsonMetadata;

  AccountUpdate(
      {this.account,
      this.master,
      this.active,
      this.regular,
      this.memoKey,
      this.jsonMetadata}) {
    _fillOptionalField();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(account.toBytes());

    if (master != null) {
      writer.writeUint8(1);
      writer.write(master.toBytes());
    } else {
      writer.writeUint8(0);
    }

    if (active != null) {
      writer.writeUint8(1);
      writer.write(active.toBytes());
    } else {
      writer.writeUint8(0);
    }

    if (regular != null) {
      writer.writeUint8(1);
      writer.write(regular.toBytes());
    } else {
      writer.writeUint8(0);
    }

    writer.write(memoKey.toBuffer());
    writer.write(BinaryUtils.transformStringToVarIntBytes(jsonMetadata));
    return writer.toBytes();
  }

  @override
  void validate() {
    _fillOptionalField();
    _checkNulls();

    if (!JsonUtils.isJson(jsonMetadata)) {
      throw InvalidParameterException(
          jsonMetadata, 'jsonMetadata', 'The json string is invalid');
    }
  }

  void _fillOptionalField() {}

  void _checkNulls() {
    InvalidParameterException.checkNotNull(account, 'account');
    InvalidParameterException.checkNotNull(jsonMetadata, 'jsonMetadata');
    InvalidParameterException.checkNotNull(memoKey, 'memoKey');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'account': account.toString(),
      'master': master.toJsonableObject(),
      'active': active.toJsonableObject(),
      'regular': regular.toJsonableObject(),
      'memo_key': memoKey.toString(),
      'json_metadata': jsonMetadata
    };

    List<Object> operation = ['account_update'];
    operation.add(params);

    return operation;
  }
}

class RequestAccountRecovery implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 12;

  AccountName recoveryAccount;
  AccountName accountToRecover;
  Authority newMasterAuth;

  //It doesn't use now
  List<BaseType> _extensions = [];

  RequestAccountRecovery(
      {this.recoveryAccount, this.accountToRecover, this.newMasterAuth}) {
    _fillOptionalField();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(recoveryAccount.toBytes());
    writer.write(accountToRecover.toBytes());
    writer.write(newMasterAuth.toBytes());
    writer.write(BinaryUtils.transformListToBytes(_extensions));
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();
  }

  void _fillOptionalField() {
    if (_extensions == null) {
      _extensions = [];
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(recoveryAccount, 'recoveryAccount');
    InvalidParameterException.checkNotNull(
        accountToRecover, 'accountToRecovery');
    InvalidParameterException.checkNotNull(newMasterAuth, 'newMasterAuth');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'recovery_account': recoveryAccount.toString(),
      'account_to_recover': accountToRecover.toString(),
      'new_master_authority': newMasterAuth.toJsonableObject(),
      'extensions': JsonUtils.serializesToJsonable(_extensions)
    };

    List<Object> operation = ['request_account_recovery'];
    operation.add(params);

    return operation;
  }
}

class RecoverAccount implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 13;

  AccountName accountToRecover;
  Authority newMasterAuth;
  Authority recentMasterAuth;

  //It doesn't use now
  List<BaseType> _extensions = [];

  RecoverAccount(
      {this.accountToRecover, this.newMasterAuth, this.recentMasterAuth});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(accountToRecover.toBytes());
    writer.write(newMasterAuth.toBytes());
    writer.write(recentMasterAuth.toBytes());
    writer.write(BinaryUtils.transformListToBytes(_extensions));
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(
        accountToRecover, 'accountToRecover');
    InvalidParameterException.checkNotNull(newMasterAuth, 'newMasterAuth');
    InvalidParameterException.checkNotNull(
        recentMasterAuth, 'recentMasterAuth');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'account_to_recover': accountToRecover.toString(),
      'new_master_authority': newMasterAuth.toJsonableObject(),
      'recent_master_authority': recentMasterAuth.toJsonableObject(),
      'extensions': JsonUtils.serializesToJsonable(_extensions)
    };

    List<Object> operation = ['recover_account'];
    operation.add(params);

    return operation;
  }
}

class ChangeRecoveryAccount implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 14;

  AccountName accountToRecover;
  AccountName newRecoveryAccount;

  //It doesn't use now
  List<BaseType> _extensions = [];

  ChangeRecoveryAccount({this.accountToRecover, this.newRecoveryAccount});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(accountToRecover.toBytes());
    writer.write(newRecoveryAccount.toBytes());
    writer.write(BinaryUtils.transformListToBytes(_extensions));
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(
        accountToRecover, 'accountToRecover');
    InvalidParameterException.checkNotNull(
        newRecoveryAccount, 'newRecoveryAccount');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'account_to_recover': accountToRecover.toString(),
      'new_recovery_account': newRecoveryAccount.toString(),
      'extensions': JsonUtils.serializesToJsonable(_extensions)
    };

    List<Object> operation = ['change_recovery_account'];
    operation.add(params);

    return operation;
  }
}

class AccountMetadata implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 21;

  AccountName account;
  String jsonMetadata;

  AccountMetadata({this.account, this.jsonMetadata});

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(account.toBytes());
    writer.write(BinaryUtils.transformStringToVarIntBytes(jsonMetadata));
    return writer.toBytes();
  }

  @override
  void validate() {
    _checkNulls();

    if (!JsonUtils.isJson(jsonMetadata)) {
      throw InvalidParameterException(
          jsonMetadata, 'jsonMetadata', 'The json string is invalid');
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(account, 'account');
    InvalidParameterException.checkNotNull(jsonMetadata, 'jsonMetadata');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'account': account.toString(),
      'json_metadata': jsonMetadata
    };

    List<Object> operation = ['account_metadata'];
    operation.add(params);

    return operation;
  }
}

class AccountCreate implements BaseOperation, Jsonable<List<Object>> {
  static const ID = 20;

  VizAsset fee;
  SharesAsset delegation;
  AccountName creator;
  AccountName newAccount;
  Authority master;
  Authority active;
  Authority regular;
  VIZPublicKey memoKey;
  String jsonMetadata;
  AccountName referrer;

  //It doesn't use now
  List<BaseType> _extensions = [];

  AccountCreate(
      {this.fee,
      this.delegation,
      this.creator,
      this.newAccount,
      this.master,
      this.active,
      this.regular,
      this.memoKey,
      this.jsonMetadata,
      this.referrer}) {
    _fillOptionalField();
  }

  @override
  Uint8List toBytes() {
    validate();
    ByteDataWriter writer = ByteDataWriter();
    writer.write(BinaryUtils.transformInt32ToVarIntBytes(ID));
    writer.write(fee.toBytes());
    writer.write(delegation.toBytes());
    writer.write(creator.toBytes());
    writer.write(newAccount.toBytes());
    writer.write(master.toBytes());
    writer.write(active.toBytes());
    writer.write(regular.toBytes());
    writer.write(memoKey.toBuffer());
    writer.write(BinaryUtils.transformStringToVarIntBytes(jsonMetadata));
    writer.write(referrer.toBytes());
    writer.write(BinaryUtils.transformListToBytes(_extensions));
    return writer.toBytes();
  }

  @override
  void validate() {
    _fillOptionalField();
    _checkNulls();

    if (!JsonUtils.isJson(jsonMetadata)) {
      throw InvalidParameterException(
          jsonMetadata, 'jsonMetadata', 'The json string is invalid');
    }
  }

  void _fillOptionalField() {
    if (referrer == null) {
      referrer = creator;
    }
  }

  void _checkNulls() {
    InvalidParameterException.checkNotNull(fee, 'fee');
    InvalidParameterException.checkNotNull(delegation, 'delegation');
    InvalidParameterException.checkNotNull(creator, 'creator');
    InvalidParameterException.checkNotNull(newAccount, 'newAccount');
    InvalidParameterException.checkNotNull(master, 'master');
    InvalidParameterException.checkNotNull(active, 'active');
    InvalidParameterException.checkNotNull(regular, 'regular');
    InvalidParameterException.checkNotNull(memoKey, 'memoKey');
    InvalidParameterException.checkNotNull(jsonMetadata, 'jsonMetadata');
  }

  @override
  List<Object> toJsonableObject() {
    validate();
    Map<String, Object> params = {
      'fee': fee.toString(),
      'delegation': delegation.toString(),
      'creator': creator.toString(),
      'new_account_name': newAccount.toString(),
      'master': master.toJsonableObject(),
      'active': active.toJsonableObject(),
      'regular': regular.toJsonableObject(),
      'memo_key': memoKey.toString(),
      'json_metadata': jsonMetadata,
      'referrer': referrer.toString(),
      'extensions': JsonUtils.serializesToJsonable(_extensions)
    };

    List<Object> operation = ['account_create'];
    operation.add(params);

    return operation;
  }
}
