// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get modeStream => 'Aliran';

  @override
  String get modePoem => 'Puisi';

  @override
  String get modeReading => 'Bacaan';

  @override
  String get noPoems => 'Tiada puisi';

  @override
  String get playbackLive => 'LANGSUNG';

  @override
  String get playbackPaused => 'JEDA';

  @override
  String get addPoemButton => '+ PUISI';

  @override
  String get pastePoemTitle => 'Tampal puisi';

  @override
  String get save => 'SIMPAN';

  @override
  String get pastePoemHint => 'Baris pertama = tajuk puisi\n\nTeks puisi…';

  @override
  String get storeTitle => 'Koleksi puisi';

  @override
  String get storeUnavailable => 'Kedai tidak tersedia. Semak sambungan anda.';

  @override
  String get restorePurchases => 'Pulihkan pembelian';

  @override
  String get unlocked => 'DIBUKA';

  @override
  String get buy => 'BELI';

  @override
  String get poemsButton => 'PUISI';

  @override
  String get collections => 'Koleksi';

  @override
  String get myPoems => 'Puisi saya';

  @override
  String get purchaseFailed => 'Pembelian gagal.';

  @override
  String get purchaseError => 'Ralat pembelian.';

  @override
  String buyWithPrice(String price) {
    return 'BELI $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Puisi $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count puisi',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rangkap',
    );
    return '$_temp0';
  }
}
