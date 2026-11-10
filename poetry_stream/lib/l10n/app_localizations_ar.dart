// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get modeStream => 'تدفّق';

  @override
  String get modePoem => 'قصيدة';

  @override
  String get modeReading => 'قراءة';

  @override
  String get noPoems => 'لا توجد قصائد';

  @override
  String get playbackLive => 'مباشر';

  @override
  String get playbackPaused => 'إيقاف مؤقت';

  @override
  String get addPoemButton => '+ قصيدة';

  @override
  String get pastePoemTitle => 'لصق قصيدة';

  @override
  String get save => 'حفظ';

  @override
  String get pastePoemHint => 'السطر الأول = عنوان القصيدة\n\nنص القصيدة…';

  @override
  String get storeTitle => 'دواوين الشعر';

  @override
  String get storeUnavailable => 'المتجر غير متاح. تحقّق من اتصالك.';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get unlocked => 'مفتوح';

  @override
  String get buy => 'شراء';

  @override
  String get poemsButton => 'قصائد';

  @override
  String get collections => 'الدواوين';

  @override
  String get myPoems => 'قصائدي';

  @override
  String get purchaseFailed => 'فشلت عملية الشراء.';

  @override
  String get purchaseError => 'خطأ في الشراء.';

  @override
  String buyWithPrice(String price) {
    return 'شراء $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'قصيدة $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count قصيدة',
      many: '$count قصيدة',
      few: '$count قصائد',
      two: 'قصيدتان',
      one: 'قصيدة واحدة',
      zero: 'لا قصائد',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مقطع',
      many: '$count مقطعًا',
      few: '$count مقاطع',
      two: 'مقطعان',
      one: 'مقطع واحد',
      zero: 'لا مقاطع',
    );
    return '$_temp0';
  }
}
