import 'dart:typed_data';

abstract class BaseType {
  ///Validate data and if data invalid then throws [InvalidParameterException]
  void validate();

  ///Serialize data and return as [Uint8List]
  Uint8List toBytes();
}
