// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get modeStream => 'Strøm';

  @override
  String get modePoem => 'Digt';

  @override
  String get modeReading => 'Læsning';

  @override
  String get noPoems => 'Ingen digte';

  @override
  String get playbackLive => 'LIVE';

  @override
  String get playbackPaused => 'PAUSE';

  @override
  String get addPoemButton => '+ DIGT';

  @override
  String get pastePoemTitle => 'Indsæt et digt';

  @override
  String get save => 'GEM';

  @override
  String get pastePoemHint => 'Første linje = digtets titel\n\nDigtets tekst…';

  @override
  String get storeTitle => 'Digtsamlinger';

  @override
  String get storeUnavailable =>
      'Butikken er ikke tilgængelig. Tjek din forbindelse.';

  @override
  String get restorePurchases => 'Gendan køb';

  @override
  String get unlocked => 'LÅST OP';

  @override
  String get buy => 'KØB';

  @override
  String get poemsButton => 'DIGTE';

  @override
  String get collections => 'Samlinger';

  @override
  String get myPoems => 'Mine digte';

  @override
  String get purchaseFailed => 'Købet mislykkedes.';

  @override
  String get purchaseError => 'Fejl ved køb.';

  @override
  String buyWithPrice(String price) {
    return 'KØB $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Digt $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count digte',
      one: '$count digt',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count strofer',
      one: '$count strofe',
    );
    return '$_temp0';
  }
}
