// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get modeStream => 'Akış';

  @override
  String get modePoem => 'Şiir';

  @override
  String get modeReading => 'Okuma';

  @override
  String get noPoems => 'Şiir yok';

  @override
  String get playbackLive => 'CANLI';

  @override
  String get playbackPaused => 'DURAKLATILDI';

  @override
  String get addPoemButton => '+ ŞİİR';

  @override
  String get pastePoemTitle => 'Şiir yapıştır';

  @override
  String get save => 'KAYDET';

  @override
  String get pastePoemHint => 'İlk satır = şiirin başlığı\n\nŞiirin metni…';

  @override
  String get storeTitle => 'Şiir kitapları';

  @override
  String get storeUnavailable =>
      'Mağaza kullanılamıyor. Bağlantınızı kontrol edin.';

  @override
  String get restorePurchases => 'Satın alımları geri yükle';

  @override
  String get unlocked => 'AÇILDI';

  @override
  String get buy => 'SATIN AL';

  @override
  String get poemsButton => 'ŞİİRLER';

  @override
  String get collections => 'Koleksiyonlar';

  @override
  String get myPoems => 'Şiirlerim';

  @override
  String get purchaseFailed => 'Satın alma başarısız.';

  @override
  String get purchaseError => 'Satın alma hatası.';

  @override
  String buyWithPrice(String price) {
    return '$price SATIN AL';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Şiir $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count şiir',
      one: '$count şiir',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kıta',
      one: '$count kıta',
    );
    return '$_temp0';
  }
}
