class Jsonable<T> {
  T toJsonableObject() => null;
}

/// Serializes an object to a jsonable object if it possible
class JsonSerializer {
  static Object serializes(Object obj) {
    if (obj is List) {
      return _serializesList(obj);
    }

    if (obj is Map) {
      return _serializeMap(obj);
    }

    if (obj is num || obj is String || obj is bool || obj == null) {
      return obj;
    }

    if (obj is Jsonable) {
      return obj.toJsonableObject();
    }

    return obj.toString();
  }

  static _serializesList(List list) {
    List newList = [];
    for (Object obj in list) {
      newList.add(serializes(obj));
    }

    return newList;
  }

  static _serializeMap(Map map) {
    Map newMap = {};
    for (Object obj in map.keys) {
      newMap[obj.toString()] = serializes(map[obj]);
    }

    return newMap;
  }
}
