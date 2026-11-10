// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get modeStream => 'Stroom';

  @override
  String get modePoem => 'Gedicht';

  @override
  String get modeReading => 'Lezen';

  @override
  String get noPoems => 'Geen gedichten';

  @override
  String get playbackLive => 'LIVE';

  @override
  String get playbackPaused => 'PAUZE';

  @override
  String get addPoemButton => '+ GEDICHT';

  @override
  String get pastePoemTitle => 'Gedicht plakken';

  @override
  String get save => 'OPSLAAN';

  @override
  String get pastePoemHint =>
      'Eerste regel = titel van het gedicht\n\nTekst van het gedicht…';

  @override
  String get storeTitle => 'Dichtbundels';

  @override
  String get storeUnavailable =>
      'Winkel niet beschikbaar. Controleer je verbinding.';

  @override
  String get restorePurchases => 'Aankopen herstellen';

  @override
  String get unlocked => 'ONTGRENDELD';

  @override
  String get buy => 'KOPEN';

  @override
  String get poemsButton => 'GEDICHTEN';

  @override
  String get collections => 'Bundels';

  @override
  String get myPoems => 'Mijn gedichten';

  @override
  String get purchaseFailed => 'Aankoop mislukt.';

  @override
  String get purchaseError => 'Fout bij aankoop.';

  @override
  String buyWithPrice(String price) {
    return '$price KOPEN';
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
      other: '$count gedichten',
      one: '$count gedicht',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count strofen',
      one: '$count strofe',
    );
    return '$_temp0';
  }
}
