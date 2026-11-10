// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get modeStream => 'สตรีม';

  @override
  String get modePoem => 'บทกวี';

  @override
  String get modeReading => 'อ่าน';

  @override
  String get noPoems => 'ไม่มีบทกวี';

  @override
  String get playbackLive => 'สด';

  @override
  String get playbackPaused => 'หยุดชั่วคราว';

  @override
  String get addPoemButton => '+ บทกวี';

  @override
  String get pastePoemTitle => 'วางบทกวี';

  @override
  String get save => 'บันทึก';

  @override
  String get pastePoemHint => 'บรรทัดแรก = ชื่อบทกวี\n\nเนื้อหาบทกวี…';

  @override
  String get storeTitle => 'รวมบทกวี';

  @override
  String get storeUnavailable => 'ร้านค้าใช้งานไม่ได้ ตรวจสอบการเชื่อมต่อ';

  @override
  String get restorePurchases => 'กู้คืนการซื้อ';

  @override
  String get unlocked => 'ปลดล็อกแล้ว';

  @override
  String get buy => 'ซื้อ';

  @override
  String get poemsButton => 'บทกวี';

  @override
  String get collections => 'ชุดบทกวี';

  @override
  String get myPoems => 'บทกวีของฉัน';

  @override
  String get purchaseFailed => 'การซื้อไม่สำเร็จ';

  @override
  String get purchaseError => 'การซื้อผิดพลาด';

  @override
  String buyWithPrice(String price) {
    return 'ซื้อ $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'บทกวี $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count บท',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count บทย่อย',
    );
    return '$_temp0';
  }
}
