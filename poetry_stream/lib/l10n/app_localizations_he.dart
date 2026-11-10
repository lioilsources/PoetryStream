// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get modeStream => 'זרימה';

  @override
  String get modePoem => 'שיר';

  @override
  String get modeReading => 'קריאה';

  @override
  String get noPoems => 'אין שירים';

  @override
  String get playbackLive => 'שידור חי';

  @override
  String get playbackPaused => 'מושהה';

  @override
  String get addPoemButton => '+ שיר';

  @override
  String get pastePoemTitle => 'הדבקת שיר';

  @override
  String get save => 'שמירה';

  @override
  String get pastePoemHint => 'שורה ראשונה = שם השיר\n\nטקסט השיר…';

  @override
  String get storeTitle => 'קובצי שירה';

  @override
  String get storeUnavailable => 'החנות אינה זמינה. בדקו את החיבור.';

  @override
  String get restorePurchases => 'שחזור רכישות';

  @override
  String get unlocked => 'פתוח';

  @override
  String get buy => 'קנייה';

  @override
  String get poemsButton => 'שירים';

  @override
  String get collections => 'קובצים';

  @override
  String get myPoems => 'השירים שלי';

  @override
  String get purchaseFailed => 'הרכישה נכשלה.';

  @override
  String get purchaseError => 'שגיאה ברכישה.';

  @override
  String buyWithPrice(String price) {
    return 'קנייה ב-$price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'שיר $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      many: '$count שירים',
      other: '$count שירים',
      two: 'שני שירים',
      one: 'שיר אחד',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      many: '$count בתים',
      other: '$count בתים',
      two: 'שני בתים',
      one: 'בית אחד',
    );
    return '$_temp0';
  }
}
