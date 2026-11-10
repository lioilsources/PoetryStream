// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get modeStream => 'স্ট্রিম';

  @override
  String get modePoem => 'কবিতা';

  @override
  String get modeReading => 'পড়া';

  @override
  String get noPoems => 'কোনো কবিতা নেই';

  @override
  String get playbackLive => 'লাইভ';

  @override
  String get playbackPaused => 'বিরতি';

  @override
  String get addPoemButton => '+ কবিতা';

  @override
  String get pastePoemTitle => 'কবিতা পেস্ট করুন';

  @override
  String get save => 'সংরক্ষণ';

  @override
  String get pastePoemHint => 'প্রথম লাইন = কবিতার নাম\n\nকবিতার লেখা…';

  @override
  String get storeTitle => 'কবিতা সংকলন';

  @override
  String get storeUnavailable => 'স্টোর পাওয়া যাচ্ছে না। সংযোগ পরীক্ষা করুন।';

  @override
  String get restorePurchases => 'ক্রয় পুনরুদ্ধার';

  @override
  String get unlocked => 'আনলক করা';

  @override
  String get buy => 'কিনুন';

  @override
  String get poemsButton => 'কবিতা';

  @override
  String get collections => 'সংকলন';

  @override
  String get myPoems => 'আমার কবিতা';

  @override
  String get purchaseFailed => 'ক্রয় ব্যর্থ হয়েছে।';

  @override
  String get purchaseError => 'ক্রয়ে ত্রুটি।';

  @override
  String buyWithPrice(String price) {
    return '$price দিয়ে কিনুন';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'কবিতা $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি কবিতা',
      one: '১টি কবিতা',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি স্তবক',
      one: '১টি স্তবক',
    );
    return '$_temp0';
  }
}
