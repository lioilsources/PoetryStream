// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get modeStream => 'Strumień';

  @override
  String get modePoem => 'Wiersz';

  @override
  String get modeReading => 'Czytanie';

  @override
  String get noPoems => 'Brak wierszy';

  @override
  String get playbackLive => 'NA ŻYWO';

  @override
  String get playbackPaused => 'PAUZA';

  @override
  String get addPoemButton => '+ WIERSZ';

  @override
  String get pastePoemTitle => 'Wklej wiersz';

  @override
  String get save => 'ZAPISZ';

  @override
  String get pastePoemHint => 'Pierwszy wers = tytuł wiersza\n\nTekst wiersza…';

  @override
  String get storeTitle => 'Tomiki wierszy';

  @override
  String get storeUnavailable => 'Sklep jest niedostępny. Sprawdź połączenie.';

  @override
  String get restorePurchases => 'Przywróć zakupy';

  @override
  String get unlocked => 'ODBLOKOWANE';

  @override
  String get buy => 'KUP';

  @override
  String get poemsButton => 'WIERSZE';

  @override
  String get collections => 'Tomiki';

  @override
  String get myPoems => 'Moje wiersze';

  @override
  String get purchaseFailed => 'Zakup się nie udał.';

  @override
  String get purchaseError => 'Błąd zakupu.';

  @override
  String buyWithPrice(String price) {
    return 'KUP $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Wiersz $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wiersza',
      many: '$count wierszy',
      few: '$count wiersze',
      one: '$count wiersz',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zwrotki',
      many: '$count zwrotek',
      few: '$count zwrotki',
      one: '$count zwrotka',
    );
    return '$_temp0';
  }
}
