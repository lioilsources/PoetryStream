// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get modeStream => 'Flux';

  @override
  String get modePoem => 'Poema';

  @override
  String get modeReading => 'Lectura';

  @override
  String get noPoems => 'Cap poema';

  @override
  String get playbackLive => 'EN DIRECTE';

  @override
  String get playbackPaused => 'PAUSA';

  @override
  String get addPoemButton => '+ POEMA';

  @override
  String get pastePoemTitle => 'Enganxa un poema';

  @override
  String get save => 'DESA';

  @override
  String get pastePoemHint =>
      'Primera línia = títol del poema\n\nText del poema…';

  @override
  String get storeTitle => 'Col·leccions de poesia';

  @override
  String get storeUnavailable =>
      'La botiga no està disponible. Comprova la connexió.';

  @override
  String get restorePurchases => 'Restaura les compres';

  @override
  String get unlocked => 'DESBLOQUEJAT';

  @override
  String get buy => 'COMPRA';

  @override
  String get poemsButton => 'POEMES';

  @override
  String get collections => 'Col·leccions';

  @override
  String get myPoems => 'Els meus poemes';

  @override
  String get purchaseFailed => 'La compra ha fallat.';

  @override
  String get purchaseError => 'Error en la compra.';

  @override
  String buyWithPrice(String price) {
    return 'COMPRA $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Poema $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poemes',
      one: '$count poema',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count estrofes',
      one: '$count estrofa',
    );
    return '$_temp0';
  }
}
