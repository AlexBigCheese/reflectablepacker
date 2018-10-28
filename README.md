# ReflectablePacker

This package allows you to (de)serialize Dart objects to/from Maps

## Can it serialize to JSON or MessagePack?

No it will not (de)serialize into/from JSON or MessagePack automatically, you can do that part yourself by just wrapping the function.

Example of the wrap:
```dart
String jrpackser(x) => json.encode(rpackserializer.serialize(x));
```

## TODO

 - [x] basic serializer
 - [ ] basic deserializer
 - [ ] types on serializer
 - [ ] types on deserializer