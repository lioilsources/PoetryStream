// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get modeStream => 'سلسلہ';

  @override
  String get modePoem => 'نظم';

  @override
  String get modeReading => 'مطالعہ';

  @override
  String get noPoems => 'کوئی نظم نہیں';

  @override
  String get playbackLive => 'لائیو';

  @override
  String get playbackPaused => 'وقفہ';

  @override
  String get addPoemButton => '+ نظم';

  @override
  String get pastePoemTitle => 'نظم چسپاں کریں';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get pastePoemHint => 'پہلی سطر = نظم کا عنوان\n\nنظم کا متن…';

  @override
  String get storeTitle => 'شاعری کے مجموعے';

  @override
  String get storeUnavailable => 'اسٹور دستیاب نہیں۔ اپنا کنکشن چیک کریں۔';

  @override
  String get restorePurchases => 'خریداریاں بحال کریں';

  @override
  String get unlocked => 'کھلا ہوا';

  @override
  String get buy => 'خریدیں';

  @override
  String get poemsButton => 'نظمیں';

  @override
  String get collections => 'مجموعے';

  @override
  String get myPoems => 'میری نظمیں';

  @override
  String get purchaseFailed => 'خریداری ناکام رہی۔';

  @override
  String get purchaseError => 'خریداری میں خرابی۔';

  @override
  String buyWithPrice(String price) {
    return '$price میں خریدیں';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'نظم $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count نظمیں',
      one: '$count نظم',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count بند',
      one: '$count بند',
    );
    return '$_temp0';
  }
}
