import 'dart:convert';

import '../json.dart';

class JsonUtils {
  static bool isJson(String jsonStr) {
    try {
      json.decode(jsonStr);
      return true;
    } on FormatException {
      return false;
    }
  }

  static Object serializesToJsonable(Object obj) {
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
      newList.add(serializesToJsonable(obj));
    }

    return newList;
  }

  static _serializeMap(Map map) {
    Map newMap = {};
    for (Object obj in map.keys) {
      newMap[obj.toString()] = serializesToJsonable(map[obj]);
    }

    return newMap;
  }
}
