// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get modeStream => 'Stream';

  @override
  String get modePoem => 'Gedicht';

  @override
  String get modeReading => 'Lesen';

  @override
  String get noPoems => 'Keine Gedichte';

  @override
  String get playbackLive => 'LIVE';

  @override
  String get playbackPaused => 'PAUSE';

  @override
  String get addPoemButton => '+ GEDICHT';

  @override
  String get pastePoemTitle => 'Gedicht einfügen';

  @override
  String get save => 'SPEICHERN';

  @override
  String get pastePoemHint =>
      'Erste Zeile = Titel des Gedichts\n\nText des Gedichts…';

  @override
  String get storeTitle => 'Gedichtsammlungen';

  @override
  String get storeUnavailable =>
      'Shop nicht verfügbar. Prüfe deine Verbindung.';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get unlocked => 'FREIGESCHALTET';

  @override
  String get buy => 'KAUFEN';

  @override
  String get poemsButton => 'GEDICHTE';

  @override
  String get collections => 'Sammlungen';

  @override
  String get myPoems => 'Meine Gedichte';

  @override
  String get purchaseFailed => 'Kauf fehlgeschlagen.';

  @override
  String get purchaseError => 'Fehler beim Kauf.';

  @override
  String buyWithPrice(String price) {
    return '$price KAUFEN';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Gedicht $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Gedichte',
      one: '$count Gedicht',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Strophen',
      one: '$count Strophe',
    );
    return '$_temp0';
  }
}
