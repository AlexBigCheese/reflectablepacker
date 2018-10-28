import 'package:reflectable/reflectable.dart';
import 'master.dart';

//type goes into %Type

class RPackSerializer {
  //TODO: Detect Cycles
  serialize(obj) {
    if (isPrimitive(obj)) return obj;

    if (obj is Iterable) return ((Iterable x) => (obj is List) ? x.toList() : ((obj is Set) ? x.toSet() : null))(serializeIterable(obj));

    if (obj is Map) return serializeMap(obj);

    if (rpack.canReflect(obj)) return serializeObject(obj);

    throw "Can't serialize the ${obj.runtimeType}";
  }

  bool isPrimitive(obj) =>
      obj is num || obj is String || obj is bool || obj == null;
  Iterable serializeIterable(Iterable obj) => obj.map(serialize);
  Map serializeMap(Map obj) => obj.map(
        (x, y) => new MapEntry(serialize(x), serialize(y)),
      );
  serializeObject(obj) {
    ClassMirror classMirror = rpack.annotatedClasses.firstWhere(
      (x) => x.reflectedType == obj.runtimeType,
    );
    if (classMirror.isEnum) return obj.index;
    InstanceMirror instanceMirror = rpack.reflect(obj);
    Map sObject = {};
    sObject["%Type this"] = classMirror.simpleName;
    for (var x in classMirror.instanceMembers.entries.where(
      (entry) =>
          entry.value.isGetter &&
          entry.value.simpleName != "runtimeType" &&
          entry.value.simpleName != "hashCode",
    )) {
      //TODO: Implement annnotations for No Serialize and SerializedName
      //TODO: Implement MetaSerialization (e.g. "[]" could be a List, could be a Set: It's still an Iterable but what kind?)
      sObject[x.key] = serialize(instanceMirror.invokeGetter(x.key));
      //TODO: Rethink Strategy - Use Trees in '%Type' maybe?
      // Strategy may be: Only type if not explicitly defined from the outside.
      // wait that's what we're doing!
      // it's how to do the x.value.returnType thing! dumpass!
      //NOTE: Fine when dynamic or has a mirror, if it's like a string? no luck.
      //if (x.value?.returnType?.simpleName == "dynamic" ?? true) sObject["%Type ${x.key}"] = retype(instanceMirror.invokeGetter(x.key)); // error 43:19 on .returnType
      //WOW: test if it's int,String,double or bool etc.
      if (isPrimitive(instanceMirror.invokeGetter(x.key))) {
        sObject["%Type ${x.key}"] = retype(instanceMirror.invokeGetter(x.key));
      }
      else if (x.value.hasReflectedReturnType &&
          x.value.returnType.simpleName == "dynamic")
        sObject["%Type ${x.key}"] = retype(
            instanceMirror.invokeGetter(x.key)); // error 43:19 on .returnType
    }
    return sObject;
  }

  String _legacyRetype(dynamic obj) {
    if (obj is Map) return "Map";
    if (obj is List) return "List";
    if (obj is Set) return "Set";
    return obj.runtimeType.toString();
  }

  retype(obj) {
    // if object has a <T,V> etc do thing

    // Placeholder
    return _legacyRetype(obj);
  }
}
