import 'dart:typed_data';

import 'base_type.dart';
import '../utils.dart' show BinaryUtils;

class TimePointSec extends BaseType {
  int _dateSec;
  String _vizTimeStrFormat;

  TimePointSec(DateTime time) {
    ArgumentError.checkNotNull(time, 'time');
    DateTime utcTime;

    if (!time.isUtc) {
      utcTime = time.toUtc();
    } else {
      utcTime = time;
    }

    _vizTimeStrFormat = utcTime.toIso8601String().split('.')[0];
    _dateSec = time.millisecondsSinceEpoch ~/ 1000;
  }

  ///This number of seconds since the "Unix epoch" 1970-01-01T00:00:00Z (UTC)
  int get timeSec => _dateSec;

  ///Returns the time as bytes representation
  @override
  Uint8List toBytes() {
    validate();
    return BinaryUtils.transformUint32ToBytes(_dateSec);
  }

  @override
  void validate() {}

  ///Returns the time as a Graphene time_point_sec format representation
  @override
  String toString() {
    return _vizTimeStrFormat;
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + timeSec.hashCode;
    return result;
  }

  bool operator >(TimePointSec other) => timeSec > other.timeSec;
  bool operator <(TimePointSec other) => timeSec < other.timeSec;
  bool operator >=(TimePointSec other) => timeSec >= other.timeSec;
  bool operator <=(TimePointSec other) => timeSec <= other.timeSec;
  bool operator ==(dynamic other) {
    if (other is TimePointSec) {
      return timeSec == other.timeSec;
    }

    return false;
  }
}
