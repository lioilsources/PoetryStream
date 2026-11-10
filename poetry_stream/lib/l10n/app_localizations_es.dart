// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get modeStream => 'Flujo';

  @override
  String get modePoem => 'Poema';

  @override
  String get modeReading => 'Lectura';

  @override
  String get noPoems => 'Ningún poema';

  @override
  String get playbackLive => 'EN VIVO';

  @override
  String get playbackPaused => 'PAUSA';

  @override
  String get addPoemButton => '+ POEMA';

  @override
  String get pastePoemTitle => 'Pegar un poema';

  @override
  String get save => 'GUARDAR';

  @override
  String get pastePoemHint =>
      'Primera línea = título del poema\n\nTexto del poema…';

  @override
  String get storeTitle => 'Colecciones de poesía';

  @override
  String get storeUnavailable => 'Tienda no disponible. Comprueba tu conexión.';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get unlocked => 'DESBLOQUEADO';

  @override
  String get buy => 'COMPRAR';

  @override
  String get poemsButton => 'POEMAS';

  @override
  String get collections => 'Colecciones';

  @override
  String get myPoems => 'Mis poemas';

  @override
  String get purchaseFailed => 'La compra ha fallado.';

  @override
  String get purchaseError => 'Error en la compra.';

  @override
  String buyWithPrice(String price) {
    return 'COMPRAR $price';
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
      other: '$count poemas',
      one: '$count poema',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count estrofas',
      one: '$count estrofa',
    );
    return '$_temp0';
  }
}
