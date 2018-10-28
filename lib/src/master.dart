library rpack.master;

import 'package:reflectable/reflectable.dart';

class RPackReflector extends Reflectable {
  const RPackReflector() : super(invokingCapability,typingCapability,reflectedTypeCapability,typeRelationsCapability);
}

const rpack = RPackReflector();