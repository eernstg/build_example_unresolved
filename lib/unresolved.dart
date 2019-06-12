import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build_config/build_config.dart';
import 'package:build_runner_core/build_runner_core.dart';

class UnresolvedBuilder implements Builder {
  BuilderOptions builderOptions;

  UnresolvedBuilder(this.builderOptions);

  Future build(BuildStep buildStep) async {
    var inputLibrary = await buildStep.inputLibrary;
    var resolver = buildStep.resolver;
    var inputId = buildStep.inputId;
    print("inputId: $inputId");
    var outputId = inputId.changeExtension('.g.dart');
    var resolvedInputLibrary = await resolver.libraryFor(inputId);
    print("Resolved input library: ${resolvedInputLibrary.displayName}");
    print("  Unit: ${resolvedInputLibrary.definingCompilationUnit}");
    List<LibraryElement> visibleLibraries = await resolver.libraries.toList();

    for (var library in visibleLibraries) {
      print("Library: ${library.displayName}");
      print("  Unit: ${library.definingCompilationUnit}");
    }
  }

  Map<String, List<String>> get buildExtensions =>
      const { '.dart': ['.g.dart'] };
}

UnresolvedBuilder unresolvedBuilder(BuilderOptions options) {
  var config = new Map<String, Object>.from(options.config);
  config.putIfAbsent('entry_points', () => ['**.dart']);
  return new UnresolvedBuilder(options);
}
