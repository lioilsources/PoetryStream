// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get modeStream => 'Ström';

  @override
  String get modePoem => 'Dikt';

  @override
  String get modeReading => 'Läsning';

  @override
  String get noPoems => 'Inga dikter';

  @override
  String get playbackLive => 'LIVE';

  @override
  String get playbackPaused => 'PAUS';

  @override
  String get addPoemButton => '+ DIKT';

  @override
  String get pastePoemTitle => 'Klistra in en dikt';

  @override
  String get save => 'SPARA';

  @override
  String get pastePoemHint => 'Första raden = diktens titel\n\nDiktens text…';

  @override
  String get storeTitle => 'Diktsamlingar';

  @override
  String get storeUnavailable =>
      'Butiken är inte tillgänglig. Kontrollera anslutningen.';

  @override
  String get restorePurchases => 'Återställ köp';

  @override
  String get unlocked => 'UPPLÅST';

  @override
  String get buy => 'KÖP';

  @override
  String get poemsButton => 'DIKTER';

  @override
  String get collections => 'Samlingar';

  @override
  String get myPoems => 'Mina dikter';

  @override
  String get purchaseFailed => 'Köpet misslyckades.';

  @override
  String get purchaseError => 'Fel vid köp.';

  @override
  String buyWithPrice(String price) {
    return 'KÖP $price';
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
      other: '$count dikter',
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
      one: '$count strof',
    );
    return '$_temp0';
  }
}
