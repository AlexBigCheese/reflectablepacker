import 'package:build_runner/build_runner.dart' as _i1;
import 'package:reflectable/reflectable_builder.dart' as _i2;
import 'package:build_config/build_config.dart' as _i3;
import 'dart:isolate' as _i4;

final _builders = <_i1.BuilderApplication>[
  _i1.apply('reflectable|reflectable', [_i2.reflectableBuilder], _i1.toRoot(),
      hideOutput: false,
      defaultGenerateFor: const _i3.InputSet(include: const [
        'benchmark/**.dart',
        'bin/**.dart',
        'example/**.dart',
        'lib/main.dart',
        'test/**.dart',
        'tool/**.dart',
        'web/**.dart'
      ], exclude: const [
        'lib/**.dart'
      ]))
];
main(List<String> args, [_i4.SendPort sendPort]) async {
  var result = await _i1.run(args, _builders);
  sendPort?.send(result);
}
