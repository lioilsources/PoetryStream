// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get modeStream => 'Virta';

  @override
  String get modePoem => 'Runo';

  @override
  String get modeReading => 'Lukeminen';

  @override
  String get noPoems => 'Ei runoja';

  @override
  String get playbackLive => 'LIVE';

  @override
  String get playbackPaused => 'TAUKO';

  @override
  String get addPoemButton => '+ RUNO';

  @override
  String get pastePoemTitle => 'Liitä runo';

  @override
  String get save => 'TALLENNA';

  @override
  String get pastePoemHint => 'Ensimmäinen rivi = runon nimi\n\nRunon teksti…';

  @override
  String get storeTitle => 'Runokokoelmat';

  @override
  String get storeUnavailable =>
      'Kauppa ei ole käytettävissä. Tarkista yhteytesi.';

  @override
  String get restorePurchases => 'Palauta ostokset';

  @override
  String get unlocked => 'AVATTU';

  @override
  String get buy => 'OSTA';

  @override
  String get poemsButton => 'RUNOT';

  @override
  String get collections => 'Kokoelmat';

  @override
  String get myPoems => 'Omat runot';

  @override
  String get purchaseFailed => 'Osto epäonnistui.';

  @override
  String get purchaseError => 'Virhe ostossa.';

  @override
  String buyWithPrice(String price) {
    return 'OSTA $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Runo $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count runoa',
      one: '$count runo',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count säettä',
      one: '$count säe',
    );
    return '$_temp0';
  }
}
