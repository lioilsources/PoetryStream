// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get modeStream => 'Flux';

  @override
  String get modePoem => 'Poezie';

  @override
  String get modeReading => 'Citire';

  @override
  String get noPoems => 'Nicio poezie';

  @override
  String get playbackLive => 'LIVE';

  @override
  String get playbackPaused => 'PAUZĂ';

  @override
  String get addPoemButton => '+ POEZIE';

  @override
  String get pastePoemTitle => 'Lipește o poezie';

  @override
  String get save => 'SALVEAZĂ';

  @override
  String get pastePoemHint => 'Primul rând = titlul poeziei\n\nTextul poeziei…';

  @override
  String get storeTitle => 'Volume de poezie';

  @override
  String get storeUnavailable =>
      'Magazinul nu este disponibil. Verifică conexiunea.';

  @override
  String get restorePurchases => 'Restaurează achizițiile';

  @override
  String get unlocked => 'DEBLOCAT';

  @override
  String get buy => 'CUMPĂRĂ';

  @override
  String get poemsButton => 'POEZII';

  @override
  String get collections => 'Volume';

  @override
  String get myPoems => 'Poeziile mele';

  @override
  String get purchaseFailed => 'Achiziția a eșuat.';

  @override
  String get purchaseError => 'Eroare la achiziție.';

  @override
  String buyWithPrice(String price) {
    return 'CUMPĂRĂ $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Poezia $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de poezii',
      few: '$count poezii',
      one: '$count poezie',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de strofe',
      few: '$count strofe',
      one: '$count strofă',
    );
    return '$_temp0';
  }
}
