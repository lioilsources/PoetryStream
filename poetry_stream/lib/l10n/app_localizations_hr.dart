// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get modeStream => 'Tok';

  @override
  String get modePoem => 'Pjesma';

  @override
  String get modeReading => 'Čitanje';

  @override
  String get noPoems => 'Nema pjesama';

  @override
  String get playbackLive => 'UŽIVO';

  @override
  String get playbackPaused => 'PAUZA';

  @override
  String get addPoemButton => '+ PJESMA';

  @override
  String get pastePoemTitle => 'Zalijepi pjesmu';

  @override
  String get save => 'SPREMI';

  @override
  String get pastePoemHint => 'Prvi redak = naslov pjesme\n\nTekst pjesme…';

  @override
  String get storeTitle => 'Zbirke pjesama';

  @override
  String get storeUnavailable => 'Trgovina nije dostupna. Provjerite vezu.';

  @override
  String get restorePurchases => 'Vrati kupnje';

  @override
  String get unlocked => 'OTKLJUČANO';

  @override
  String get buy => 'KUPI';

  @override
  String get poemsButton => 'PJESME';

  @override
  String get collections => 'Zbirke';

  @override
  String get myPoems => 'Moje pjesme';

  @override
  String get purchaseFailed => 'Kupnja nije uspjela.';

  @override
  String get purchaseError => 'Pogreška pri kupnji.';

  @override
  String buyWithPrice(String price) {
    return 'KUPI $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Pjesma $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pjesama',
      few: '$count pjesme',
      one: '$count pjesma',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count strofa',
      few: '$count strofe',
      one: '$count strofa',
    );
    return '$_temp0';
  }
}
