// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get modeStream => 'Aliran';

  @override
  String get modePoem => 'Puisi';

  @override
  String get modeReading => 'Membaca';

  @override
  String get noPoems => 'Tidak ada puisi';

  @override
  String get playbackLive => 'LANGSUNG';

  @override
  String get playbackPaused => 'JEDA';

  @override
  String get addPoemButton => '+ PUISI';

  @override
  String get pastePoemTitle => 'Tempel puisi';

  @override
  String get save => 'SIMPAN';

  @override
  String get pastePoemHint => 'Baris pertama = judul puisi\n\nTeks puisi…';

  @override
  String get storeTitle => 'Kumpulan puisi';

  @override
  String get storeUnavailable => 'Toko tidak tersedia. Periksa koneksi Anda.';

  @override
  String get restorePurchases => 'Pulihkan pembelian';

  @override
  String get unlocked => 'TERBUKA';

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
  String get purchaseError => 'Kesalahan pembelian.';

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
      other: '$count bait',
    );
    return '$_temp0';
  }
}
