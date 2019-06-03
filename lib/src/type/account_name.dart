import 'dart:typed_data';

import '../exceptions.dart';
import '../utils.dart';
import 'base_type.dart';

class AccountName extends BaseType {
  String name;

  static const int MIN_NAME_LENGTH = 2;
  static const int MAX_NAME_LENGTH = 25;

  AccountName(this.name);

  @override
  Uint8List toBytes() {
    validate();
    return BinaryUtils.transformStringToVarIntBytes(name);
  }

  @override
  void validate() {
    _validate(name);
  }

  @override
  String toString() => name;

  void _validate(String name) {
    if (!isValidLength(name)) {
      throw InvalidParameterException(
          name,
          'name',
          'An account name needs to have '
              'a minimum length of $MIN_NAME_LENGTH '
              'and a maximum length of $MAX_NAME_LENGTH');
    }

    if (!isValidName(name)) {
      throw InvalidParameterException(
          name,
          'name',
          'The account needs the first character to be one of "a-z", '
              'characters in the middle can be "a-z", "0,9", "-" and a "." '
              'and the last character of the name has to be one of "a-z" and "0-9".');
    }
  }

  static bool isValidLength(String name) {
    int len = name.length;

    return len >= MIN_NAME_LENGTH && len <= MAX_NAME_LENGTH;
  }

  static bool isValidName(String name) {
    int begin = 0;
    int len = name.length;
    while (true) {
      int end = name.indexOf('.', begin);
      if (end == -1) {
        end = len;
      }
      if (end - begin < MIN_NAME_LENGTH) {
        return false;
      }
      switch (name[begin]) {
        case 'a':
        case 'b':
        case 'c':
        case 'd':
        case 'e':
        case 'f':
        case 'g':
        case 'h':
        case 'i':
        case 'j':
        case 'k':
        case 'l':
        case 'm':
        case 'n':
        case 'o':
        case 'p':
        case 'q':
        case 'r':
        case 's':
        case 't':
        case 'u':
        case 'v':
        case 'w':
        case 'x':
        case 'y':
        case 'z':
          break;
        default:
          return false;
      }
      switch (name[end - 1]) {
        case 'a':
        case 'b':
        case 'c':
        case 'd':
        case 'e':
        case 'f':
        case 'g':
        case 'h':
        case 'i':
        case 'j':
        case 'k':
        case 'l':
        case 'm':
        case 'n':
        case 'o':
        case 'p':
        case 'q':
        case 'r':
        case 's':
        case 't':
        case 'u':
        case 'v':
        case 'w':
        case 'x':
        case 'y':
        case 'z':
        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
          break;
        default:
          return false;
      }
      for (int i = begin + 1; i < end - 1; i++) {
        switch (name[i]) {
          case 'a':
          case 'b':
          case 'c':
          case 'd':
          case 'e':
          case 'f':
          case 'g':
          case 'h':
          case 'i':
          case 'j':
          case 'k':
          case 'l':
          case 'm':
          case 'n':
          case 'o':
          case 'p':
          case 'q':
          case 'r':
          case 's':
          case 't':
          case 'u':
          case 'v':
          case 'w':
          case 'x':
          case 'y':
          case 'z':
          case '0':
          case '1':
          case '2':
          case '3':
          case '4':
          case '5':
          case '6':
          case '7':
          case '8':
          case '9':
          case '-':
            break;
          default:
            return false;
        }
      }
      if (end == len) {
        break;
      }
      begin = end + 1;
    }
    return true;
  }
}
