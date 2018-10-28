# ReflectablePacker

This package allows you to (de)serialize Dart objects to/from Maps

No it will not (de)serialize into/from JSON or MessagePack automatically, you can do that part yourself by just wrapping the function.

Example of the wrap:
```dart
String jrpackser(x) => json.encode(rpackserializer.serialize(x));
```