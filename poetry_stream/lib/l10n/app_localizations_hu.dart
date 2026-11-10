// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get modeStream => 'Folyam';

  @override
  String get modePoem => 'Vers';

  @override
  String get modeReading => 'Olvasás';

  @override
  String get noPoems => 'Nincs vers';

  @override
  String get playbackLive => 'ÉLŐ';

  @override
  String get playbackPaused => 'SZÜNET';

  @override
  String get addPoemButton => '+ VERS';

  @override
  String get pastePoemTitle => 'Vers beillesztése';

  @override
  String get save => 'MENTÉS';

  @override
  String get pastePoemHint => 'Első sor = a vers címe\n\nA vers szövege…';

  @override
  String get storeTitle => 'Verseskötetek';

  @override
  String get storeUnavailable =>
      'Az áruház nem érhető el. Ellenőrizd a kapcsolatot.';

  @override
  String get restorePurchases => 'Vásárlások visszaállítása';

  @override
  String get unlocked => 'FELOLDVA';

  @override
  String get buy => 'VÁSÁRLÁS';

  @override
  String get poemsButton => 'VERSEK';

  @override
  String get collections => 'Gyűjtemények';

  @override
  String get myPoems => 'Saját verseim';

  @override
  String get purchaseFailed => 'A vásárlás sikertelen.';

  @override
  String get purchaseError => 'Vásárlási hiba.';

  @override
  String buyWithPrice(String price) {
    return 'VÁSÁRLÁS $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return '$number. vers';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vers',
      one: '$count vers',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count versszak',
      one: '$count versszak',
    );
    return '$_temp0';
  }
}
