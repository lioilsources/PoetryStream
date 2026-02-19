class BuildConfig {
  static const showPastePoem = bool.fromEnvironment(
    'SHOW_PASTE_POEM',
    defaultValue: false,
  );
}
