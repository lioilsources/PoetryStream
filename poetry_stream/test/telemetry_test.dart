// The checks every app copies from ol1n_telemetry (README "Testovací sada"),
// plus Poesie's own hooks.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ol1n_telemetry/testing.dart';
import 'package:poetry_stream/engine/verse_engine.dart';
import 'package:poetry_stream/models/display_mode.dart';
import 'package:poetry_stream/telemetry/app_telemetry.dart';
import 'package:poetry_stream/telemetry/telemetry_dictionary.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('docs/telemetry.md lists exactly the dictionary', () {
    expect(
      telemetryDocProblems(
        poesieDictionary,
        File('../docs/telemetry.md').readAsStringSync(),
      ),
      isEmpty,
    );
  });

  test('no property is free text', () {
    expect(telemetryDictionaryProblems(poesieDictionary), isEmpty);
  });

  test('app version matches pubspec.yaml', () {
    expect(
      telemetryVersionProblems(
        kAppVersion,
        File('pubspec.yaml').readAsStringSync(),
      ),
      isEmpty,
    );
  });

  test('the code sends only dictionary events, and every one of them', () {
    expect(telemetryTrackCallProblems(poesieDictionary), isEmpty);
  });

  test('no key, no network', () async {
    expect(await telemetryNoKeyProblems(poesieDictionary), isEmpty);
  }, skip: const bool.fromEnvironment('TELEMETRY_DEBUG'));

  test('off means nothing', () async {
    expect(await telemetryOffProblems(poesieDictionary), isEmpty);
  });

  test('every bundled collection has a telemetry value', () {
    final stems = Directory('assets/poems')
        .listSync()
        .map((f) => f.path.split(Platform.pathSeparator).last)
        .where((n) => n.endsWith('.yaml'))
        .map((n) => n.substring(0, n.length - 5));
    for (final id in stems) {
      expect(AppTelemetry.collectionValue(id), isNot('other'), reason: id);
    }
    expect(AppTelemetry.collectionValue('user'), 'user');
    expect(AppTelemetry.collectionValue('something new'), 'other');
  });

  test('every screen of a display mode is in the dictionary', () {
    for (final m in DisplayMode.values) {
      expect(kScreens, contains(AppTelemetry.screenOf(m)));
    }
  });

  group('VerseEngine.onPoemFinished', () {
    const config = VerseEngineConfig(
      fadeInDuration: Duration(milliseconds: 10),
      displayDuration: Duration(milliseconds: 10),
      fadeOutDuration: Duration(milliseconds: 10),
      mode: DisplayMode.reading,
    );

    testWidgets('reading: once per poem, after its last stanza', (
      tester,
    ) async {
      final finished = <int>[];
      final engine = VerseEngine(
        onStateChanged: (_) {},
        onPoemFinished: finished.add,
        config: config,
      );
      engine.setPoems(['a\n\nb\n\nc', 'd'], ['A', 'D']);
      engine.play();
      // 4 stanzas × 30 ms; stop before the second round.
      for (var i = 0; i < 12; i++) {
        await tester.pump(const Duration(milliseconds: 10));
      }
      engine.dispose();
      expect(finished..sort(), [0, 1]);
    });

    testWidgets('stream: never', (tester) async {
      final finished = <int>[];
      final engine = VerseEngine(
        onStateChanged: (_) {},
        onPoemFinished: finished.add,
        config: const VerseEngineConfig(
          fadeInDuration: Duration(milliseconds: 10),
          displayDuration: Duration(milliseconds: 10),
          fadeOutDuration: Duration(milliseconds: 10),
        ),
      );
      engine.setPoems(['a\n\nb', 'c'], ['A', 'C']);
      engine.play();
      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 10));
      }
      engine.dispose();
      expect(finished, isEmpty);
    });
  });
}
