import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:ol1n_telemetry/ol1n_telemetry.dart';
import '../models/user_settings.dart';
import '../models/display_mode.dart';
import '../telemetry/app_telemetry.dart';

class SettingsNotifier extends StateNotifier<UserSettings> {
  static const _boxName = 'settings';
  static const _key = 'user_settings';

  SettingsNotifier() : super(const UserSettings()) {
    _load();
  }

  Future<void> _load() async {
    final box = await Hive.openBox(_boxName);
    final json = box.get(_key);
    if (json != null) {
      try {
        state = UserSettings.fromJson(
          Map<String, dynamic>.from(jsonDecode(json as String)),
        );
      } catch (_) {
        // Keep defaults on parse error
      }
    }
    // The first screen is known once the saved mode is loaded.
    AppTelemetry.showMode(state.displayMode);
  }

  Future<void> _save() async {
    final box = await Hive.openBox(_boxName);
    await box.put(_key, jsonEncode(state.toJson()));
  }

  void setBackgroundTheme(String themeId) {
    state = state.copyWith(backgroundThemeId: themeId);
    _save();
  }

  void setPreferredFont(String? fontFamily) {
    state = state.copyWith(preferredFontFamily: () => fontFamily);
    _save();
  }

  void setDisplayDuration(double seconds) {
    state = state.copyWith(displayDurationSec: seconds);
    _save();
  }

  void setFadeDuration(double seconds) {
    state = state.copyWith(fadeDurationSec: seconds);
    _save();
  }

  void setDisplayMode(DisplayMode mode) {
    if (mode == state.displayMode) return;
    state = state.copyWith(displayMode: mode);
    _save();
    switch (mode) {
      case DisplayMode.reading:
        Telemetry.feature('mode_reading');
      case DisplayMode.browsing:
        Telemetry.feature('mode_browsing');
      case DisplayMode.stream:
        break;
    }
    AppTelemetry.showMode(mode);
  }

  void setRandomizeStyle(bool value) {
    state = state.copyWith(randomizeStyle: value);
    _save();
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, UserSettings>((ref) {
  return SettingsNotifier();
});
