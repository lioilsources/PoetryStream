// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get modeStream => 'Tok';

  @override
  String get modePoem => 'Pesem';

  @override
  String get modeReading => 'Branje';

  @override
  String get noPoems => 'Ni pesmi';

  @override
  String get playbackLive => 'V ŽIVO';

  @override
  String get playbackPaused => 'PAVZA';

  @override
  String get addPoemButton => '+ PESEM';

  @override
  String get pastePoemTitle => 'Prilepi pesem';

  @override
  String get save => 'SHRANI';

  @override
  String get pastePoemHint => 'Prva vrstica = naslov pesmi\n\nBesedilo pesmi…';

  @override
  String get storeTitle => 'Pesniške zbirke';

  @override
  String get storeUnavailable => 'Trgovina ni na voljo. Preverite povezavo.';

  @override
  String get restorePurchases => 'Obnovi nakupe';

  @override
  String get unlocked => 'ODKLENJENO';

  @override
  String get buy => 'KUPI';

  @override
  String get poemsButton => 'PESMI';

  @override
  String get collections => 'Zbirke';

  @override
  String get myPoems => 'Moje pesmi';

  @override
  String get purchaseFailed => 'Nakup ni uspel.';

  @override
  String get purchaseError => 'Napaka pri nakupu.';

  @override
  String buyWithPrice(String price) {
    return 'KUPI $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Pesem $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pesmi',
      few: '$count pesmi',
      two: '$count pesmi',
      one: '$count pesem',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kitic',
      few: '$count kitice',
      two: '$count kitici',
      one: '$count kitica',
    );
    return '$_temp0';
  }
}
