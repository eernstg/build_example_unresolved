import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:build_test/builder.dart' as _i2;
import 'package:build_config/build_config.dart' as _i3;
import 'package:unresolved/unresolved.dart' as _i4;
import 'dart:isolate' as _i5;
import 'package:build_runner/build_runner.dart' as _i6;
import 'dart:io' as _i7;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(
      'build_test:test_bootstrap',
      [_i2.debugIndexBuilder, _i2.debugTestBuilder, _i2.testBootstrapBuilder],
      _i1.toRoot(),
      hideOutput: true,
      defaultGenerateFor: const _i3.InputSet(include: ['test/**'])),
  _i1.apply('unresolved:unresolved', [_i4.unresolvedBuilder], _i1.toRoot(),
      hideOutput: false,
      defaultGenerateFor: const _i3.InputSet(include: [
        'example/**.dart',
      ], exclude: [
        'lib/**.dart'
      ]))
];

main() async {
  var result = await _i6.run(["build", "--verbose", "example"], _builders);
  _i7.exitCode = result;
}
