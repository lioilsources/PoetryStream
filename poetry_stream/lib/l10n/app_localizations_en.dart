// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get modeStream => 'Stream';

  @override
  String get modePoem => 'Poem';

  @override
  String get modeReading => 'Reading';

  @override
  String get noPoems => 'No poems';

  @override
  String get playbackLive => 'LIVE';

  @override
  String get playbackPaused => 'PAUSED';

  @override
  String get addPoemButton => '+ POEM';

  @override
  String get pastePoemTitle => 'Paste a poem';

  @override
  String get save => 'SAVE';

  @override
  String get pastePoemHint => 'First line = poem title\n\nPoem text…';

  @override
  String get storeTitle => 'Poetry collections';

  @override
  String get storeUnavailable => 'Store unavailable. Check your connection.';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get unlocked => 'UNLOCKED';

  @override
  String get buy => 'BUY';

  @override
  String get poemsButton => 'POEMS';

  @override
  String get collections => 'Collections';

  @override
  String get myPoems => 'My poems';

  @override
  String get purchaseFailed => 'Purchase failed.';

  @override
  String get purchaseError => 'Purchase error.';

  @override
  String buyWithPrice(String price) {
    return 'BUY $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Poem $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poems',
      one: '1 poem',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stanzas',
      one: '1 stanza',
    );
    return '$_temp0';
  }
}
