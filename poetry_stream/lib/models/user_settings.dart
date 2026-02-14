import 'display_mode.dart';

class UserSettings {
  final String backgroundThemeId;
  final String? preferredFontFamily; // null = random
  final double displayDurationSec;
  final double fadeDurationSec;
  final DisplayMode displayMode;
  final bool randomizeStyle;

  const UserSettings({
    this.backgroundThemeId = 'dark',
    this.preferredFontFamily,
    this.displayDurationSec = 8.0,
    this.fadeDurationSec = 2.8,
    this.displayMode = DisplayMode.stream,
    this.randomizeStyle = true,
  });

  double get cycleDurationSec => fadeDurationSec + displayDurationSec + 0.7;

  UserSettings copyWith({
    String? backgroundThemeId,
    String? Function()? preferredFontFamily,
    double? displayDurationSec,
    double? fadeDurationSec,
    DisplayMode? displayMode,
    bool? randomizeStyle,
  }) {
    return UserSettings(
      backgroundThemeId: backgroundThemeId ?? this.backgroundThemeId,
      preferredFontFamily: preferredFontFamily != null
          ? preferredFontFamily()
          : this.preferredFontFamily,
      displayDurationSec: displayDurationSec ?? this.displayDurationSec,
      fadeDurationSec: fadeDurationSec ?? this.fadeDurationSec,
      displayMode: displayMode ?? this.displayMode,
      randomizeStyle: randomizeStyle ?? this.randomizeStyle,
    );
  }

  Map<String, dynamic> toJson() => {
        'backgroundThemeId': backgroundThemeId,
        'preferredFontFamily': preferredFontFamily,
        'displayDurationSec': displayDurationSec,
        'fadeDurationSec': fadeDurationSec,
        'displayMode': displayMode.index,
        'randomizeStyle': randomizeStyle,
      };

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        backgroundThemeId:
            (json['backgroundThemeId'] as String?) ?? 'dark',
        preferredFontFamily: json['preferredFontFamily'] as String?,
        displayDurationSec:
            (json['displayDurationSec'] as num?)?.toDouble() ?? 8.0,
        fadeDurationSec:
            (json['fadeDurationSec'] as num?)?.toDouble() ?? 2.8,
        displayMode: DisplayMode
            .values[(json['displayMode'] as int?) ?? 0],
        randomizeStyle: (json['randomizeStyle'] as bool?) ?? true,
      );
}
