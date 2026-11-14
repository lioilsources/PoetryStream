import 'dart:async';

import 'package:hive/hive.dart';
import 'package:ol1n_telemetry/ol1n_telemetry.dart';

import '../l10n/l10n.dart';
import '../models/display_mode.dart';
import 'telemetry_dictionary.dart';

/// Glue between the app and `ol1n_telemetry`. Measuring never steers the
/// app: nothing here is read back by app logic.
class AppTelemetry {
  AppTelemetry._();

  static const _boxName = 'telemetry';

  /// The main screen of the current display mode; bottom sheets return to it.
  static String _modeScreen = 'stream';

  /// Whether this device owns at least one paid collection (common property).
  static bool ownsCollection = false;

  /// Start measuring. Silent (no store, no network) without `TELEMETRY_KEY`.
  static Future<void> init() async {
    if (!Telemetry.isConfigured) return;
    final box = await Hive.openBox<String>(_boxName);
    unawaited(
      Telemetry.init(
        app: 'poesie',
        appVersion: kAppVersion,
        dictionary: poesieDictionary,
        store: HiveTelemetryStore(box),
        lang: () => telemetryLocaleId(deviceLocale),
        tester: const bool.fromEnvironment('TELEMETRY_TESTER'),
        hadDataBefore: _hadDataBefore,
        common: () => {'owns_collection': ownsCollection},
      ),
    );
  }

  /// True when the app was used before measuring began: saved settings,
  /// unlocked collections or own poems. Never reads the telemetry box.
  static Future<bool> _hadDataBefore() async {
    final settings = await Hive.openBox('settings');
    final purchases = await Hive.openBox('purchases');
    final poems = await Hive.openBox('poems');
    return settings.containsKey('user_settings') ||
        purchases.containsKey('unlocked_ids') ||
        poems.containsKey('user_poems');
  }

  static String screenOf(DisplayMode mode) => switch (mode) {
    DisplayMode.stream => 'stream',
    DisplayMode.reading => 'reading',
    DisplayMode.browsing => 'browsing',
  };

  /// The display mode now on screen.
  static void showMode(DisplayMode mode) {
    _modeScreen = screenOf(mode);
    Telemetry.screen(_modeScreen);
  }

  /// Reports [screen] while the bottom sheet opened by [open] is up.
  static Future<T?> sheet<T>(String screen, Future<T?> Function() open) async {
    Telemetry.screen(screen);
    try {
      return await open();
    } finally {
      Telemetry.screen(_modeScreen);
    }
  }

  /// The value sent for a collection id; unknown ids are `other`.
  static String collectionValue(String collectionId) =>
      kCollectionIds[collectionId] ?? 'other';

  /// A poem was read to its end: the last stanza of a poem shown in full in
  /// the reading mode, or a poem scrolled past after a real stay in the
  /// browsing mode. The first one is the activation.
  static void poemFinished(DisplayMode mode, String collectionId) {
    Telemetry.track('poem_finish', {
      'mode': screenOf(mode),
      'collection': collectionValue(collectionId),
    });
    Telemetry.activation();
  }
}

/// [TelemetryStore] over a Hive box of strings (adapter from the package
/// README).
class HiveTelemetryStore implements TelemetryStore {
  HiveTelemetryStore(this._box);
  final Box<String> _box;
  @override
  Future<String?> read(String key) async => _box.get(key);
  @override
  Future<void> write(String key, String value) => _box.put(key, value);
  @override
  Future<void> remove(String key) => _box.delete(key);
}
