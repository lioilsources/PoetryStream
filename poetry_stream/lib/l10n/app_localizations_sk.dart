// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get modeStream => 'Stream';

  @override
  String get modePoem => 'Báseň';

  @override
  String get modeReading => 'Čítanie';

  @override
  String get noPoems => 'Žiadne básne';

  @override
  String get playbackLive => 'NAŽIVO';

  @override
  String get playbackPaused => 'PAUZA';

  @override
  String get addPoemButton => '+ BÁSEŇ';

  @override
  String get pastePoemTitle => 'Vložiť báseň';

  @override
  String get save => 'ULOŽIŤ';

  @override
  String get pastePoemHint => 'Prvý riadok = názov básne\n\nText básne…';

  @override
  String get storeTitle => 'Zbierky básní';

  @override
  String get storeUnavailable =>
      'Obchod nie je dostupný. Skontrolujte pripojenie.';

  @override
  String get restorePurchases => 'Obnoviť nákupy';

  @override
  String get unlocked => 'ODOMKNUTÉ';

  @override
  String get buy => 'KÚPIŤ';

  @override
  String get poemsButton => 'BÁSNE';

  @override
  String get collections => 'Zbierky';

  @override
  String get myPoems => 'Moje básne';

  @override
  String get purchaseFailed => 'Nákup sa nepodaril.';

  @override
  String get purchaseError => 'Chyba pri nákupe.';

  @override
  String buyWithPrice(String price) {
    return 'KÚPIŤ $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Báseň $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count básní',
      few: '$count básne',
      one: '1 báseň',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count strof',
      few: '$count strofy',
      one: '1 strofa',
    );
    return '$_temp0';
  }
}
