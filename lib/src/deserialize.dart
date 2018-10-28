import 'package:reflectable/reflectable.dart';
import 'master.dart';

/// This class is incomplete!
class RPackDeserializer {
  //TODO: deserialize
  //TODO: isPrimitive
  //TODO: deserializeIterable
  //TODO: deserializeMap
  detype(type) {
    assert(type is String || type is List);
    if (type is String) {
      switch (type) {
        case "String":
          return String;
        case "int":
          return int;
        case "double":
          return double;
        case "num":
          return num;
        case "bool":
          return bool;
      }
      if (rpack.annotatedClasses.any((x) => x.simpleName == type))
        return rpack.annotatedClasses.firstWhere((x) => x.simpleName == type);
      throw "Could not detype $type";
    }
  }

  const RPackDeserializer();
}

var rpackdeserializer = const RPackDeserializer();
