// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get modeStream => 'Strøm';

  @override
  String get modePoem => 'Dikt';

  @override
  String get modeReading => 'Lesing';

  @override
  String get noPoems => 'Ingen dikt';

  @override
  String get playbackLive => 'LIVE';

  @override
  String get playbackPaused => 'PAUSE';

  @override
  String get addPoemButton => '+ DIKT';

  @override
  String get pastePoemTitle => 'Lim inn et dikt';

  @override
  String get save => 'LAGRE';

  @override
  String get pastePoemHint => 'Første linje = diktets tittel\n\nDiktets tekst…';

  @override
  String get storeTitle => 'Diktsamlinger';

  @override
  String get storeUnavailable =>
      'Butikken er ikke tilgjengelig. Sjekk tilkoblingen.';

  @override
  String get restorePurchases => 'Gjenopprett kjøp';

  @override
  String get unlocked => 'LÅST OPP';

  @override
  String get buy => 'KJØP';

  @override
  String get poemsButton => 'DIKT';

  @override
  String get collections => 'Samlinger';

  @override
  String get myPoems => 'Mine dikt';

  @override
  String get purchaseFailed => 'Kjøpet mislyktes.';

  @override
  String get purchaseError => 'Feil ved kjøp.';

  @override
  String buyWithPrice(String price) {
    return 'KJØP $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Dikt $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dikt',
      one: '$count dikt',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count strofer',
      one: '$count strofe',
    );
    return '$_temp0';
  }
}
