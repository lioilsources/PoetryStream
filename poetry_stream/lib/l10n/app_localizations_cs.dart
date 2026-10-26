// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get modeStream => 'Stream';

  @override
  String get modePoem => 'Báseň';

  @override
  String get modeReading => 'Čtení';

  @override
  String get noPoems => 'Žádné básně';

  @override
  String get playbackLive => 'ŽIVĚ';

  @override
  String get playbackPaused => 'PAUZA';

  @override
  String get addPoemButton => '+ BÁSEŇ';

  @override
  String get pastePoemTitle => 'Vložit báseň';

  @override
  String get save => 'ULOŽIT';

  @override
  String get pastePoemHint => 'První řádek = název básně\n\nText básně…';

  @override
  String get storeTitle => 'Sbírky básní';

  @override
  String get storeUnavailable =>
      'Obchod není dostupný. Zkontrolujte připojení.';

  @override
  String get restorePurchases => 'Obnovit nákupy';

  @override
  String get unlocked => 'ODEMČENO';

  @override
  String get buy => 'KOUPIT';

  @override
  String get poemsButton => 'BÁSNĚ';

  @override
  String get collections => 'Sbírky';

  @override
  String get myPoems => 'Moje básně';

  @override
  String get purchaseFailed => 'Nákup se nezdařil.';

  @override
  String get purchaseError => 'Chyba při nákupu.';

  @override
  String buyWithPrice(String price) {
    return 'KOUPIT $price';
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
      few: '$count básně',
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
