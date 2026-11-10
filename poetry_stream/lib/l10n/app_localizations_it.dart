// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get modeStream => 'Flusso';

  @override
  String get modePoem => 'Poesia';

  @override
  String get modeReading => 'Lettura';

  @override
  String get noPoems => 'Nessuna poesia';

  @override
  String get playbackLive => 'LIVE';

  @override
  String get playbackPaused => 'PAUSA';

  @override
  String get addPoemButton => '+ POESIA';

  @override
  String get pastePoemTitle => 'Incolla una poesia';

  @override
  String get save => 'SALVA';

  @override
  String get pastePoemHint =>
      'Prima riga = titolo della poesia\n\nTesto della poesia…';

  @override
  String get storeTitle => 'Raccolte di poesie';

  @override
  String get storeUnavailable =>
      'Store non disponibile. Controlla la connessione.';

  @override
  String get restorePurchases => 'Ripristina acquisti';

  @override
  String get unlocked => 'SBLOCCATO';

  @override
  String get buy => 'ACQUISTA';

  @override
  String get poemsButton => 'POESIE';

  @override
  String get collections => 'Raccolte';

  @override
  String get myPoems => 'Le mie poesie';

  @override
  String get purchaseFailed => 'Acquisto non riuscito.';

  @override
  String get purchaseError => 'Errore di acquisto.';

  @override
  String buyWithPrice(String price) {
    return 'ACQUISTA $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Poesia $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poesie',
      one: '$count poesia',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count strofe',
      one: '$count strofa',
    );
    return '$_temp0';
  }
}
